//
//  EDWebNewsQueryResponse.h
//  EasyDriving
//
//  Created by Mason on 2018/12/24.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "EDWebBaseResponse.h"

NS_ASSUME_NONNULL_BEGIN

@class EDNews;

@interface EDWebNewsQueryResponse : EDWebBaseResponse

@property (nonatomic, strong) NSMutableArray *news;

+ (instancetype)parseResponse:(id)responseBody;

@end

NS_ASSUME_NONNULL_END
