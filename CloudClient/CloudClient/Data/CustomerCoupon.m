//
//  LoginResult.m
//  FlipBook3D
//
//  Created by Ji Jim on 10/28/12.
//
//

#import "CustomerCoupon.h"


@implementation CustomerCoupon
//@synthesize  SessionId;

@synthesize customer_coupon_id;
@synthesize customer_id;
@synthesize shop_id;
@synthesize coupon_id;
@synthesize coupon_number;
@synthesize received_date;
@synthesize consume_id;
@synthesize consume_date;

//
@synthesize coupon_image;
@synthesize coupon_name;
@synthesize prefix_number;
@synthesize total_count;
@synthesize release_count;
@synthesize status;
@synthesize valid_date;
@synthesize create_date;
@synthesize update_date;
@synthesize onoff_id;
@synthesize disabled;
@synthesize order_num;


- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}


- (int) parseDic :(NSDictionary *) receivedObjects {
    if(receivedObjects==nil)
        return -1;
    
    customer_coupon_id = (NSString*)[receivedObjects objectForKey:@"customer_coupon_id"];
    customer_id = (NSString*)[receivedObjects objectForKey:@"customer_id"];
    shop_id = (NSString*)[receivedObjects objectForKey:@"shop_id"];
    coupon_id = (NSString*)[receivedObjects objectForKey:@"coupon_id"];
    coupon_number = (NSString*)[receivedObjects objectForKey:@"coupon_number"];

    received_date = (NSString*)[receivedObjects objectForKey:@"received_date"];
    consume_id = (NSString*)[receivedObjects objectForKey:@"consume_id"];
    consume_date = (NSString*)[receivedObjects objectForKey:@"consume_date"];
    
    coupon_image = (NSString*)[receivedObjects objectForKey:@"coupon_image"];
    coupon_name = (NSString*)[receivedObjects objectForKey:@"coupon_name"];
    prefix_number = (NSString*)[receivedObjects objectForKey:@"prefix_number"];
    total_count = (NSString*)[receivedObjects objectForKey:@"total_count"];
    release_count = (NSString*)[receivedObjects objectForKey:@"release_count"];
    status = (NSString*)[receivedObjects objectForKey:@"status"];
    
    valid_date = (NSString*)[receivedObjects objectForKey:@"valid_date"];
    create_date = (NSString*)[receivedObjects objectForKey:@"create_date"];
    update_date = (NSString*)[receivedObjects objectForKey:@"update_date"];
    onoff_id = (NSString*)[receivedObjects objectForKey:@"onoff_id"];
    disabled = (NSString*)[receivedObjects objectForKey:@"disabled"];
    order_num = (NSString*)[receivedObjects objectForKey:@"order_num"];
    return 0;
}


@end
