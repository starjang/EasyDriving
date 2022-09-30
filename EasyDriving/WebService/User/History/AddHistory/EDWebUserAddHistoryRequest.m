//
//  EDWebUserAddTrailRequest.m
//  EasyDriving
//
//  Created by Mason on 2018/11/29.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "EDWebUserAddHistoryRequest.h"
#import "EDUserHistory.h"
#import <UIKit/UIKit.h>

@implementation EDWebUserAddHistoryRequest

- (NSDictionary *)buildJson {
    
    NSMutableDictionary *msgBodys = [NSMutableDictionary dictionary];
    [msgBodys setValue:self.userId forKey:@"userId"];
    [msgBodys setValue:[NSNumber numberWithFloat:self.trail.latitude] forKey:@"latitude"];
    [msgBodys setValue:[NSNumber numberWithFloat:self.trail.longitude] forKey:@"longitude"];
    [msgBodys setValue:self.trail.historyName forKey:@"historyName"];
    [msgBodys setValue:self.trail.historyAddress forKey:@"historyAddress"];
    
    return msgBodys;
}


@end
