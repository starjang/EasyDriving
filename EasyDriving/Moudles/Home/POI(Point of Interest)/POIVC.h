//
//  POIVC.h
//  EasyDriving
//
//  Created by Mason on 2018/12/4.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "BaseVC.h"
#import <CoreLocation/CoreLocation.h>


NS_ASSUME_NONNULL_BEGIN

@interface POIVC : BaseVC

@property (nonatomic, assign) CLLocationCoordinate2D locationCoordinate;
@property (nonatomic, strong) NSString *poiTitle;
@property (nonatomic, assign) BOOL isSupportOrder;

@end

NS_ASSUME_NONNULL_END
