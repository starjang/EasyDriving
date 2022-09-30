//
//  OnlineImage.m
//  EasyDriving
//
//  Created by Mason on 2018/11/23.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "OnlineImage.h"
#import <FontAwesomeKit/FontAwesomeKit.h>
#import <ChameleonFramework/ChameleonMacros.h>

@implementation OnlineImage

+(UIImage *)getIcon:(NSString *)name hexColor:(NSString *)color size:(CGFloat)width {
    FAKIonIcons *ionIcon = [FAKIonIcons iconWithIdentifier:name size:width error:nil];
    [ionIcon addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:color]];
    return [ionIcon imageWithSize:CGSizeMake(width, width)];
}

@end
