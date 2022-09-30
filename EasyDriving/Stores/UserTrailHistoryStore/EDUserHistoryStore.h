//
//  EDTrailHistoryStore.h
//  EasyDriving
//
//  Created by Mason on 2018/11/30.
//  Copyright © 2018 zmx. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EDUserHistory;

NS_ASSUME_NONNULL_BEGIN

@interface EDUserHistoryStore : NSObject

+(EDUserHistory *)get;

+(void)reset:(EDUserHistory *)history;

+(void)clean;

@end

NS_ASSUME_NONNULL_END
