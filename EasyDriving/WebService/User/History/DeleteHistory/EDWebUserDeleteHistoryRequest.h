//
//  EDWebUserDeleteHistoryRequest.h
//  EasyDriving
//
//  Created by Mason on 2018/12/25.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "EDWebBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface EDWebUserDeleteHistoryRequest : EDWebBaseRequest

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *historyId;

- (NSDictionary *)buildJson;

@end

NS_ASSUME_NONNULL_END
