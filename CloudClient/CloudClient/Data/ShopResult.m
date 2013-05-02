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
        NSDictionary* shopDic = [shops objectAtIndex:0];
        shopList = [[NSMutableArray alloc]init];
        Shop* shop = [[Shop alloc]init];
        shop.shop_id = (NSString*)[shopDic objectForKey:@"shop_id"];
        shop.name = (NSString*)[shopDic objectForKey:@"name"];
        shop.logo = (NSString*)[shopDic objectForKey:@"logo"];
        shop.abstract = (NSString*)[shopDic objectForKey:@"abstract"];
        shop.tel = (NSString*)[shopDic objectForKey:@"tel"];
        shop.address = (NSString*)[shopDic objectForKey:@"address"];
        shop.status = (NSString*)[shopDic objectForKey:@"status"];
        shop.enable = (NSString*)[shopDic objectForKey:@"enable"];
        shop.sign_points = (NSString*)[shopDic objectForKey:@"sign_points"];
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
