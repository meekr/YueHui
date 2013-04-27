//
//  CloudClient.m
//  FlipBook3D
//
//  Created by Ji Jim on 10/20/12.
//
//

#import "CloudClient.h"
#import "JSONKit.h"


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
        CloudAppAddress= @"http://192.168.1.100:89/s/index.php";
        
    }
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

#pragma mark - basic methods
+ (NSDictionary*)callServerMethodByGet: (NSString*) queryString
                             paramList: (NSMutableArray*) paramList{
    NSString* response = [CloudClient callServerMethodByGetForRawContent:queryString paramList:paramList];
   
    NSDictionary* dir = [response objectFromJSONString];
    return dir;
}

+ (NSString*)callServerMethodByGetForRawContent: (NSString*) queryString
                                       paramList: (NSMutableArray*) paramList{
    ASIFormDataRequest *requestPost = [ASIFormDataRequest requestWithURL:nil];
    
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
    
    [request startSynchronous];
    
    NSError *error = [request error];
    if (error) {
        DLog(@"ASIHTTP error: %@",error);
        return nil;
    }
    NSString *response = [request responseString];
    
    DLog(@"response from server: %@",response);
    return response;
}


@end
