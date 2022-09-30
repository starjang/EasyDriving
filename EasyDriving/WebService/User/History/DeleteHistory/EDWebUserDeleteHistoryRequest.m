//
//  EDWebUserDeleteHistoryRequest.m
//  EasyDriving
//
//  Created by Mason on 2018/12/25.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "EDWebUserDeleteHistoryRequest.h"

@implementation EDWebUserDeleteHistoryRequest

- (NSDictionary *)buildJson {
    
    NSMutableDictionary *msgBodys = [NSMutableDictionary dictionary];
    [msgBodys setValue:self.userId forKey:@"userId"];
    [msgBodys setValue:self.historyId forKey:@"historyId"];

    return msgBodys;
}

@end
