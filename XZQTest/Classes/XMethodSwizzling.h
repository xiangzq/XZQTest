//
//  XMethodSwizzling.h
//  InvestmentNews
//
//  Created by 项正强 on 2020/11/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMethodSwizzling : NSObject

/**
 方法交换
 @param cls 交换方法的类
 @param name1 需要交换的方法
 @param name2 自定义交换的方法
 */
+ (void) exchangeMethod:(Class _Nullable) cls
             methodName1:(SEL _Nonnull) name1
            methodName2:(SEL _Nonnull) name2;
@end

NS_ASSUME_NONNULL_END
