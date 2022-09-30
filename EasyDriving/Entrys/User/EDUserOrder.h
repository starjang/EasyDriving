//
//  EDUserOrder.h
//  EasyDriving
//
//  Created by Mason on 2018/12/20.
//  Copyright © 2018 zmx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EDUserOrder : NSObject

@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, strong) NSString *placeName;
@property (nonatomic, strong) NSString *placeAddress;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, assign) BOOL state;

@end

NS_ASSUME_NONNULL_END
