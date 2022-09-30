//
//  EDWebUserLoginRequest.h
//  EasyDriving
//
//  Created by Mason on 2018/11/14.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "EDWebBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface EDWebUserSignInRequest : EDWebBaseRequest

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *password;

-(NSDictionary *)buildJson;

@end

NS_ASSUME_NONNULL_END
