//
//  EDUserStore.m
//  EasyDriving
//
//  Created by Mason on 2018/11/26.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "EDUserStore.h"

@implementation EDUserStore

NSMutableArray *users;

+(void)reset:(EDUserInfo *)userInfo {
    if(!users || users.count <= 0) {
        users = [NSMutableArray array];
    }
    [users removeAllObjects];
    [users addObject:userInfo];
    [NSKeyedArchiver archiveRootObject:users toFile:[self getUserInfoPath]];
}

+(EDUserInfo *)get {
    
    if(!users || users.count <= 0) {
        
        users = [NSKeyedUnarchiver unarchiveObjectWithFile:[EDUserStore getUserInfoPath]];
        
    }
    
    if (users && users.count > 0) {
        return [users objectAtIndex:0];
    }
    return  nil;
}

+(void)clean {
    
    [users removeAllObjects];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:[EDUserStore getUserInfoPath] error:nil];
}

+(NSString *)getUserInfoPath {
    NSString *docPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *path=[docPath stringByAppendingPathComponent:@"userinfo_store"];
    
    return path ;
}

@end
