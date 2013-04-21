//
//  LoginResult.m
//  FlipBook3D
//
//  Created by Ji Jim on 10/28/12.
//
//

#import "ShopResult.h"


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
@end

@implementation ShopResult
@synthesize shopList;


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
    NSArray* shops =    ((NSArray*)[receivedObjects objectForKey:@"data"]);
    if (shops.count>0){
        
        shopList = [[NSMutableArray alloc]init];
        Shop* shop = [[Shop alloc]init];
        shop.shop_id = (NSString*)[receivedObjects objectForKey:@"shop_id"];
        shop.name = (NSString*)[receivedObjects objectForKey:@"name"];
        shop.logo = (NSString*)[receivedObjects objectForKey:@"logo"];
        shop.abstract = (NSString*)[receivedObjects objectForKey:@"abstract"];
        shop.tel = (NSString*)[receivedObjects objectForKey:@"tel"];
        shop.address = (NSString*)[receivedObjects objectForKey:@"address"];
        shop.status = (NSString*)[receivedObjects objectForKey:@"status"];
        shop.enable = (NSString*)[receivedObjects objectForKey:@"enable"];
        shop.sign_points = (NSString*)[receivedObjects objectForKey:@"sign_points"];
        [shopList addObject:shop];
    }
    return 0;
}

- (NSString *)description {
    if(self.shopList.count>0){
        return [NSString stringWithFormat: @"%@, shop_id=%@",
                [super description], ((Shop*)[self.shopList objectAtIndex:0]).shop_id];
    }
    else{
        return [NSString stringWithFormat: @"%@, count=%d",
                [super description], self.shopList.count];
    }
}

@end
