//
//  HomeItemFactory.m
//  EasyDriving
//
//  Created by Mason on 2018/11/29.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "HomeItemFactory.h"
#import "HomeItem.h"

@implementation HomeItemFactory

+ (NSMutableArray *)getItems {
    
    NSMutableArray *items = [NSMutableArray array];
    
    HomeItem *gasItem = [[HomeItem alloc] init];
    gasItem.title = @"加油站";
    gasItem.bgColor = @"4a519e";
    gasItem.img = @"home_gas";
    gasItem.itemId = GAS_STATION;
    [items addObject:gasItem];
    
    HomeItem *parkItem = [[HomeItem alloc] init];
    parkItem.title = @"停车场";
    parkItem.bgColor = @"f6cf72";
    parkItem.img = @"home_park";
    parkItem.itemId = PARKING_LOT;
    [items addObject:parkItem];

    HomeItem *maintenanceItem = [[HomeItem alloc] init];
    maintenanceItem.title = @"汽车保养";
    maintenanceItem.bgColor = @"fcaa7d";
    maintenanceItem.img = @"home_maintenance";
    maintenanceItem.itemId = CAR_MAINTENANCE;
    [items addObject:maintenanceItem];
    
    HomeItem *repairItem = [[HomeItem alloc] init];
    repairItem.title = @"汽车维修";
    repairItem.bgColor = @"5bb64d";
    repairItem.img = @"home_repair";
    repairItem.itemId = CAR_REPAIR;
    [items addObject:repairItem];
    
    HomeItem *storeItem = [[HomeItem alloc] init];
    storeItem.title = @"汽车商店";
    storeItem.bgColor = @"2fa7bf";
    storeItem.img = @"home_store";
    storeItem.itemId = CAR_REPAIR;
    [items addObject:storeItem];
    
    HomeItem *callItem = [[HomeItem alloc] init];
    callItem.title = @"紧急呼救";
    callItem.bgColor = @"e86780";
    callItem.img = @"home_call";
    callItem.itemId = EMERGENCY_CALL;
    [items addObject:callItem];
    
    return items;
    
}

@end
