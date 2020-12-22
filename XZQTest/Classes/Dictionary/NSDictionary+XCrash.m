//
//  NSDictionary+XCrash.m
//  InvestmentNews
//
//  Created by 项正强 on 2020/11/30.
//

#import "NSDictionary+XCrash.h"
#import <objc/runtime.h>
#import "XMethodSwizzling.h"

@implementation NSDictionary (XCrash)
+ (void) load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class method = objc_getClass("__NSDictionaryI");
        [self queryMethod:method];
    });
}

#pragma mark 方法类型
/// 查询方法
+ (void) queryMethod:(Class _Nullable) cls {
    [XMethodSwizzling exchangeMethod:cls methodName1:@selector(objectForKey:) methodName2:@selector(x_objectForKey:)];
    
}

#pragma mark 容错逻辑处理
- (id) x_objectForKey:(id)aKey {
    if (aKey == nil) {
        @try {
            return [self x_objectForKey:aKey];
        } @catch (NSException *exception) {
            NSLog(@"【字典崩溃：%s，崩溃的方法：%s】",class_getName(self.class),__func__);
            NSLog(@"【%@】",[exception callStackSymbols]);
        } @finally {
            
        }
    } else {
        return [self x_objectForKey:aKey];
    }
}

@end
