//
//  DPWebBaseConnect.m
//  EasyDriving
//
//  Created by Mason on 2018/11/14.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "EDWebBaseConnect.h"

@implementation EDWebBaseConnect

static AFHTTPSessionManager *manager ;

+ (AFHTTPSessionManager *)getRequestManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    });
    return manager;
}

+ (NSString *)getUrl:(NSString *)apiUrl {
    
    return [NSString stringWithFormat:@"%@%@",API_BASE_IP,apiUrl];
}

@end
