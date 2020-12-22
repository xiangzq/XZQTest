//
//  NSMutableArray+XCrash.m
//  InvestmentNews
//
//  Created by 项正强 on 2020/11/30.
//

#import "NSMutableArray+XCrash.h"
#import <objc/runtime.h>
#import "XMethodSwizzling.h"

@implementation NSMutableArray (XCrash)

+ (void) load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class method = objc_getClass("__NSArrayM");
        [self queryMethod:method];
        [self insertMethod:method];
        [self replaceMethod:method];
        [self removeMethod:method];
    });
}

#pragma mark 方法类型
/// 查询方法
+ (void) queryMethod:(Class _Nullable) cls {
    [XMethodSwizzling exchangeMethod:cls methodName1:@selector(objectAtIndex:) methodName2:@selector(x_objectAtIndex:)];
    [XMethodSwizzling exchangeMethod:cls methodName1:@selector(objectAtIndexedSubscript:) methodName2:@selector(x_objectAtIndexedSubscript:)];
}

/// 插入方法
+ (void) insertMethod:(Class _Nullable) cls {
    [XMethodSwizzling exchangeMethod:cls methodName1:@selector(insertObject:atIndex:) methodName2:@selector(x_insertObject:atIndex:)];
    [XMethodSwizzling exchangeMethod:cls methodName1:@selector(addObject:) methodName2:@selector(x_addObject:)];
}

/// 替换方法
+ (void) replaceMethod:(Class _Nullable) cls {
    [XMethodSwizzling exchangeMethod:cls methodName1:@selector(replaceObjectAtIndex:withObject:) methodName2:@selector(x_replaceObjectAtIndex:withObject:)];
}

/// 删除方法
+ (void) removeMethod:(Class _Nullable) cls {
    [XMethodSwizzling exchangeMethod:cls methodName1:@selector(removeObjectAtIndex:) methodName2:@selector(x_removeObjectAtIndex:)];
}

#pragma mark 容错逻辑处理
- (id) x_objectAtIndex:(NSUInteger) index {
    /// 防止数组越界
    if (self.count - 1 < index) {
        @try {
            return [self x_objectAtIndex:index];
        } @catch (NSException *exception) {
            NSLog(@"【可变数组崩溃：%s，崩溃的方法：%s】",class_getName(self.class),__func__);
            NSLog(@"【%@】",[exception callStackSymbols]);
        } @finally {
            
        }
    } else {
        return [self x_objectAtIndex:index];
    }
}

- (id) x_objectAtIndexedSubscript:(NSUInteger) index {
    /// 防止数组越界
    if (self.count - 1 < index) {
        @try {
            return [self x_objectAtIndex:index];
        } @catch (NSException *exception) {
            NSLog(@"【可变数组崩溃：%s，崩溃的方法：%s】",class_getName(self.class),__func__);
            NSLog(@"【%@】",[exception callStackSymbols]);
        } @finally {
            
        }
    } else {
        return [self x_objectAtIndexedSubscript:index];
    }
}

- (void) x_insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (anObject != nil) {
        [self x_insertObject:anObject atIndex:index];
    } else {
        NSLog(@"插入到数组的元素为nil");
    }
}

- (void) x_addObject:(id)anObject {
    if (anObject != nil) {
        [self x_addObject:anObject];
    } else {
        NSLog(@"添加到数组的元素为nil");
    }
}

- (void) x_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    if (anObject != nil) {
        [self x_insertObject:anObject atIndex:index];
    } else {
        NSLog(@"替换的元素为nil");
    }
}

- (void) x_removeObjectAtIndex:(NSUInteger)index {
    /// 防止数组越界
    if (self.count - 1 < index) {
        NSLog(@"数组越界");
    } else {
        [self x_removeObjectAtIndex:index];
    }
}

@end
