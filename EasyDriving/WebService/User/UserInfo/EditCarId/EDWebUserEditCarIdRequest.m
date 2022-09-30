//
//  EDWebUserEditCarId.m
//  EasyDriving
//
//  Created by Mason on 2018/12/25.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "EDWebUserEditCarIdRequest.h"

@implementation EDWebUserEditCarIdRequest

- (NSDictionary *)buildJson {
    
    NSMutableDictionary *msgBodys = [NSMutableDictionary dictionary];
    [msgBodys setValue:self.userId forKey:@"userId"];
    [msgBodys setValue:self.carId forKey:@"carId"];
    
    return msgBodys;
}

@end
