//
//  CircleProgressView.m
//  EasyDriving
//
//  Created by Mason on 2018/11/27.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "CircleProgressView.h"
#import "BaseHeader.h"

@implementation CircleProgressView

+(instancetype)beginProgress:(UIView *)baseView{
    
    CircleProgressView *progressView = [[CircleProgressView alloc]init];
    [progressView initBaseView];
    [progressView initProgressView];
    [progressView showWithAnimation];
    [baseView addSubview:progressView];
    return progressView ;
}


-(void)initBaseView{
    
    self.frame = CGRectMake(0, 0, iScreenWidth, iScreenHeight);
    self.backgroundColor = [UIColor clearColor];
    
}

@end
