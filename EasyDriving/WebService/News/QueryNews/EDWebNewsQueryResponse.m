//
//  EDWebNewsQueryResponse.m
//  EasyDriving
//
//  Created by Mason on 2018/12/24.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "EDWebNewsQueryResponse.h"
#import "EDNews.h"

@implementation EDWebNewsQueryResponse

+ (instancetype)parseResponse:(id)responseBody {
    
    EDWebNewsQueryResponse *response = [[EDWebNewsQueryResponse alloc]init];
    
    NSDictionary *msgBody = [response parse:responseBody];
    
    NSMutableArray *newsJson = msgBody[@"news"];
    
    if (response.isSuccess) {
        
        response.news = [self convertJson:newsJson];
    }
    
    return  response;
}

+ (NSMutableArray *)convertJson:(NSMutableArray *)newsJson {
    
    NSMutableArray *news = [NSMutableArray array];
    
    EDNews *new;
    
    for (NSDictionary *dic in newsJson) {
        
        new = [[EDNews alloc] init];
        new.title = dic[@"title"];
        new.content = dic[@"content"];
        new.imgUrl = dic[@"imageUrl"];
        new.contentUrl = dic[@"contentUrl"];
        new.createTime = dic[@"createTime"];
        [news addObject:new];
    }
    
    return news;
}


@end
