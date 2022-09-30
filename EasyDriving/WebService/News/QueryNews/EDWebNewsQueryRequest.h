//
//  EDWebNewsQueryRequest.h
//  EasyDriving
//
//  Created by Mason on 2018/12/24.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "EDWebBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface EDWebNewsQueryRequest : EDWebBaseRequest


@property (nonatomic, assign) NSInteger startIndex;
@property (nonatomic, assign) NSInteger pageCount;

- (NSDictionary *)buildJson;

@end

NS_ASSUME_NONNULL_END
