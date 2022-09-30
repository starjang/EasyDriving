//
//  EDWebUserDeleteOrderRequest.m
//  EasyDriving
//
//  Created by StarJang on 2018/12/21.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "EDWebUserDeleteOrderRequest.h"

@implementation EDWebUserDeleteOrderRequest

- (NSDictionary *)buildJson {
    
    NSMutableDictionary *msgBodys = [NSMutableDictionary dictionary];
    [msgBodys setValue:self.userId forKey:@"userId"];
    [msgBodys setValue:self.orderId forKey:@"id"];

    return msgBodys;
}

@end
