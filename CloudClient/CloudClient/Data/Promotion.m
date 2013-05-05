//
//  LoginResult.m
//  FlipBook3D
//
//  Created by Ji Jim on 10/28/12.
//
//

#import "Promotion.h"


@implementation Promotion

@synthesize promotion_id;
@synthesize shop_id;
@synthesize name;
@synthesize abstract;
@synthesize description;
@synthesize type;
@synthesize image;
@synthesize status;
@synthesize click_count;
@synthesize create_date;
@synthesize update_date;
@synthesize online_date;
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
    
    promotion_id = (NSString*)[receivedObjects objectForKey:@"promotion_id"];
    shop_id = (NSString*)[receivedObjects objectForKey:@"shop_id"];
    name = (NSString*)[receivedObjects objectForKey:@"name"];
    abstract = (NSString*)[receivedObjects objectForKey:@"abstract"];
    description = (NSString*)[receivedObjects objectForKey:@"description"];
    type = (NSString*)[receivedObjects objectForKey:@"type"];
    image = (NSString*)[receivedObjects objectForKey:@"image"];
    status = (NSString*)[receivedObjects objectForKey:@"status"];
    click_count = (NSString*)[receivedObjects objectForKey:@"click_count"];
    create_date = (NSString*)[receivedObjects objectForKey:@"create_date"];
    update_date = (NSString*)[receivedObjects objectForKey:@"update_date"];
    online_date = (NSString*)[receivedObjects objectForKey:@"online_date"];
    onoff_id = (NSString*)[receivedObjects objectForKey:@"onoff_id"];
    disabled = (NSString*)[receivedObjects objectForKey:@"disabled"];
    order_num = (NSString*)[receivedObjects objectForKey:@"order_num"];
    
    return 0;
}


@end
