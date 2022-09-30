//
//  EDWebNewsConnect.m
//  EasyDriving
//
//  Created by Mason on 2018/12/24.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "EDWebNewsConnect.h"
#import "EDWebNewsQueryResponse.h"

@implementation EDWebNewsConnect

+ (void)queryNews:(EDWebNewsQueryRequest *)queryRequest withFinished:(EDWebConnectFinishedBlock)finishedBlock {
    
    NSDictionary *DIC = [queryRequest buildJson];
    AFHTTPSessionManager *manager = [self getRequestManager];
    
    [manager POST:[self getUrl:API_QUERY_NEWS] parameters:DIC progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        finishedBlock([EDWebNewsQueryResponse parseResponse:responseObject]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        finishedBlock([EDWebBaseResponse initErrorResponse]);
    }];
}

@end
