//
//  BaseProgressView.m
//  EasyDriving
//
//  Created by Mason on 2018/11/27.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "BaseProgressView.h"
#import "BaseHeader.h"

@implementation BaseProgressView

-(void)initProgressView{
    
    [self initProgressBaseView];
    
    self.circleView = [[MMMaterialDesignSpinner alloc] init];
    
    self.circleView.lineWidth = 2.2;
    self.circleView.tintColor = [UIColor colorWithHexString:e_primaryimgcolor];
    self.circleView.duration = 1.3;
    self.circleView.backgroundColor = [UIColor clearColor];
    self.circleView.hidesWhenStopped = YES;
    
    [self.progressBaseView addSubview:self.circleView];
    
    [self.circleView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_greaterThanOrEqualTo(24);
        make.height.mas_greaterThanOrEqualTo(24);
        make.centerX.mas_equalTo(self.progressBaseView.mas_centerX);
        make.centerY.mas_equalTo(self.progressBaseView.mas_centerY);
    }];
}

-(void)initProgressBaseView{
    
    self.progressBaseView = [[UIView alloc]init];
    [self addSubview:self.progressBaseView];
    self.progressBaseView.layer.cornerRadius = BaseProgressViewCircleHeight/10;
    self.progressBaseView.layer.shadowColor = [UIColor whiteColor].CGColor;
    self.progressBaseView.layer.shadowOffset = CGSizeMake(BaseProgressViewCircleHeight/15, BaseProgressViewCircleHeight/15);
    [self.progressBaseView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_greaterThanOrEqualTo(BaseProgressViewCircleHeight*1.1);
        make.height.mas_greaterThanOrEqualTo(BaseProgressViewCircleHeight*1.1);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
}

-(void)hideWithAnimation{

    [self.circleView stopAnimating];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(void)showWithAnimation{

    self.alpha = 0.01f;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 1.0f;
    } completion:^(BOOL finished) {
        [self progressAnimationStart];
        
    }];
}

-(void)progressAnimationStart{
    
    [self.circleView startAnimating];
    
}


-(void)endProgress {
    [self hideWithAnimation];
    
    
}

@end
