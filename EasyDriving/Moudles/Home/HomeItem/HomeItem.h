//
//  HomeItem.h
//  EasyDriving
//
//  Created by Mason on 2018/11/29.
//  Copyright © 2018 zmx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    GAS_STATION,
    PARKING_LOT,
    CAR_MAINTENANCE,
    CAR_REPAIR,
    CAR_STORE,
    EMERGENCY_CALL
} HomeItemID;


@interface HomeItem : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *bgColor;
@property (nonatomic, strong) NSString *img;
@property (nonatomic, assign) HomeItemID itemId;

@end

NS_ASSUME_NONNULL_END
