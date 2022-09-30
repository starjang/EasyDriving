//
//  EDWebUserSignInResponse.m
//  EasyDriving
//
//  Created by Mason on 2018/11/28.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "EDWebUserSignInResponse.h"

@implementation EDWebUserSignInResponse

+ (instancetype)parseResponse:(id)responseBody {
    
    EDWebUserSignInResponse *response = [[EDWebUserSignInResponse alloc]init];
    
    [response parse:responseBody];

    return  response;
}


@end
