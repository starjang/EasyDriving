//
//  EDWebUserQueryHistoriesResponse.m
//  EasyDriving
//
//  Created by Mason on 2018/12/25.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "EDWebUserQueryHistoriesResponse.h"
#import "EDUserHistory.h"

@implementation EDWebUserQueryHistoriesResponse

+ (instancetype)parseResponse:(id)responseBody {
    
    EDWebUserQueryHistoriesResponse *response = [[EDWebUserQueryHistoriesResponse alloc]init];
    
    NSDictionary *msgBody = [response parse:responseBody];
    
    NSMutableArray *historiesJson = msgBody[@"histories"];
    
    if (response.isSuccess) {
        
        response.histories = [self convertJson:historiesJson];
    }
    
    return  response;
}

+ (NSMutableArray *)convertJson:(NSMutableArray *)historiesJson {
    
    NSMutableArray *histories = [NSMutableArray array];
    EDUserHistory *history;
    
    for (NSDictionary *dic in historiesJson) {
        
        history = [[EDUserHistory alloc] init];
        history.historyId = dic[@"historyId"];
        history.latitude = [dic[@"latitude"] floatValue];
        history.longitude = [dic[@"longitude"] floatValue];
        history.createTime = dic[@"createTime"];
        history.historyName = dic[@"historyName"];
        history.historyAddress = dic[@"historyAddress"];
        [histories addObject:history];
    }
    
    return histories;
}



@end
