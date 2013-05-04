//
//  Result.h
//  FlipBook3D
//
//  Created by Ji Jim on 10/28/12.
//
//

#import <Foundation/Foundation.h>
#import "ErrorResult.h"

@interface Result : NSObject

@property (nonatomic, retain) ErrorResult* error;
//@property (nonatomic, retain) NSString* Desc;

- (int) parseDic :(NSDictionary *) receivedObjects;
    
@end
