//
//  Result.m
//  FlipBook3D
//
//  Created by Ji Jim on 10/28/12.
//
//

#import "Result.h"

@implementation Result
@synthesize error;
//@synthesize Desc;

- (id)init{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}


- (int) parseDic :(NSDictionary *) receivedObjects {
    NSObject* o = (NSString *) [receivedObjects objectForKey:@"error"];
    if([o isEqual:[NSNull null]] == NO) {
        self.error = [[ErrorResult alloc] init];
        self.error.code = [((NSDictionary*)o) objectForKey:@"code"];
        self.error.message = [((NSDictionary*)o) objectForKey:@"message"];
    }
    else{
        self.error=nil;
    }
    return 0;
}


- (NSString *)description {
    return [NSString stringWithFormat: @"error=%@", self.error];
}

@end
