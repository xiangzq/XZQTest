//
//  NSArray+XCrash.m
//  InvestmentNews
//
//  Created by 项正强 on 2020/11/30.
//

#import "NSArray+XCrash.h"
#import <objc/runtime.h>
#import "XMethodSwizzling.h"

@implementation NSArray (XCrash)

+ (void) load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class method = objc_getClass("__NSArrayI");
        /// 查询方法
        [self queryMethod:method];
        
    });
}

#pragma mark 方法类型
/// 查询方法
+ (void) queryMethod:(Class _Nullable) cls {
    [XMethodSwizzling exchangeMethod:cls methodName1:@selector(objectAtIndex:) methodName2:@selector(x_objectAtIndex:)];
    [XMethodSwizzling exchangeMethod:cls methodName1:@selector(objectAtIndexedSubscript:) methodName2:@selector(x_objectAtIndexedSubscript:)];
}

- (id) x_objectAtIndex:(NSUInteger) index {
    
    /// 防止数组越界
    if (self.count - 1 < index) {
        @try {
            return [self x_objectAtIndex:index];
        } @catch (NSException *exception) {
            NSLog(@"【数组崩溃：%s，崩溃的方法：%s】",class_getName(self.class),__func__);
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
            return [self x_objectAtIndexedSubscript:index];
        } @catch (NSException *exception) {
            NSLog(@"【数组崩溃：%s，崩溃的方法：%s】",class_getName(self.class),__func__);
            NSLog(@"【%@】",[exception callStackSymbols]);
        } @finally {
            
        }
    } else {
        return [self x_objectAtIndexedSubscript:index];
    }
}


@end
