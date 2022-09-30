//
//  EDWebUserQueryOrdersResponse.h
//  EasyDriving
//
//  Created by Mason on 2018/12/20.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "EDWebBaseResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface EDWebUserQueryOrdersResponse : EDWebBaseResponse

@property (nonatomic, strong) NSMutableArray *orders;

+ (instancetype)parseResponse:(id)responseBody;

@end

NS_ASSUME_NONNULL_END
