//
//  EDWebUserQueryOrdersRequest.m
//  EasyDriving
//
//  Created by Mason on 2018/12/20.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "EDWebUserQueryOrdersRequest.h"

@implementation EDWebUserQueryOrdersRequest

- (NSDictionary *)buildJson {
    
    NSMutableDictionary *msgBodys = [NSMutableDictionary dictionary];
    [msgBodys setValue:self.userId forKey:@"userId"];
    
    return msgBodys;
}

@end
