//
//  EDUserStore.h
//  EasyDriving
//
//  Created by Mason on 2018/11/26.
//  Copyright © 2018 zmx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EDuserInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface EDUserStore : NSObject

+(EDUserInfo *)get;

+(void)reset:(EDUserInfo *)userInfo;

+(void)clean;

@end

NS_ASSUME_NONNULL_END
