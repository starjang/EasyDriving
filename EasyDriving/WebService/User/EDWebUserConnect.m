//
//  EDWebUserConnect.m
//  EasyDriving
//
//  Created by Mason on 2018/11/14.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "EDWebUserConnect.h"
#import "EDWebUserLoginResponse.h"
#import "EDWebUserSignInResponse.h"
#import "EDWebUserQueryOrdersResponse.h"
#import "EDWebUserQueryHistoriesResponse.h"
#import "EDWebUserQueryPointsResponse.h"

@implementation EDWebUserConnect

+ (void)signUp:(EDWebUserSignUpRequest *)registerRequest withFinished:(EDWebConnectFinishedBlock)finishedBlock {
    
    NSDictionary *DIC = [registerRequest buildJson];
    AFHTTPSessionManager *manager = [self getRequestManager];
    
    [manager POST:[self getUrl:API_SIGNUP] parameters:DIC progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        finishedBlock([EDWebUserSignInResponse parseResponse:responseObject]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        finishedBlock([EDWebBaseResponse initErrorResponse]);
        
    }];
}

+ (void)signIn:(EDWebUserSignInRequest *)loginRequest withFinished:(EDWebConnectFinishedBlock)finishedBlock {
    
    NSDictionary *DIC = [loginRequest buildJson];
    AFHTTPSessionManager *manager = [self getRequestManager];
    
    [manager POST:[self getUrl:API_SIGNIN] parameters:DIC progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        finishedBlock([EDWebUserLoginResponse parseResponse:responseObject]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        finishedBlock([EDWebBaseResponse initErrorResponse]);
        
    }];
}

+ (void)addHistory:(EDWebUserAddHistoryRequest *)addRequest withFinished:(EDWebConnectFinishedBlock)finishedBlock {
    
    NSDictionary *DIC = [addRequest buildJson];
    AFHTTPSessionManager *manager = [self getRequestManager];
    
    [manager POST:[self getUrl:API_ADD_HISTORY] parameters:DIC progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        finishedBlock([EDWebBaseResponse initWithDefaultResponse:responseObject]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        finishedBlock([EDWebBaseResponse initErrorResponse]);
        
    }];
}

+ (void)addOrder:(EDWebUserAddOrderRequest *)addRequest withFinished:(EDWebConnectFinishedBlock)finishedBlock {
    
    NSDictionary *DIC = [addRequest buildJson];
    AFHTTPSessionManager *manager = [self getRequestManager];
    
    [manager POST:[self getUrl:API_ADD_ORDER] parameters:DIC progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        EDWebBaseResponse *response = [EDWebBaseResponse initWithDefaultResponse:responseObject];
        finishedBlock(response);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        finishedBlock([EDWebBaseResponse initErrorResponse]);
    }];
}

+ (void)queryOrders:(EDWebUserQueryOrdersRequest *)queryRequest withFinished:(EDWebConnectFinishedBlock)finishedBlock {
    
    NSDictionary *DIC = [queryRequest buildJson];
    AFHTTPSessionManager *manager = [self getRequestManager];
    
    [manager POST:[self getUrl:API_QUERY_ORDERS] parameters:DIC progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        finishedBlock([EDWebUserQueryOrdersResponse parseResponse:responseObject]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        finishedBlock([EDWebBaseResponse initErrorResponse]);
        
    }];
}

+ (void)deleteOrders:(EDWebUserDeleteOrderRequest *)deleteRequest withFinished:(EDWebConnectFinishedBlock)finishedBlock {
    
    NSDictionary *DIC = [deleteRequest buildJson];
    AFHTTPSessionManager *manager = [self getRequestManager];
    
    [manager POST:[self getUrl:API_DELETE_ORDER] parameters:DIC progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        finishedBlock([EDWebBaseResponse initWithDefaultResponse:responseObject]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        finishedBlock([EDWebBaseResponse initErrorResponse]);
        
    }];
}

+ (void)queryHistories:(EDWebUserQueryHistoriesRequest *)queryRequest withFinished:(EDWebConnectFinishedBlock)finishedBlock {
    
    NSDictionary *DIC = [queryRequest buildJson];
    AFHTTPSessionManager *manager = [self getRequestManager];
    
    [manager POST:[self getUrl:API_QUERY_HISTORIES] parameters:DIC progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        finishedBlock([EDWebUserQueryHistoriesResponse parseResponse:responseObject]);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        finishedBlock([EDWebBaseResponse initErrorResponse]);
        
    }];
}

+ (void)deleteHistory:(EDWebUserDeleteHistoryRequest *)deleteRequest withFinished:(EDWebConnectFinishedBlock)finishedBlock {
    
    NSDictionary *DIC = [deleteRequest buildJson];
    AFHTTPSessionManager *manager = [self getRequestManager];
    
    [manager POST:[self getUrl:API_DELETE_HISTORY] parameters:DIC progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        finishedBlock([EDWebBaseResponse initWithDefaultResponse:responseObject]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        finishedBlock([EDWebBaseResponse initErrorResponse]);
        
    }];
}

+ (void)queryPoints:(EDWebUserQueryPointsRequest *)queryRequest withFinished:(EDWebConnectFinishedBlock)finishedBlock {
    
    NSDictionary *DIC = [queryRequest buildJson];
    AFHTTPSessionManager *manager = [self getRequestManager];
    
    [manager POST:[self getUrl:API_QUERY_POINTS] parameters:DIC progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        finishedBlock([EDWebUserQueryPointsResponse parseResponse:responseObject]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        finishedBlock([EDWebBaseResponse initErrorResponse]);
        
    }];
}

+ (void)editCarId:(EDWebUserEditCarIdRequest *)editRequest withFinished:(EDWebConnectFinishedBlock)finishedBlock {
    
    NSDictionary *DIC = [editRequest buildJson];
    AFHTTPSessionManager *manager = [self getRequestManager];
    
    [manager POST:[self getUrl:API_EDIT_CARID] parameters:DIC progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        finishedBlock([EDWebBaseResponse initWithDefaultResponse:responseObject]);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        finishedBlock([EDWebBaseResponse initErrorResponse]);
        
    }];
}

+ (void)editNickname:(EDWebUserEditNicknameRequest *)editRequest withFinished:(EDWebConnectFinishedBlock)finishedBlock {
 
    NSDictionary *DIC = [editRequest buildJson];
    AFHTTPSessionManager *manager = [self getRequestManager];
    
    [manager POST:[self getUrl:API_EDIT_NICKNAME] parameters:DIC progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        finishedBlock([EDWebBaseResponse initWithDefaultResponse:responseObject]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        finishedBlock([EDWebBaseResponse initErrorResponse]);
        
    }];
}

@end
