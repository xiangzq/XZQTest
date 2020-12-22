//
//  XMethodSwizzling.m
//  InvestmentNews
//
//  Created by 项正强 on 2020/11/30.
//

#import "XMethodSwizzling.h"
#import <objc/runtime.h>

@implementation XMethodSwizzling

/// 方法交换
+ (void) exchangeMethod:(Class _Nullable) cls
             methodName1:(SEL _Nonnull) name1
             methodName2:(SEL _Nonnull) name2 {
    Method m1 = class_getInstanceMethod(cls, name1);
    Method m2 = class_getInstanceMethod(cls, name2);
    method_exchangeImplementations(m1, m2);
}

@end
