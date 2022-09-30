//
//  EDWebUserQueryPointsResponse.m
//  EasyDriving
//
//  Created by Mason on 2018/12/25.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "EDWebUserQueryPointsResponse.h"
#import "EDUserPoints.h"

@implementation EDWebUserQueryPointsResponse

+ (instancetype)parseResponse:(id)responseBody {
    
    EDWebUserQueryPointsResponse *response = [[EDWebUserQueryPointsResponse alloc]init];
    
    NSDictionary *msgBody = [response parse:responseBody];
    
    NSMutableArray *pointsJson = msgBody[@"points"];
    
    if (response.isSuccess) {
        
        response.points = [self convertJson:pointsJson];
    }
    
    return  response;
}

+ (NSMutableArray *)convertJson:(NSMutableArray *)pointsJson {
    
    NSMutableArray *points = [NSMutableArray array];
    EDUserPoints *point;
    
    for (NSDictionary *dic in pointsJson) {
        
        point = [[EDUserPoints alloc] init];
        point.pointId = dic[@"pointId"];
        point.placeName = dic[@"placeName"];
        point.placeAddress = dic[@"placeAddress"];
        point.points = [dic[@"points"] integerValue];
        [points addObject:point];
    }
    
    return points;
}

@end
