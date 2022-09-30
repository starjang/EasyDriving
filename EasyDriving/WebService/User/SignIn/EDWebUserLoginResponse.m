//
//  EDUserLoginResponse.m
//  EasyDriving
//
//  Created by Mason on 2018/11/14.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "EDWebUserLoginResponse.h"
#import "EDUserInfo.h"

@implementation EDWebUserLoginResponse

+ (instancetype)parseResponse:(id)responseBody {
    
    EDWebUserLoginResponse *response = [[EDWebUserLoginResponse alloc]init];
    
    NSDictionary *msgBody = [response parse:responseBody];
    
    if (response.isSuccess) {
    
        EDUserInfo *info = [[EDUserInfo alloc] init];
        info.userId = msgBody[@"userId"];
        info.username = msgBody[@"username"];
        info.password = msgBody[@"password"];
        info.nickname = msgBody[@"nickname"];
        info.carId = msgBody[@"carId"];
        response.userInfo = info;
    }
    
    return  response;
    
}

@end
