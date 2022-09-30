//
//  EDWebUserSignInResponse.h
//  EasyDriving
//
//  Created by Mason on 2018/11/28.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "EDWebBaseResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface EDWebUserSignInResponse : EDWebBaseResponse

+ (instancetype)parseResponse:(id)responseBody;

@end

NS_ASSUME_NONNULL_END
