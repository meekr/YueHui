//
//  LoginResult.m
//  FlipBook3D
//
//  Created by Ji Jim on 10/28/12.
//
//

#import "Customer.h"


@implementation Customer
//@synthesize SessionId;

@synthesize customer_id;
@synthesize uuid;
@synthesize user_id;
@synthesize real_name;
@synthesize phone;
@synthesize gender;
@synthesize birth_date;
@synthesize email;
@synthesize address;
@synthesize points;
@synthesize last_sign_time;
@synthesize create_shop_id;
@synthesize create_time;
@synthesize register_shop_id;
@synthesize register_date;
@synthesize disabled;
@synthesize level;
@synthesize type;

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
    
    customer_id = (NSString*)[receivedObjects objectForKey:@"customer_id"];
    uuid = (NSString*)[receivedObjects objectForKey:@"uuid"];
    user_id = (NSString*)[receivedObjects objectForKey:@"user_id"];
    real_name = (NSString*)[receivedObjects objectForKey:@"real_name"];
    phone = (NSString*)[receivedObjects objectForKey:@"phone"];
    gender = (NSString*)[receivedObjects objectForKey:@"gender"];
    birth_date = (NSString*)[receivedObjects objectForKey:@"birth_date"];
    email = (NSString*)[receivedObjects objectForKey:@"email"];
    address = (NSString*)[receivedObjects objectForKey:@"address"];
    points = (NSString*)[receivedObjects objectForKey:@"points"];
    last_sign_time = (NSString*)[receivedObjects objectForKey:@"last_sign_time"];
    create_time = (NSString*)[receivedObjects objectForKey:@"create_time"];
    create_shop_id = (NSString*)[receivedObjects objectForKey:@"create_shop_id"];
    register_date = (NSString*)[receivedObjects objectForKey:@"register_date"];
    disabled = (NSString*)[receivedObjects objectForKey:@"disabled"];
    level = (NSString*)[receivedObjects objectForKey:@"level"];
    type = (NSString*)[receivedObjects objectForKey:@"type"];
    return 0;
}


@end
