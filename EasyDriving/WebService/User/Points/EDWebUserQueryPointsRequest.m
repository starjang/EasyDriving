//
//  EDWebUserQueryPointsRequest.m
//  EasyDriving
//
//  Created by Mason on 2018/12/25.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "EDWebUserQueryPointsRequest.h"

@implementation EDWebUserQueryPointsRequest

- (NSDictionary *)buildJson {
    
    NSMutableDictionary *msgBodys = [NSMutableDictionary dictionary];
    [msgBodys setValue:self.userId forKey:@"userId"];
    
    return msgBodys;
}

@end
