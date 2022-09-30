//
//  EDWebUserAddTrailRequest.h
//  EasyDriving
//
//  Created by Mason on 2018/11/29.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "EDWebBaseRequest.h"

@class EDUserHistory;

NS_ASSUME_NONNULL_BEGIN

@interface EDWebUserAddHistoryRequest : EDWebBaseRequest

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) EDUserHistory *trail;

-(NSDictionary *)buildJson;

@end

NS_ASSUME_NONNULL_END
