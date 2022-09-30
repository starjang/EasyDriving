//
//  EDUserPoints.h
//  EasyDriving
//
//  Created by Mason on 2018/12/25.
//  Copyright © 2018 zmx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EDUserPoints : NSObject

@property (nonatomic, strong) NSString *pointId;
@property (nonatomic, strong) NSString *placeName;
@property (nonatomic, strong) NSString *placeAddress;
@property (nonatomic, assign) NSInteger points;

@end

NS_ASSUME_NONNULL_END
