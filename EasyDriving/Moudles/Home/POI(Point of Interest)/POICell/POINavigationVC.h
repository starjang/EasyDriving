//
//  POINavigationVC.h
//  行车导航
//
//  Created by Mason on 2018/12/19.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "BaseVC.h"
#import <AMapNaviKit/AMapNaviKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface POINavigationVC : BaseVC

@property (nonatomic, strong) AMapNaviPoint *startPoint;
@property (nonatomic, strong) AMapNaviPoint *endPoint;

@end

NS_ASSUME_NONNULL_END
