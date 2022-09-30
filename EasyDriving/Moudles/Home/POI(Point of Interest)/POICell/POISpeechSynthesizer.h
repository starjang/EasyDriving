//
//  POISpeechSynthesizer.h
//  语音合成
//
//  Created by Mason on 2018/12/19.
//  Copyright © 2018 zmx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface POISpeechSynthesizer : NSObject

+ (instancetype)sharedSpeechSynthesizer;

- (void)speakString:(NSString *)string;

- (void)stopSpeak;

@end

NS_ASSUME_NONNULL_END
