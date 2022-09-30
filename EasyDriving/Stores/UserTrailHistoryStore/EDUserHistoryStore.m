//
//  EDTrailHistoryStore.m
//  EasyDriving
//
//  Created by Mason on 2018/11/30.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "EDUserHistoryStore.h"
#import "EDUserHistory.h"

@implementation EDUserHistoryStore

NSMutableArray *histories;

+(void)reset:(EDUserHistory *)history {
    if(!histories || histories.count <= 0) {
        histories = [NSMutableArray array];
    }
    
    [histories removeAllObjects];
    [histories addObject:history];
    [NSKeyedArchiver archiveRootObject:histories toFile:[self getHistoryPath]];
}

+(EDUserHistory *)get {
    
    if(!histories || histories.count <= 0) {
        
        histories = [NSKeyedUnarchiver unarchiveObjectWithFile:[EDUserHistoryStore getHistoryPath]];
        
    }
    
    if (histories && histories.count > 0) {
        return [histories objectAtIndex:0];
    }
    return  nil;
}

+(void)clean {
    
    [histories removeAllObjects];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:[EDUserHistoryStore getHistoryPath] error:nil];
}

+ (NSString *)getHistoryPath {
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *path=[docPath stringByAppendingPathComponent:@"userinfo_history_store"];
    
    return path ;
}


@end
