//
//  TestMetaClassViewController.m
//  rutimeDemo
//
//  Created by Spectator on 16/8/24.
//  Copyright © 2016年 Spectator. All rights reserved.
//

#import "TestMetaClassViewController.h"


@interface TestMetaClassViewController ()

@end


void TestMetaClass(id self, SEL _cmd) {
    
    NSLog(@"This object is %p",self);
    
    NSLog(@"Class is %@, super class is %@",[self class], [self superclass]);
    
    Class currentClass = [self class];
    
    for (int i = 0; i < 4; i++) {
        
        NSLog(@"Following the isa pointer %d times gives %p", i , currentClass);
        
        currentClass = objc_getClass((__bridge void *)currentClass);
        
    }
    
    NSLog(@"NSObject's class is %p",[NSObject class]);
    
    NSLog(@"NSObject's meta class is %p",objc_getClass((__bridge void *)[NSObject class]));
}

@implementation TestMetaClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)useTestMetaClass:(id)sender {
    
    Class newClass = objc_allocateClassPair([NSError class], "TestClass", 0);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    class_addMethod(newClass, @selector(testMetaClass), (IMP)TestMetaClass, "v@:");
    // 还能创建一遍  第二次注册  内存中已存在 再注册会崩溃
    objc_registerClassPair(newClass);
    
    
    id instance = [[newClass alloc] initWithDomain:@"some domain" code:0 userInfo:nil];
    
    [instance performSelector:@selector(testMetaClass)];
#define push @#clang diagnostic pop
    
}



@end
