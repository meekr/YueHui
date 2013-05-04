//
//  LoginResult.m
//  FlipBook3D
//
//  Created by Ji Jim on 10/28/12.
//
//
#import "Shop.h"
#import "ShopResult.h"

@implementation ShopResult
@synthesize shop;


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
    NSObject* data = [receivedObjects objectForKey:@"data"];
    if (data!=nil) {
        NSDictionary* shopDic = (NSDictionary*)data;
        self.shop = [[Shop alloc]init];
        [self.shop parseDic:shopDic];
    }
    
    return 0;
}

- (NSString *)description {
    return self.shop.description;
}

@end
