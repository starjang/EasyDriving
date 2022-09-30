//
//  EDWebUserQueryHistoriesResponse.h
//  EasyDriving
//
//  Created by Mason on 2018/12/25.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "EDWebBaseResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface EDWebUserQueryHistoriesResponse : EDWebBaseResponse

@property (nonatomic, strong) NSMutableArray *histories;

+ (instancetype)parseResponse:(id)responseBody;

@end

NS_ASSUME_NONNULL_END
