//
//  UserItem.h
//  EasyDriving
//
//  Created by Mason on 2018/11/26.
//  Copyright © 2018 zmx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    USER_INFO,
    HISTORY_ORDER,
    HISTORY_PLACE,
    MY_POINT,
    CLEAN_CACHE,
    LOG_OUT
} UserItemID;

@interface UserItem : NSObject

@property (nonatomic, strong) NSString *imgStr;
@property (nonatomic, strong) NSString *contentStr;
@property (nonatomic, assign) UserItemID itemId;

@end

NS_ASSUME_NONNULL_END
