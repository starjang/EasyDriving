//
//  EDWebUserConnect.h
//  EasyDriving
//
//  Created by Mason on 2018/11/14.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "EDWebBaseConnect.h"
#import "EDWebUserSignInRequest.h"
#import "EDWebUserSignUpRequest.h"
#import "EDWebUserAddHistoryRequest.h"
#import "EDWebUserAddOrderRequest.h"
#import "EDWebUserQueryOrdersRequest.h"
#import "EDWebUserDeleteOrderRequest.h"
#import "EDWebUserQueryHistoriesRequest.h"
#import "EDWebUserDeleteHistoryRequest.h"
#import "EDWebUserQueryPointsRequest.h"
#import "EDWebUserEditCarIdRequest.h"
#import "EDWebUserEditNicknameRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface EDWebUserConnect : EDWebBaseConnect

+ (void)signUp:(EDWebUserSignUpRequest *)registerRequest withFinished:(EDWebConnectFinishedBlock)finishedBlock;

+ (void)signIn:(EDWebUserSignInRequest *)loginRequest withFinished:(EDWebConnectFinishedBlock)finishedBlock;

+ (void)addHistory:(EDWebUserAddHistoryRequest *)AddRequest withFinished:(EDWebConnectFinishedBlock)finishedBlock;

+ (void)addOrder:(EDWebUserAddOrderRequest *)addRequest withFinished:(EDWebConnectFinishedBlock)finishedBlock;

+ (void)queryOrders:(EDWebUserQueryOrdersRequest *)queryRequest withFinished:(EDWebConnectFinishedBlock)finishedBlock;

+ (void)deleteOrders:(EDWebUserDeleteOrderRequest *)deleteRequest withFinished:(EDWebConnectFinishedBlock)finishedBlock;

+ (void)queryHistories:(EDWebUserQueryHistoriesRequest *)queryRequest withFinished:(EDWebConnectFinishedBlock)finishedBlock;

+ (void)deleteHistory:(EDWebUserDeleteHistoryRequest *)deleteRequest withFinished:(EDWebConnectFinishedBlock)finishedBlock;

+ (void)queryPoints:(EDWebUserQueryPointsRequest *)queryRequest withFinished:(EDWebConnectFinishedBlock)finishedBlock;

+ (void)editCarId:(EDWebUserEditCarIdRequest *)editRequest withFinished:(EDWebConnectFinishedBlock)finishedBlock;

+ (void)editNickname:(EDWebUserEditNicknameRequest *)editRequest withFinished:(EDWebConnectFinishedBlock)finishedBlock;

@end

NS_ASSUME_NONNULL_END
