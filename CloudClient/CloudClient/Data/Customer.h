//
//  LoginResult.h
//  FlipBook3D
//
//  Created by Ji Jim on 10/28/12.
//
//

@interface Customer : NSObject

@property (nonatomic,retain) NSString* customer_id;
@property (nonatomic,retain) NSString* uuid;
@property (nonatomic,retain) NSString* user_id;
@property (nonatomic,retain) NSString* real_name;
@property (nonatomic,retain) NSString* phone;
@property (nonatomic,retain) NSString* gender;
@property (nonatomic,retain) NSString* birth_date;
@property (nonatomic,retain) NSString* email;
@property (nonatomic,retain) NSString* address;
@property (nonatomic,retain) NSString* points;
@property (nonatomic,retain) NSString* last_sign_time;
@property (nonatomic,retain) NSString* create_shop_id;
@property (nonatomic,retain) NSString* create_time;
@property (nonatomic,retain) NSString* register_shop_id;
@property (nonatomic,retain) NSString* register_date;
@property (nonatomic,retain) NSString* disabled;
@property (nonatomic,retain) NSString* level;
@property (nonatomic,retain) NSString* type;

- (int) parseDic :(NSDictionary *) receivedObjects;

@end
