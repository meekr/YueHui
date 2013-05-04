//
//  LoginResult.h
//  FlipBook3D
//
//  Created by Ji Jim on 10/28/12.
//
//

#import "Result.h"
#import "Shop.h"
#import "Customer.h"
#import "CustomerCoupon.h"

@interface CheckinResult : Result

@property (nonatomic,retain) Shop*  shop;
@property (nonatomic,retain) Customer*  customer;
//@property (nonatomic,retain) CustomerCoupon*  customerCoupon;
@property (nonatomic,retain) NSMutableArray*  customerCoupons;

//@property (nonatomic,retain) Shop*  shop;

//- (int) parseDic :(NSDictionary *) receivedObjects;

@end
