//
//  EDWebNewsQueryRequest.m
//  EasyDriving
//
//  Created by Mason on 2018/12/24.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "EDWebNewsQueryRequest.h"

@implementation EDWebNewsQueryRequest

- (NSDictionary *)buildJson {
    
    NSMutableDictionary *msgBodys = [NSMutableDictionary dictionary];
    [msgBodys setValue:[NSNumber numberWithInteger:self.startIndex] forKey:@"startIndex"];
    [msgBodys setValue:[NSNumber numberWithInteger:self.pageCount] forKey:@"pageCount"];

    return msgBodys;
}

@end
