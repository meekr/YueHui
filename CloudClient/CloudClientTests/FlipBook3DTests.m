//
//  FlipBook3DTests.m
//  FlipBook3DTests
//
//  Created by Ji Jim on 10/22/12.
//
//

#import "FlipBook3DTests.h"


@implementation FlipBook3DTests

- (void)setUp
{
    [super setUp];
    [CloudClient initialize];
    
    //    [CloudClient callServerMethodByGet:@"m=cleardb" paramDic:nil];
    
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

-(void) testGet{
    ShopResult* r = [CloudClient getShop:@"!"];
    DLog(@"loginResult: %@", r);
    STAssertTrue(r.error ==nil, @"loginResult.Status==@\"OK\"");
    
    // login
//    loginResult = [CloudClient login:@"tx7@sina.com" password:@"!@#$%^&1234567*()890" appId:@"i001"];
//    DLog(@"loginResult: %@", loginResult);
//    STAssertTrue([loginResult.Status isEqualToString:@"OK"], @"login");
//    STAssertTrue(![loginResult.SessionId isEqualToString:sessionId], @"login");
    
}


//
//- (void)testLogin
//{
////    [CloudClient callServerMethodByPost:@"m=cleardb" paramDic:nil];
//
////    NSMutableDictionary* dic = [[NSMutableDictionary alloc] init];
////    [dic setObject:@"t@gmail.com" forKey:@"email"];
////    [dic setObject:@"123456" forKey:@"password"];
////    [dic setObject:@"1001" forKey:@"appid"];
////    NSDictionary* responseDic = [CloudClient callServerMethodByGet:@"m=signup" paramDic:dic];
////    LoginResult* loginResult = [[LoginResult alloc] init];
////    [loginResult parseDic:responseDic];
////
////    dic = [[NSMutableDictionary alloc] init];
////    [dic setObject:@"t@gmail.com" forKey:@"email"];
////    [dic setObject:@"123456" forKey:@"password"];
////    [dic setObject:@"1001" forKey:@"appid"];
////    [CloudClient callServerMethodByGet:@"m=login" paramDic:dic];
//
////        STFail(@"Unit tests are not implemented yet in FlipBookTests");
//
//    LoginResult* loginResult = [CloudClient signup:@"tx7@sina.com" password:@"!@#$%^&1234567*()890" appId:@"i001"];
//    DLog(@"loginResult: %@", loginResult);
//    STAssertTrue([loginResult.Status isEqualToString:@"OK"], @"loginResult.Status==@\"OK\"");
//    NSString *sessionId=    loginResult.SessionId;
//
//    // login
//    loginResult = [CloudClient login:@"tx7@sina.com" password:@"!@#$%^&1234567*()890" appId:@"i001"];
//    DLog(@"loginResult: %@", loginResult);
//    STAssertTrue([loginResult.Status isEqualToString:@"OK"], @"login");
//    STAssertTrue(![loginResult.SessionId isEqualToString:sessionId], @"login");
//
//
//    // already exist
//    loginResult = [CloudClient signup:@"tx7@sina.com" password:@"qwertyuiop[|}{P)(*&^%" appId:@"i001"];
//    DLog(@"loginResult: %@", loginResult);
//    STAssertTrue([loginResult.Status isEqualToString:@"ERROR"], @"signup");
//    NSRange exceptionPosition = [loginResult.Desc rangeOfString:@"email already exist"];
//    STAssertTrue(exceptionPosition.location!=NSNotFound, @"signup");
//
//
//    // user and password not matche.
//    loginResult = [CloudClient login:@"tx7@sina.com" password:@"wrong password" appId:@"i001"];
//    DLog(@"loginResult: %@", loginResult);
//    STAssertTrue([loginResult.Status isEqualToString:@"ERROR"], @"login");
//    exceptionPosition = [loginResult.Desc rangeOfString:@"Email and password are not matched"];
//    STAssertTrue(exceptionPosition.location!=NSNotFound, @"login");
//
//
//    // login with not exist user name.
//    loginResult = [CloudClient login:@"notSignedUser@sina.com" password:@"wrong password" appId:@"i001"];
//    DLog(@"loginResult: %@", loginResult);
//    STAssertTrue([loginResult.Status isEqualToString:@"ERROR"], @"login");
//    exceptionPosition = [loginResult.Desc rangeOfString:@"User does not exist"];
//    STAssertTrue(exceptionPosition.location!=NSNotFound, @"login");
//
//
//    /*
//     * test parameters
//     */
//    loginResult = [CloudClient signup:nil password:@"wrong password" appId:@"i001"];
//    DLog(@"loginResult: %@", loginResult);
//    STAssertTrue([loginResult.Status isEqualToString:@"ERROR"], @"login");
//    exceptionPosition = [loginResult.Desc rangeOfString:@"params cannot be null"];
//    STAssertTrue(exceptionPosition.location!=NSNotFound, @"signup");
//}
//
//
//- (void)testObj
//{
//    LoginResult* loginResult = [CloudClient signup:@"objTester@sina.com" password:@"!@#$%^&1234567*()890" appId:@"i001"];
//    DLog(@"loginResult: %@", loginResult);
//    STAssertTrue([loginResult.Status isEqualToString:@"OK"], @"loginResult.Status==@\"OK\"");
//    NSString *sessionId=    loginResult.SessionId;
//
//    Result* result = [CloudClient setObjByGet:@"001" value:@"set obj by get 1234567*&^%$#@!" sessionId:sessionId];
//    DLog(@"loginResult: %@", loginResult);
//    STAssertTrue([result.Status isEqualToString:@"OK"], @"loginResult.Status==@\"OK\"");
//
//    NSString* response = [CloudClient getObjValue:@"001" sessionId:sessionId];
//    DLog(@"loginResult: %@", loginResult);
//    STAssertTrue([response isEqualToString:@"set obj by get 1234567*&^%$#@!"], @"getObj");
//}


@end
