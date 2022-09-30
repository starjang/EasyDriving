//
//  EDWebUserQueryOrdersResponse.m
//  EasyDriving
//
//  Created by Mason on 2018/12/20.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "EDWebUserQueryOrdersResponse.h"
#import "EDUserOrder.h"

@implementation EDWebUserQueryOrdersResponse

+ (instancetype)parseResponse:(id)responseBody {
    
    EDWebUserQueryOrdersResponse *response = [[EDWebUserQueryOrdersResponse alloc]init];
    
    NSDictionary *msgBody = [response parse:responseBody];
    
    NSMutableArray *ordersJson = msgBody[@"orders"];
    
    if (response.isSuccess) {
        
        response.orders = [self convertJson:ordersJson];
    }
    
    return  response;
}

+ (NSMutableArray *)convertJson:(NSMutableArray *)ordersJson {
    
    NSMutableArray *orders = [NSMutableArray array];
    
    EDUserOrder *order;

    for (NSDictionary *dic in ordersJson) {
        
        order = [[EDUserOrder alloc] init];
        order.orderId = dic[@"id"];
        order.placeName = dic[@"placeName"];
        order.placeAddress = dic[@"placeAddress"];
        order.createTime = dic[@"createTime"];
        order.state = [dic[@"state"] boolValue];
        [orders addObject:order];
    }
    
    return orders;
}

@end
