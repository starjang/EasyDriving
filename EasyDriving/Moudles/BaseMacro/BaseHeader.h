//
//  BaseHeader.h
//  EasyDriving
//
//  Created by Mason on 2018/11/23.
//  Copyright © 2018 zmx. All rights reserved.
//

#ifndef BaseHeader_h
#define BaseHeader_h

#import <ChameleonFramework/ChameleonMacros.h>
#import <MMPlaceHolder/MMPlaceHolder.h>
#import <Masonry/Masonry.h>
#import "OnlineImage.h"
#import "CircleProgressView.h"
#import "SDImageCache.h"
#import "SDWebImageManager.h"
#import <UIKit/UIKit.h>
#import <Material/Material-Swift.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <RKDropdownAlert/RKDropdownAlert.h>

// 高德地图Key
#define aMapKey @"765229f7bafe3756d27da82b60cbbab5"

#define emptyString @""

#define weakSelf(type)  __weak typeof(type) weak##type = type;
#define fontBig 16
#define fontMiddle 15
#define fontSmall 14

#define iUnitPoint10 10

#define iScreenHeight [UIScreen mainScreen].bounds.size.height
#define iScreenWidth [UIScreen mainScreen].bounds.size.width

#define iScreenStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height

#define iScreenNavigationHeight 44

#define iScreenTopHeight (iScreenStatusBarHeight + iScreenNavigationHeight)

#define iScreenTabbarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20 ? 83:49)

#define iSafeAreaBottomHeight (((iScreenHeight == 812.0) || (iScreenHeight == 896.0)) ? 34 : 0)

#define iHeightCoefficient (((iScreenHeight == 812.0) || (iScreenHeight == 896.0)) ? 667.0/667.0 : yScreenHeight/667.0)

#define iOS10 [[[UIDevice currentDevice]systemVersion] floatValue] >= 10.0
#define iOS11 [[[UIDevice currentDevice]systemVersion] floatValue] >= 11.0
#define iOS12 [[[UIDevice currentDevice]systemVersion] floatValue] >= 12.0
#define iOS_VERSION [[[UIDevice currentDevice]systemVersion] floatValue]


// 背景色
#define e_bgcolor @"#f1f1f1"
// 描述字体颜色
#define e_lettercolor_desc @"#666666"
// 图片主题颜色值
#define e_primaryimgcolor @"#424242"
// 图片普通颜色值
#define e_normalimgcolor_desc @"#757575"
// 按钮常规颜色
#define e_buttonnormalcolor @"#424242"
// 主题黑颜色值
#define e_primaryblackcolor @"#31304f"
// 常用主题红
#define e_primaryredcolor @"#e81e63"
// 反色时字体的颜色
#define e_textreversecolor @"#ffffff"
// section颜色
#define e_sectioncolor @"#f3f3f9"
// 常用绿色
#define e_primarygreencolor @"#4caf50"
// 普通箭头颜色
#define e_normalgraycolor @"#bdbdbd"

#define e_normalbulecolor @"289efc"

#endif /* BaseHeader_h */
