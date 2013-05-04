//
//  CloudClient.m
//  FlipBook3D
//
//  Created by Ji Jim on 10/20/12.
//
//
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "CloudClient.h"
//#import "JSONKit.h"
#import "SBJson.h"



static NSString* CloudAppAddress;

@implementation CloudClient

+(void) initialize
{
    if (!CloudAppAddress)
        CloudAppAddress = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CloudAppAddress"];
    DLog(@"CloudAppAddress: %@",CloudAppAddress);
    //HOST = @"http://localhost/~perry/";
    //http://192.168.1.101:4500/Service/
    if (CloudAppAddress==nil) {
        CloudAppAddress= @"http://192.168.1.102:89/s/index.php";
        
    }
}

#pragma mark - basic methods
+ (NSDictionary*)callServerMethodByGet: (NSString*) queryString
                             paramList: (NSMutableArray*) paramList{
    NSString* response =[NSString stringWithFormat:@"%@",  [CloudClient callServerMethodByGetForRawContent:queryString paramList:paramList]];

    DLog(response);
    NSDictionary* dir = [response JSONValue];
    return dir;
}

+ (NSString*)callServerMethodByGetForRawContent: (NSString*) queryString
                                       paramList: (NSMutableArray*) paramList{
    ASIFormDataRequest *requestPost = [ASIFormDataRequest requestWithURL:nil];
//
    NSString *query = @"";
    if (paramList!=nil) {
        for(NSString* v in paramList){
            query=[NSString stringWithFormat:@"%@/%@",query,
                   [requestPost encodeURL:v]];
        }
    }
    
    if (queryString==nil) {
        queryString = @"";
    }
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",
                                       CloudAppAddress, queryString, query ]];
    DLog(@"URL: %@",url);
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    NSMutableDictionary* header = [[[NSMutableDictionary alloc]initWithCapacity:1]autorelease];
    
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
    [header setObject:@"application/json" forKey:@"Content-Type"];
    [header setObject:@"utf-8" forKey:@"Accept-Charset"];
    [header setObject:@"application/json" forKey:@"Accept"];
    [request setRequestHeaders:header];

    
    [request startSynchronous];
    
    NSError *error = [request error];
    if (error) {
        DLog(@"ASIHTTP error: %@",error);
        return nil;
    }
    NSString *response = [request responseString];
//    NSDictionary* d = [request responseHeaders];
    
    DLog(@"response from server: %@",response);
    return response;
}


#pragma mark - client methods

+(ShopResult*)getShop: (NSString*) shopId{
    if (shopId==nil ) {
        ShopResult* r = [[ShopResult alloc] init];
        r.error = [[ErrorResult alloc]init];
        r.error.message=@"param cannot be NULL";
        return r;
    }
    
    NSMutableArray* params = [[NSMutableArray alloc]init];
    [params addObject:@"1"];
    
    NSDictionary* responseDic = [CloudClient callServerMethodByGet:@"/Get/ShopByShopId"
                                                         paramList:params];
    ShopResult* r = [[ShopResult alloc] init];
    [r parseDic:responseDic];
    return r;
}


+(CheckinResult*)customerCheckin: (NSString*) uuid token:(NSString*) token{
    if (uuid==nil || token==nil) {
        CheckinResult* r = [[CheckinResult alloc] init];
        r.error = [[ErrorResult alloc]init];
        r.error.message=@"param cannot be NULL";
        return r;
    }
    
    NSMutableArray* params = [[NSMutableArray alloc]init];
    [params addObject:token];
    [params addObject:uuid];
    
    NSDictionary* responseDic = [CloudClient callServerMethodByGet:@"/Service/CustomerCheckin"
                                                         paramList:params];
    CheckinResult* r = [[CheckinResult alloc] init];
    [r parseDic:responseDic];
    return r;
}

@end
