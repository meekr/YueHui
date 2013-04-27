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
//    ShopResult* r = [CloudClient getShop:@"1"];
//    DLog(@"loginResult: %@", r);
//    STAssertTrue(r.error ==nil, @"loginResult.Status==@\"OK\"");
    
    // login
    //    loginResult = [CloudClient login:@"tx7@sina.com" password:@"!@#$%^&1234567*()890" appId:@"i001"];
    //    DLog(@"loginResult: %@", loginResult);
    //    STAssertTrue([loginResult.Status isEqualToString:@"OK"], @"login");
    //    STAssertTrue(![loginResult.SessionId isEqualToString:sessionId], @"login");
    
    NSString* json = @"{\"error\":null, \"data\": [{\"shop_id\": \"1\",\"name\": \"商店管理员\",\"logo\": \"1.png\",\"stract\": \"qwewewe\",\"tel\": \"88762234\",\"address\": \"beijing sdf\",\"status\": \"0\",\"enable\": \"0\",\"create_date\": null,\"sign_points\": \"100\"}]}";
//    json = @"﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿{ "
//+@"      \"error\": null,"
//+@"      \"data\": ["
//+@"         {"
//+@"             \"shop_id\": \"1\",
//+@"             \"name\": \"商店管理员\",
//+@"             \"logo\": \"1.png\",
//+@"             \"abstract\": \"qwewewe\",
//+@"             \"tel\": \"88762234\",
//+@"             \"address\": \"beijing sdf\"
//+@"            }]} ";

    json = @"{\"error\":null,\n \"data\": \n[\n{\"shop_id\": \"1\",\n\"name\": \"商店管理员\",\n\"logo\": \"1.png\",\n\"stract\": \"qwewewe\",\n\"tel\": \"88762234\",\"address\": \"beijing sdf\",\"status\": \"0\",\n\"enable\": \"0\",\n\"create_date\": null,\n\"sign_points\": \"100\"}]}";

    
    NSDictionary* d = [json objectFromJSONString];

}

-(void) t{
}
@end
