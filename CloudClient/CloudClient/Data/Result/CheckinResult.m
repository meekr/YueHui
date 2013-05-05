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
@synthesize promotions;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        customerCoupons = [[NSMutableArray alloc] init];
        promotions = [[NSMutableArray alloc] init];
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
        self.shop = [[Shop alloc] init];
        [self.shop parseDic:[data objectForKey:@"shop"]];
        self.customer = [[Customer alloc] init];
        [self.customer  parseDic:[data objectForKey:@"customer"]];
        
        NSArray* coupons = [data objectForKey:@"customerCoupons"];
        if(coupons!=nil){
            for (int i=0; i<coupons.count; i++) {
                CustomerCoupon* c = [[CustomerCoupon alloc] init];
                [c parseDic:[coupons objectAtIndex:i]];
                [customerCoupons addObject:c];
            }
        }
        
        NSArray* promotionJsons = [data objectForKey:@"promotions"];
        if(promotionJsons!=nil){
            for (int i=0; i<promotionJsons.count; i++) {
                Promotion* p = [[Promotion alloc] init];
                [p parseDic:[promotionJsons objectAtIndex:i]];
                [promotions addObject:p];
            }
        }
    }

    return 0;
}

- (NSString *)description {
    return @"";
}

@end
