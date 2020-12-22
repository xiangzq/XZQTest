//
//  NSMutableDictionary+XCrash.m
//  InvestmentNews
//
//  Created by 项正强 on 2020/11/30.
//

#import "NSMutableDictionary+XCrash.h"
#import <objc/runtime.h>
#import "XMethodSwizzling.h"

@implementation NSMutableDictionary (XCrash)

+ (void) load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class method = objc_getClass("__NSDictionaryM");
        [self queryMethod:method];
        [self insertMethod:method];
        [self removeMethod:method];
    });
}

#pragma mark 方法类型
/// 查询方法
+ (void) queryMethod:(Class _Nullable) cls {
    [XMethodSwizzling exchangeMethod:cls methodName1:@selector(objectForKey:) methodName2:@selector(x_objectForKey:)];
    
}

/// 插入方法
+ (void) insertMethod:(Class _Nullable) cls {
    [XMethodSwizzling exchangeMethod:cls methodName1:@selector(setObject:forKey:) methodName2:@selector(x_setObject:forKey:)];
    
}

/// 删除方法
+ (void) removeMethod:(Class _Nullable) cls {
    [XMethodSwizzling exchangeMethod:cls methodName1:@selector(removeObjectForKey:) methodName2:@selector(x_removeObjectForKey:)];
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

- (void) x_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if (aKey != nil) {
        [self x_setObject:anObject forKey:aKey];
    } else {
        NSLog(@"字典key为nil");
    }
}

- (void) x_removeObjectForKey:(id)aKey {
    if (aKey != nil) {
        [self x_removeObjectForKey:aKey];
    } else {
        NSLog(@"字典key为nil");
    }
}

@end
