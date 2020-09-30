//
//  main.m
//  TestLibs

#import <Foundation/Foundation.h>
#import "TestA.h"

int main(int argc, const char * argv[])
{
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        TestA* testA = [[TestA alloc] init];
        [testA setA: 10];
        [testA setAll: 10 paramStr: @"name"];
        
        [TestA setB: 20];
    }
    return 0;
}
