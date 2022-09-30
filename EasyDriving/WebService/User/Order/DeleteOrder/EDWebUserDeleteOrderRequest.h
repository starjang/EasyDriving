//
//  EDWebUserDeleteOrderRequest.h
//  EasyDriving
//
//  Created by StarJang on 2018/12/21.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "EDWebBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface EDWebUserDeleteOrderRequest : EDWebBaseRequest

@property (nonatomic, strong) NSString *userId;

@property (nonatomic, strong) NSString *orderId;

- (NSDictionary *)buildJson;


@end

NS_ASSUME_NONNULL_END
