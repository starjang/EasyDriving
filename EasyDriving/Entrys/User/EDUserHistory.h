//
//  EDUserHistory.h
//  EasyDriving
//
//  Created by Mason on 2018/11/29.
//  Copyright © 2018 zmx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EDUserHistory : NSObject<NSCoding>

@property (nonatomic, strong) NSString *historyId;
@property (nonatomic, assign) CGFloat latitude;
@property (nonatomic, assign) CGFloat longitude;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *historyName;
@property (nonatomic, strong) NSString *historyAddress;

@end

NS_ASSUME_NONNULL_END
