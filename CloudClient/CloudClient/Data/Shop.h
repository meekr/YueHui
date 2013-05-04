//
//  LoginResult.h
//  FlipBook3D
//
//  Created by Ji Jim on 10/28/12.
//
//

@interface Shop : NSObject

@property (nonatomic,retain) NSString*  shop_id;
@property (nonatomic,retain) NSString*  name;
@property (nonatomic,retain) NSString*  logo;
@property (nonatomic,retain) NSString*  abstract;
@property (nonatomic,retain) NSString*  tel ;
@property (nonatomic,retain) NSString*  address ;
@property (nonatomic,retain) NSString*  status ;
@property (nonatomic,retain) NSString*  enable;
@property (nonatomic,retain) NSString*  sign_points ;

- (int) parseDic :(NSDictionary *) receivedObjects;

@end
