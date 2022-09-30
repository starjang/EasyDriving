//
//  DPWebBaseResponse.h
//  EasyDriving
//
//  Created by Mason on 2018/11/14.
//  Copyright © 2018 zmx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EDWebBaseResponse : NSObject


/**
 *  错误代码
 */
@property(nonatomic,assign)NSInteger errorCode;
/**
 *  错误信息
 */
@property(nonatomic,strong)NSString *msg;

/**
 *  是否请求成功
 */
@property(nonatomic,assign)BOOL isSuccess;
/**
 *  时间戳
 */
@property(nonatomic,strong) NSDate *timestamp ;

/**
 *  解析返回内容，并返回消息主题dictionary
 *
 *  @param responseJson 服务器返回内容
 *
 *  @return 解析数据
 */
-(id)parse:(id)responseJson;

/**
 *  初始化一个错误的请求返回
 *
 *  @return errorResponse
 */
+(instancetype)initErrorResponse;
/**
 *   初始化一个默认的只包含错误信息的JSON
 *
 *  @param responseJson json
 *
 *  @return response
 */
+(instancetype)initWithDefaultResponse:(id)responseJson ;

+(NSString *)parseEmpty:(id)info;

@end

NS_ASSUME_NONNULL_END
