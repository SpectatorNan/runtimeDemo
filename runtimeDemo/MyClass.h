//
//  MyClass.h
//  runtimeDemo
//
//  Created by spectator Mr.Z on 2016/8/24.
//  Copyright © 2016年 Spectator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyClass : NSObject<NSCopying,NSCoding>

@property (nonatomic, strong) NSArray *array;
@property (nonatomic, copy) NSString *string;

- (void)method1;

- (void)method2;

+ (void)classMethod1;

@end
