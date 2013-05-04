//
//  CloudClient.h
//  FlipBook3D
//
//  Created by Ji Jim on 10/20/12.
//
//

#import <Foundation/Foundation.h>
#import "ShopResult.h"
#import "CheckinResult.h"

@interface CloudClient : NSObject

+(void) initialize;
//
//+ (id)callServerMethodByPost: (NSString*) queryString paramDic: (NSMutableDictionary*) paramDic;
//+ (NSDictionary*)callServerMethodByGet: (NSString*) queryString paramDic: (NSMutableDictionary*) paramDic;
//
//+(LoginResult*)signup: (NSString*) email password: (NSString*) password appId:(NSString*)appId;
//+(LoginResult*)login: (NSString*) email password: (NSString*) password appId:(NSString*)addId;
//+(Result*)setObjByGet: (NSString*) objId value: (NSString*) value sessionId:(NSString*)sessionId;
//+(NSString*)getObjValue: (NSString*) objId sessionId:(NSString*)sessionId;

+(ShopResult*)getShop: (NSString*) shopId;
+(CheckinResult*)customerCheckin: (NSString*) uuid token:(NSString*) token;

@end
