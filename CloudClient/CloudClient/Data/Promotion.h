//
//  LoginResult.h
//  FlipBook3D
//
//  Created by Ji Jim on 10/28/12.
//
//

@interface Promotion : NSObject

@property (nonatomic,retain) NSString* promotion_id;
@property (nonatomic,retain) NSString* shop_id;
@property (nonatomic,retain) NSString* name;
@property (nonatomic,retain) NSString* abstract;
@property (nonatomic,retain) NSString* description;
@property (nonatomic,retain) NSString* type;
@property (nonatomic,retain) NSString* image;
@property (nonatomic,retain) NSString* status;
@property (nonatomic,retain) NSString* click_count;
@property (nonatomic,retain) NSString* create_date;
@property (nonatomic,retain) NSString* update_date;
@property (nonatomic,retain) NSString* online_date;
@property (nonatomic,retain) NSString* onoff_id;
@property (nonatomic,retain) NSString* disabled;
@property (nonatomic,retain) NSString* order_num;

- (int) parseDic :(NSDictionary *) receivedObjects;

@end
