//
//  MyClass.m
//  runtimeDemo
//
//  Created by spectator Mr.Z on 2016/8/24.
//  Copyright © 2016年 Spectator. All rights reserved.
//

#import "MyClass.h"

@interface MyClass ()
{
    NSInteger _instance1;
    
    NSString *_instance2;
}

@property (nonatomic,assign) NSUInteger  integer;

- (void)method3withArg1:(NSInteger)arg1 arg2:(NSString *)arg2;
@end

//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wprotocol"
//#define push @#clang diagnostic pop
SNMethodProtocolNotImplementedWarning(
@implementation MyClass
)
+ (void)classMethod1 {
    
}

- (void)method1 {
     NSLog(@"call method method1");
}

- (void)method2 {
    
}

- (void)method3withArg1:(NSInteger)arg1 arg2:(NSString *)arg2 {
    
    NSLog(@"arg1 : %ld, arg2 : %@",arg1,arg2);
}

@end
