//
//  main.m
//  TestLibs
//
//  Created by zt-2010879 on 2017/2/20.
//  Copyright © 2017年 zt-2010879. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TestA.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        TestA* testA = [[TestA alloc] init];
        [testA setA: 10	];
        
    }
    return 0;
}
