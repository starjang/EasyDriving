//
//  POISpeechSynthesizer.m
//  语音合成
//
//  Created by Mason on 2018/12/19.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "POISpeechSynthesizer.h"
#import "BaseHeader.h"

@interface POISpeechSynthesizer() <AVSpeechSynthesizerDelegate>

@property (nonatomic, strong, readwrite) AVSpeechSynthesizer *speechSynthesizer;

@end

@implementation POISpeechSynthesizer

+ (instancetype)sharedSpeechSynthesizer
{
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[POISpeechSynthesizer alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    if (self = [super init])
    {
        [self buildSpeechSynthesizer];
    }
    return self;
}

- (void)buildSpeechSynthesizer
{
    if (iOS_VERSION < 7.0)
    {
        return;
    }
    
    //简单配置一个AVAudioSession以便可以在后台播放声音，更多细节参考AVFoundation官方文档
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:NULL];
    
    self.speechSynthesizer = [[AVSpeechSynthesizer alloc] init];
    [self.speechSynthesizer setDelegate:self];
}

- (void)speakString:(NSString *)string
{
    if (self.speechSynthesizer)
    {
        AVSpeechUtterance *aUtterance = [AVSpeechUtterance speechUtteranceWithString:string];
        [aUtterance setVoice:[AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"]];
        
        //iOS语音合成在iOS8及以下版本系统上语速异常
        if (iOS_VERSION < 8.0)
        {
            aUtterance.rate = 0.25;//iOS7设置为0.25
        }
        else if (iOS_VERSION < 9.0)
        {
            aUtterance.rate = 0.15;//iOS8设置为0.15
        }
        
        if ([self.speechSynthesizer isSpeaking])
        {
            [self.speechSynthesizer stopSpeakingAtBoundary:AVSpeechBoundaryWord];
        }
        
        [self.speechSynthesizer speakUtterance:aUtterance];
    }
}

- (void)stopSpeak
{
    if (self.speechSynthesizer)
    {
        [self.speechSynthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    }
}

@end
