//
//  POIPreferenceView.h
//  偏好设置
//
//  Created by Mason on 2018/12/19.
//  Copyright © 2018 zmx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AMapNaviKit/AMapNaviCommonObj.h>

NS_ASSUME_NONNULL_BEGIN


@protocol PreferenceViewDelegate <NSObject>
@optional

- (void)preferenceViewFinishButtonClicked;
- (void)PreferenceViewTrackingModeChangeTo:(AMapNaviViewTrackingMode)trackingMode;
- (void)PreferenceViewNightTypeChangeTo:(BOOL)isShowNightType;

@end

@interface POIPreferenceView : UIView

@property (nonatomic, assign) id<PreferenceViewDelegate> delegate;
@property (nonatomic, assign) AMapNaviViewTrackingMode trackingMode;
@property (nonatomic, assign) BOOL showNightType;

@end


NS_ASSUME_NONNULL_END
