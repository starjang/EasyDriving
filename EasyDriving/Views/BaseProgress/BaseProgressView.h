//
//  BaseProgressView.h
//  EasyDriving
//
//  Created by Mason on 2018/11/27.
//  Copyright © 2018 zmx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MMMaterialDesignSpinner/MMMaterialDesignSpinner.h>

#define BaseProgressViewCircleHeight  70


NS_ASSUME_NONNULL_BEGIN

@interface BaseProgressView : UIButton

@property (nonatomic, strong) MMMaterialDesignSpinner *circleView;
@property (nonatomic, strong) UIView *progressBaseView;
-(void)initProgressView;
-(void)hideWithAnimation;
-(void)showWithAnimation;
-(void)endProgress;

@end

NS_ASSUME_NONNULL_END
