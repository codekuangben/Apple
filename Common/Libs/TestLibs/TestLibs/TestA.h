#ifndef __TestA_h
#define __TestA_h

#import <Foundation/Foundation.h>

@interface TestA : NSObject
{
    // 数据成员
@protected
    int mA;
    NSString* mStr;
}

// 静态数据
//static int msB;

// 静态函数
+ (void) setB: (int) paramB;

// 成员函数
// 构造函数
- (id) init;
// 声明析构函数，析构函数只能有一个
- (void) dealloc;

// 测试一个参数
- (void) setA: (int) paramA;
// 测试多个参数
- (void) setAll: (int) paramA paramStr: (NSString*) paramC;
// 定义抽象方法
- (NSString*) stepMsg;
@end

#endif /* TestA_h */
