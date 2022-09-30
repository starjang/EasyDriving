//
//  EDWebBaseConnect.h
//  EasyDriving
//
//  Created by Mason on 2018/11/14.
//  Copyright © 2018 zmx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"
#import "EDUrlHeader.h"
#import "EDWebBaseResponse.h"

//#define REQUEST_NAME @"requestMsg"

NS_ASSUME_NONNULL_BEGIN

typedef void(^EDWebConnectFinishedBlock)(id response);

@interface EDWebBaseConnect : NSObject

+(AFHTTPSessionManager *) getRequestManager;

+(NSString *)getUrl:(NSString *)apiUrl ;

@end

NS_ASSUME_NONNULL_END
