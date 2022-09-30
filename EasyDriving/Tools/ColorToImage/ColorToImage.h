//
//  ColorToImage.h
//  EasyDriving
//
//  Created by Mason on 2018/11/23.
//  Copyright © 2018 zmx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ColorToImage : NSObject

+(UIImage *)imageFromColor:(UIColor*)color size:(CGSize)size;
@end

NS_ASSUME_NONNULL_END
