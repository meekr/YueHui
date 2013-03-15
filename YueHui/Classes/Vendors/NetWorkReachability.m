

#import <SystemConfiguration/SystemConfiguration.h>
#import <netinet/in.h>

#import "NetworkReachability.h"

#define IS_REACHABLE(__FLAGS__) (((__FLAGS__) & kSCNetworkFlagsReachable) && !((__FLAGS__) & kSCNetworkFlagsConnectionRequired))

@implementation NetworkReachability

@synthesize delegate=_delegate;

static void _ReachabilityCallBack(SCNetworkReachabilityRef target, SCNetworkConnectionFlags flags, void* info)
{
	//NSAutoreleasePool*              pool = [NSAutoreleasePool new];
	NetworkReachability*    self = (__bridge NetworkReachability*)info;
	
	[self->_delegate networkReachabilityDidUpdate:self];
	
	//[pool release];
}

- (id) _initWithNetworkReachability:(SCNetworkReachabilityRef)reachability
{
	if(reachability == NULL) {
		//[self release];
		return nil;
	}
	
	if((self = [super init])) {
		_runLoop = (CFRunLoopRef)CFRetain(CFRunLoopGetMain());
		_reachability = (void*)reachability;
	}
	
	return self;
}

- (id) init
{
	return [self initWithIPv4Address:INADDR_ANY];
}

- (id) initWithAddress:(const struct sockaddr*)address
{
	return [self _initWithNetworkReachability:(address ? SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, address) : NULL)];
}

- (id) initWithIPv4Address:(UInt32)address
{
	struct sockaddr_in                              ipAddress;
	
	bzero(&ipAddress, sizeof(ipAddress));
	ipAddress.sin_len = sizeof(ipAddress);
	ipAddress.sin_family = AF_INET;
	ipAddress.sin_addr.s_addr = htonl(address);
	
	return [self initWithAddress:(struct sockaddr*)&ipAddress];
}

- (id) initWithHostName:(NSString*)name
{
	return [self _initWithNetworkReachability:([name length] ? SCNetworkReachabilityCreateWithName(kCFAllocatorDefault, [name UTF8String]) : NULL)];
}
/*
- (void) dealloc
{
	[self setDelegate:nil];
	
	if(_runLoop)
        CFRelease(_runLoop);
	if(_reachability)
        CFRelease(_reachability);
	
	[super dealloc];
}*/

- (BOOL) isReachable
{
	SCNetworkConnectionFlags                flags;
	
	return (SCNetworkReachabilityGetFlags(_reachability, &flags) && IS_REACHABLE(flags) ? YES : NO);
}

-(BOOL) IsWifi
{
	SCNetworkConnectionFlags                flags;	
    SCNetworkReachabilityGetFlags(_reachability, &flags);
//    KTLog(@"res = %i falgs=%i", res, flags);
    return (flags&kSCNetworkReachabilityFlagsIsWWAN) ? NO : YES;
}

- (void) setDelegate:(id<NetworkReachabilityDelegate>)delegate
{
	SCNetworkReachabilityContext    context = {0, (__bridge void*)self, NULL, NULL, NULL};
	
	if(delegate && !_delegate) {
		if(SCNetworkReachabilitySetCallback(_reachability, _ReachabilityCallBack, &context)) {
			if(!SCNetworkReachabilityScheduleWithRunLoop(_reachability, _runLoop, kCFRunLoopCommonModes)) {
				SCNetworkReachabilitySetCallback(_reachability, NULL, NULL);
				delegate = nil;
			}
		}
		else
			delegate = nil;
		//if(delegate == nil)
			//NSLOG(@"%s: Failed installing SCNetworkReachability callback on runloop %p", __FUNCTION__, _runLoop);
	}
	else if(!delegate && _delegate) {
		SCNetworkReachabilityUnscheduleFromRunLoop(_reachability, _runLoop, kCFRunLoopCommonModes);
		SCNetworkReachabilitySetCallback(_reachability, NULL, NULL);
	}
	
	_delegate = delegate;
}

- (BOOL) isConnectionRequired {
	
	NSAssert(_reachability, @"isConnectionRequired called with NULL reachabilityRef");
	
	SCNetworkReachabilityFlags flags;
	
	if (SCNetworkReachabilityGetFlags(_reachability, &flags)) {
		
//		logReachabilityFlags(flags);
		
		return (flags & kSCNetworkReachabilityFlagsConnectionRequired);
        
	}
	
	return NO;
	
} // isConnectionRequired

@end