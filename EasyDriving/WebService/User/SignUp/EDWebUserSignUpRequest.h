//
//  EDWebUserSignUpRequest.h
//  EasyDriving
//
//  Created by Mason on 2018/11/28.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "EDWebBaseRequest.h"

@class EDUserInfo;

NS_ASSUME_NONNULL_BEGIN

@interface EDWebUserSignUpRequest : EDWebBaseRequest

@property (nonatomic, strong) EDUserInfo *userInfo;

- (NSDictionary *)buildJson;

@end

NS_ASSUME_NONNULL_END
