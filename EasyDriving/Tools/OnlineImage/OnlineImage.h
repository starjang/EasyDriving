//
//  OnlineImage.h
//  EasyDriving
//
//  Created by Mason on 2018/11/23.
//  Copyright © 2018 zmx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OnlineImage : NSObject

+(UIImage *)getIcon:(NSString *)name hexColor:(NSString *)color size:(CGFloat)width;

@end

NS_ASSUME_NONNULL_END
