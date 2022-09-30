//
//  EDUserHistory.m
//  EasyDriving
//
//  Created by Mason on 2018/11/29.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "EDUserHistory.h"

@implementation EDUserHistory

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.historyId forKey:@"historyId"];
    [aCoder encodeDouble:self.latitude forKey:@"latitude"];
    [aCoder encodeDouble:self.longitude forKey:@"longitude"];
    [aCoder encodeObject:self.historyName forKey:@"trailName"];
    [aCoder encodeObject:self.historyAddress forKey:@"trailAddress"];
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self == [super init]) {
        self.historyId = [aDecoder decodeObjectForKey:@"historyId"];
        self.latitude = [aDecoder decodeDoubleForKey:@"latitude"];
        self.longitude = [aDecoder decodeDoubleForKey:@"longitude"];
        self.historyName = [aDecoder decodeObjectForKey:@"trailName"];
        self.historyAddress = [aDecoder decodeObjectForKey:@"trailAddress"];        
    }
    
    return self;
}

@end
