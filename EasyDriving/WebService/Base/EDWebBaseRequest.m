//
//  DPWebBaseRequest.m
//  EasyDriving
//
//  Created by Mason on 2018/11/14.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "EDWebBaseRequest.h"

@implementation EDWebBaseRequest

- (NSMutableDictionary *)addMsgBody:(id)msgBodys {
    
    NSMutableDictionary *mainDic = [NSMutableDictionary dictionary];
    [mainDic setValue:msgBodys forKey:@"msg"];
    
    return  mainDic;
}

- (NSString *)toJson:(id)parameters {
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters
                                                       options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        //        NSLog(@"出错了dic->%@",error);
    }
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return jsonStr ;
}

+(NSString *)initDefaultRequestJson{
    EDWebBaseRequest *baseRequest = [[EDWebBaseRequest alloc]init];
    NSMutableDictionary *msgBodys = [NSMutableDictionary dictionary];
    return   [baseRequest toJson:[baseRequest addMsgBody:msgBodys]];
    
}

@end
