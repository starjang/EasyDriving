//
//  UserItemFactory.m
//  EasyDriving
//
//  Created by Mason on 2018/11/26.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "UserItemFactory.h"
#import "BaseHeader.h"
#import "UserItem.h"

@implementation UserItemFactory

+ (NSMutableArray *)getItems {
    
    NSMutableArray *items = [NSMutableArray array];
    
    NSMutableArray *section1 = [NSMutableArray array];
    
    UserItem *info = [[UserItem alloc]init];
    info.imgStr = @"ion-ios-person";
    info.contentStr = @"个人信息";
    info.itemId = USER_INFO;
    [section1 addObject:info];

    UserItem *historyOrder = [[UserItem alloc]init];
    historyOrder.imgStr = @"ion-android-menu";
    historyOrder.contentStr = @"历史预定";
    historyOrder.itemId = HISTORY_ORDER;
    [section1 addObject:historyOrder];
    
    UserItem *historyPlace = [[UserItem alloc]init];
    historyPlace.imgStr = @"ion-ios-navigate";
    historyPlace.contentStr = @"历史足迹";
    historyPlace.itemId = HISTORY_PLACE;
    [section1 addObject:historyPlace];
    
    UserItem *myPoints = [[UserItem alloc]init];
    myPoints.imgStr = @"ion-ios-star";
    myPoints.contentStr = @"我的积分";
    myPoints.itemId = MY_POINT;
    [section1 addObject:myPoints];
    
    NSMutableArray *section2 = [NSMutableArray array];
    UserItem *clean = [[UserItem alloc]init];
    clean.imgStr = @"ion-ios-trash";
    clean.contentStr = @"清除缓存";
    clean.itemId = CLEAN_CACHE;
    [section2 addObject:clean];
    
    UserItem *loginOut = [[UserItem alloc]init];
    loginOut.imgStr = @"ion-android-exit";
    loginOut.contentStr = @"退出登录";
    loginOut.itemId = LOG_OUT;
    [section2 addObject:loginOut];
    
    [items addObject:section1];
    [items addObject:section2];
    
    return items;
}

@end
