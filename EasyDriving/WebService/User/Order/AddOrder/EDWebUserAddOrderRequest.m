//
//  EDWebUserAddOrderRequest.m
//  EasyDriving
//
//  Created by Mason on 2018/12/20.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "EDWebUserAddOrderRequest.h"

@implementation EDWebUserAddOrderRequest

- (NSDictionary *)buildJson {
    
    if (!self.placeAddress) {
        self.placeAddress = @"未获取到商家的具体地址";
    }
    
    NSMutableDictionary *msgBodys = [NSMutableDictionary dictionary];
    [msgBodys setValue:self.uid forKey:@"uid"];
    [msgBodys setValue:self.userId forKey:@"userId"];
    [msgBodys setValue:self.placeName forKey:@"placeName"];
    [msgBodys setValue:self.placeAddress forKey:@"placeAddress"];
    
    return msgBodys;
}

@end
