//
//  EDWebUserQueryOrdersRequest.h
//  EasyDriving
//
//  Created by Mason on 2018/12/20.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "EDWebBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface EDWebUserQueryOrdersRequest : EDWebBaseRequest

@property (nonatomic, strong) NSString *userId;

- (NSDictionary *)buildJson;

@end

NS_ASSUME_NONNULL_END
