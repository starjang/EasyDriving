//
//  EDWebNewsConnect.h
//  EasyDriving
//
//  Created by Mason on 2018/12/24.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "EDWebBaseConnect.h"
#import "EDWebNewsQueryRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface EDWebNewsConnect : EDWebBaseConnect

+ (void)queryNews:(EDWebNewsQueryRequest *)queryRequest withFinished:(EDWebConnectFinishedBlock)finishedBlock;


@end

NS_ASSUME_NONNULL_END
