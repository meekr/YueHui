//
//  LoginResult.m
//  FlipBook3D
//
//  Created by Ji Jim on 10/28/12.
//
//

#import "CheckinResult.h"

@implementation CheckinResult
@synthesize shop;
@synthesize customer;
@synthesize customerCoupons;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (int) parseDic :(NSDictionary *) receivedObjects {
    [super parseDic:receivedObjects];
    if(self.error!=nil) {
        return 0;
    }
    
    NSDictionary* data = (NSDictionary*)[receivedObjects objectForKey:@"data"];
    if(data!=nil){
        self.shop = [[[Shop alloc] init] parseDic:[data objectForKey:@"shop"]];
        self.customer = [[[Customer alloc] init] parseDic:[data objectForKey:@"customer"]];
        
        NSArray* coupons = [data objectForKey:@"customerCoupons"];
        if(coupons!=nil){
            for (int i=0; i<coupons.count; i++) {
                [customerCoupons addObject:[[[CustomerCoupon alloc] init]
                                            parseDic:[coupons objectAtIndex:i]]];
            }
        }
    }

    return 0;
}

- (NSString *)description {
    return @"";
}

@end
