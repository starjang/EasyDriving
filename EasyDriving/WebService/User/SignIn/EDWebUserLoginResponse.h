//
//  EDWebUserLoginResponse.h
//  EasyDriving
//
//  Created by Mason on 2018/11/14.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "EDWebBaseResponse.h"

@class EDUserInfo;

NS_ASSUME_NONNULL_BEGIN

@interface EDWebUserLoginResponse : EDWebBaseResponse

@property (nonatomic, strong) EDUserInfo *userInfo;

+(instancetype)parseResponse:(id)responseBody ;

@end

NS_ASSUME_NONNULL_END
