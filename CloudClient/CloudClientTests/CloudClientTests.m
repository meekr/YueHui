//
//  FlipInkCloudClientTests.m
//  FlipInkCloudClientTests
//
//  Created by Ji Jim on 3/12/13.
//  Copyright (c) 2013 FlipInk. All rights reserved.
//

#import "CloudClientTests.h"
#import "JSONKit.h"

@implementation CloudClientTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}
//
//- (void)testExample
//{
//    STFail(@"Unit tests are not implemented yet in FlipInkCloudClientTests");
//}


-(void) testGet{
    ShopResult* r = [CloudClient getShop:@"1"];
    DLog(@"loginResult: %@", r);
    STAssertTrue(r.error ==nil, @"loginResult.Status==@\"OK\"");
    STAssertEqualObjects(r.shopList.count, 1, @"shop count");
    STAssertEqualObjects(((Shop*)[r.shopList objectAtIndex:0]).shop_id , @"1", @"shop id");
}

-(void) t{
}
@end
