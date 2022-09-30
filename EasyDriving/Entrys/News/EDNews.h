//
//  EDNews.h
//  EasyDriving
//
//  Created by Mason on 2018/12/24.
//  Copyright © 2018 zmx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EDNews : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *contentUrl;
@property (nonatomic, strong) NSString *createTime;

@end

NS_ASSUME_NONNULL_END
