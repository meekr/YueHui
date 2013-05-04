//
//  FlipInkCloudClientTests.m
//  FlipInkCloudClientTests
//
//  Created by Ji Jim on 3/12/13.
//  Copyright (c) 2013 FlipInk. All rights reserved.
//

#import "CloudClientTests.h"
#import "JSONKit.h"
#import "ShopResult.h"
#import "CheckinResult.h"

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
    DLog(@"getShop: %@", r);
    STAssertTrue(r.error ==nil, @"getShop no error.");
    STAssertEqualObjects(r.shop.shop_id, @"1", @"shop id");
}


-(void) testCheckin{
    NSString* uuid = gen_uuid();
    CheckinResult* r = [CloudClient customerCheckin: uuid
                                           token:@"110"];
    DLog(@"customerCheckin: %@", r);
    STAssertTrue(r.error ==nil, @"customerCheckin no error.");
    STAssertEqualObjects(r.shop.shop_id, @"1", @"shop id");
    STAssertEqualObjects(r.customer.uuid, uuid, @"customer");
    STAssertTrue(r.customerCoupons.count>0, @"shop id");
    STAssertEqualObjects(((CustomerCoupon*)[r.customerCoupons objectAtIndex:0]).shop_id,@"1", @"shop id");
    STAssertEqualObjects(((CustomerCoupon*)[r.customerCoupons objectAtIndex:0]).status, @"1", @"shop id");
}

-(void) t{
}

NSString* gen_uuid()
{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    CFRelease(uuid_ref);
    NSString *uuid = [NSString stringWithString:(NSString*)uuid_string_ref];
    CFRelease(uuid_string_ref);
    return uuid;
}
@end
