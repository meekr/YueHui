//
//  LoginResult.m
//  FlipBook3D
//
//  Created by Ji Jim on 10/28/12.
//
//

#import "Shop.h"


@implementation Shop
//@synthesize SessionId;

@synthesize  shop_id;
@synthesize  name ;
@synthesize  logo ;
@synthesize  abstract ;
@synthesize  tel ;
@synthesize  address;
@synthesize  status;
@synthesize  enable ;
@synthesize  sign_points ;

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
    
    shop_id = (NSString*)[receivedObjects objectForKey:@"shop_id"];
    name = (NSString*)[receivedObjects objectForKey:@"name"];
    logo = (NSString*)[receivedObjects objectForKey:@"logo"];
    abstract = (NSString*)[receivedObjects objectForKey:@"abstract"];
    tel = (NSString*)[receivedObjects objectForKey:@"tel"];
    address = (NSString*)[receivedObjects objectForKey:@"address"];
    status = (NSString*)[receivedObjects objectForKey:@"status"];
    enable = (NSString*)[receivedObjects objectForKey:@"enable"];
    sign_points = (NSString*)[receivedObjects objectForKey:@"sign_points"];
    return 0;
}


@end
