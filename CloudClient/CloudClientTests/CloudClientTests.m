//
//  FlipInkCloudClientTests.m
//  FlipInkCloudClientTests
//
//  Created by Ji Jim on 3/12/13.
//  Copyright (c) 2013 FlipInk. All rights reserved.
//

#import "CloudClientTests.h"

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
    
    // login
    //    loginResult = [CloudClient login:@"tx7@sina.com" password:@"!@#$%^&1234567*()890" appId:@"i001"];
    //    DLog(@"loginResult: %@", loginResult);
    //    STAssertTrue([loginResult.Status isEqualToString:@"OK"], @"login");
    //    STAssertTrue(![loginResult.SessionId isEqualToString:sessionId], @"login");
    
}
@end
