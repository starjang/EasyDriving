//
//  EDUserInfo.m
//  EasyDriving
//
//  Created by Mason on 2018/11/26.
//  Copyright © 2018 zmx. All rights reserved.
//

#import "EDUserInfo.h"

@implementation EDUserInfo

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.userId forKey:@"userId"];
    [aCoder encodeObject:self.username forKey:@"username"];
    [aCoder encodeObject:self.password forKey:@"password"];
    [aCoder encodeObject:self.nickname forKey:@"nickname"];
    [aCoder encodeObject:self.carId forKey:@"carId"];
//    [aCoder encodeInteger:self.phoneNumber forKey:@"phoneNumber"];

}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self == [super init]) {
        self.userId = [aDecoder decodeObjectForKey:@"userId"];
        self.username = [aDecoder decodeObjectForKey:@"username"];
        self.password = [aDecoder decodeObjectForKey:@"password"];
        self.nickname = [aDecoder decodeObjectForKey:@"nickname"];
        self.carId = [aDecoder decodeObjectForKey:@"carId"];
//        self.phoneNumber = [aDecoder decodeIntegerForKey:@"phoneNumber"];

    }
    
    return self;
}

@end
