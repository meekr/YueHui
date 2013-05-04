//
//  LoginResult.h
//  FlipBook3D
//
//  Created by Ji Jim on 10/28/12.
//
//

@interface CustomerCoupon : NSObject

@property (nonatomic,retain) NSString* customer_coupon_id;
@property (nonatomic,retain) NSString* customer_id;
@property (nonatomic,retain) NSString* shop_id;
@property (nonatomic,retain) NSString* coupon_id;
@property (nonatomic,retain) NSString* coupon_number;
@property (nonatomic,retain) NSString* received_date;
@property (nonatomic,retain) NSString* consume_id;
@property (nonatomic,retain) NSString* consume_date;

//
@property (nonatomic,retain) NSString* coupon_image;
@property (nonatomic,retain) NSString* coupon_name;
@property (nonatomic,retain) NSString* prefix_number;
@property (nonatomic,retain) NSString* total_count;
@property (nonatomic,retain) NSString* release_count;
@property (nonatomic,retain) NSString* status;
@property (nonatomic,retain) NSString* valid_date;
@property (nonatomic,retain) NSString* create_date;
@property (nonatomic,retain) NSString* update_date;
@property (nonatomic,retain) NSString* onoff_id;
@property (nonatomic,retain) NSString* disabled;
@property (nonatomic,retain) NSString* order_num;

- (int) parseDic :(NSDictionary *) receivedObjects;

@end
