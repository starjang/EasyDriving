//
//  DPWebBaseRequest.h
//  EasyDriving
//
//  Created by Mason on 2018/11/14.
//  Copyright © 2018 zmx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EDWebBaseRequest : NSObject

+(NSString *)initDefaultRequestJson;

/**
 *  对主题json添加公共部分和用户信息
 *
 *  @param msgBodys mesBodys
 *
 *  @return dictionary
 */
- (NSMutableDictionary *)addMsgBody:(id)msgBodys;

/**
 *  将字典转换为json
 *
 *  @param parameters 对象
 *
 *  @return Json
 */
- (NSString *)toJson:(id)parameters;

@end

NS_ASSUME_NONNULL_END
