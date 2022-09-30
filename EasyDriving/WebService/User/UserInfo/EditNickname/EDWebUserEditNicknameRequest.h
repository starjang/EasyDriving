//
//  EDWebUserEditNickname.h
//  EasyDriving
//
//  Created by Mason on 2018/12/25.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "EDWebBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface EDWebUserEditNicknameRequest : EDWebBaseRequest

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *nickname;

- (NSDictionary *)buildJson;

@end

NS_ASSUME_NONNULL_END
