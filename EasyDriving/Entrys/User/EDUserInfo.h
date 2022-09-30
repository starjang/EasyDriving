//
//  EDUserInfo.h
//  EasyDriving
//
//  Created by Mason on 2018/11/26.
//  Copyright © 2018 zmx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EDUserInfo : NSObject<NSCoding>

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *carId;

@end

NS_ASSUME_NONNULL_END
