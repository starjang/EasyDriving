//
//  EDWebUserQueryHistoriesRequest.h
//  EasyDriving
//
//  Created by Mason on 2018/12/25.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "EDWebBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface EDWebUserQueryHistoriesRequest : EDWebBaseRequest

@property (nonatomic, strong) NSString *userId;

-(NSDictionary *)buildJson;

@end

NS_ASSUME_NONNULL_END
