//
//  EDWebUserLoginRequest.m
//  EasyDriving
//
//  Created by Mason on 2018/11/14.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "EDWebUserSignInRequest.h"

@implementation EDWebUserSignInRequest

- (NSDictionary *)buildJson {
    
    NSMutableDictionary *msgBodys = [NSMutableDictionary dictionary];
    [msgBodys setValue:self.userName forKey:@"username"];
    [msgBodys setValue:self.password forKey:@"password"];
    
    return msgBodys;    
}

@end
