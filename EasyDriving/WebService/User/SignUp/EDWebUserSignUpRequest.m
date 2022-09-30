//
//  EDWebUserSignUpRequest.m
//  EasyDriving
//
//  Created by Mason on 2018/11/28.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "EDWebUserSignUpRequest.h"
#import "EDUserInfo.h"

@implementation EDWebUserSignUpRequest

- (NSDictionary *)buildJson {
    
    NSMutableDictionary *msgBodys = [NSMutableDictionary dictionary];
    [msgBodys setValue:self.userInfo.username forKey:@"username"];
    [msgBodys setValue:self.userInfo.password forKey:@"password"];
    [msgBodys setValue:self.userInfo.nickname forKey:@"nickname"];
    [msgBodys setValue:self.userInfo.carId forKey:@"carId"];
    
    return msgBodys;
}

@end
