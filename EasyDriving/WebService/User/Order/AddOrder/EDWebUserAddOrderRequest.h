//
//  EDWebUserAddOrderRequest.h
//  EasyDriving
//
//  Created by Mason on 2018/12/20.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "EDWebBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface EDWebUserAddOrderRequest : EDWebBaseRequest

@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *placeName;
@property (nonatomic, strong) NSString *placeAddress;

- (NSDictionary *)buildJson;

@end

NS_ASSUME_NONNULL_END
