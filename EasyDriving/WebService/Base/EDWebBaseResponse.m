//
//  DPWebBaseResponse.m
//  EasyDriving
//
//  Created by Mason on 2018/11/14.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "EDWebBaseResponse.h"

#define EMPTY_STRING @""

@implementation EDWebBaseResponse

-(id)parse:(id)responseData {
    
    NSString *result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSData *jsonData = [result dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *response = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    
    self.msg = response[@"message"];
    self.isSuccess = [response[@"isSuccess"] boolValue];
    
    return response;
}

+ (instancetype)initErrorResponse {
    
    EDWebBaseResponse *response = [[EDWebBaseResponse alloc]init];
    response.isSuccess = NO;
    response.msg = EMPTY_STRING;
    return response;
    
}


+ (instancetype)initWithDefaultResponse:(id)responseJson {
    
    EDWebBaseResponse *response = [[EDWebBaseResponse alloc]init];
    
    [response parse:responseJson];
    
    return response ;
    
}

+ (NSString *)parseEmpty:(id)info {
    
    if ([info isEqual:[NSNull null]] || info == nil) {
        info = EMPTY_STRING;
    }
    return  info ;
    
}

@end
