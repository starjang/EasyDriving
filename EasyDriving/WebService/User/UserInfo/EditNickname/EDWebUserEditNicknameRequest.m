//
//  EDWebUserEditNickname.m
//  EasyDriving
//
//  Created by Mason on 2018/12/25.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "EDWebUserEditNicknameRequest.h"

@implementation EDWebUserEditNicknameRequest

- (NSDictionary *)buildJson {
    
    NSMutableDictionary *msgBodys = [NSMutableDictionary dictionary];
    [msgBodys setValue:self.userId forKey:@"userId"];
    [msgBodys setValue:self.nickname forKey:@"nickname"];
    
    return msgBodys;
}
@end
