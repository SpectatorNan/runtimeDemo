//
//  ViewController.m
//  rutimeDemo
//
//  Created by Spectator on 16/8/24.
//  Copyright © 2016年 Spectator. All rights reserved.
//

#import "ViewController.h"
#import "MyClass.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    NSLog(@" nil class name %s", object_getClassName(nil));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)myClassExample:(id)sender {
    
    MyClass *myClass = [[MyClass alloc] init];
    
    unsigned int outCount = 0;
    
    Class cls = myClass.class;
    
    //类名
    NSLog(@"class name: %s",class_getName(cls));
    
    NSLog(@"===================================");
    
    // 父类
    NSLog(@"super class name: %s",class_getName(class_getSuperclass(cls)));
    
    
     NSLog(@"===================================");
    
    // 是否是元类
    
    NSLog(@"MyClass is %@ a meta-class",class_isMetaClass(cls)? @"" : @"not");
    
 
    NSLog(@"===================================");
    
    Class meta_class = objc_getMetaClass(class_getName(cls));
    NSLog(@"%s's meta-class is %s",class_getName(cls),class_getName(meta_class));
    
    NSLog(@"===================================");
    
    
    // 变量实例大小
    NSLog(@"instance size: %zu", class_getInstanceSize(cls));
    
     NSLog(@"===================================");
    
    // 成员变量
    Ivar *ivars = class_copyIvarList(cls, &outCount);
    
    for (int i = 0; i < outCount; i++) {
        Ivar ivar = ivars[i];
        
        NSLog(@"instance variable's name: %s at index: %d",ivar_getName(ivar),i);
    }
    
    /**
     *  一定要记得free
     */
    
    free(ivars);
    
    
    Ivar string = class_getInstanceVariable(cls, "_string");
    if (string != NULL) {
        NSLog(@"instance variable %s",ivar_getName(string));
    }
    
     NSLog(@"===================================");
    
    
    // 属性操作
    objc_property_t *properties = class_copyPropertyList(cls, &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        
        NSLog(@"property's name: %s",property_getName(property));
    }
    
    free(properties);
    
    
    objc_property_t array = class_getProperty(cls, "array");
    if (array != NULL) {
        NSLog(@"property %s",property_getName(array));
    }
    
     NSLog(@"===================================");
    
    // 方法操作
    Method * methods = class_copyMethodList(cls, &outCount);
    for (int i = 0; i < outCount; i++) {
        
        Method method = methods[i];
        NSLog(@"method's signature: %s",sel_getName(method_getName(method)));
    }
    
    free(methods);
    
    Method method1 = class_getInstanceMethod(cls, @selector(method1));
    if (method1 != NULL) {
        NSLog(@"method %s", sel_getName(method_getName(method1)));
    }
    
    
    Method classMethod = class_getClassMethod(cls, @selector(classMethod1));
    if (classMethod != NULL) {
        NSLog(@"class method : %s",sel_getName(method_getName(classMethod)));
    }
    
    SNUndeclaredSelectorWarning(
    NSLog(@"MyClass is %@ responsed to selector: method3withArg1:arg2",class_respondsToSelector(cls, @selector(method3withArg1:arg2:))?@"":@"not");
    );
    
    IMP imp = class_getMethodImplementation(cls, @selector(method1));
    imp();
    
    
    
    NSLog(@"===================================");
    
    
    // 协议
    
    Protocol * __unsafe_unretained * protocols = class_copyProtocolList(cls, &outCount);
    
    Protocol * protocol;
    for (int i = 0; i < outCount; i ++) {
        protocol = protocols[i];
        
        NSLog(@"protocol name: %s", protocol_getName(protocol));
    }
    
    NSLog(@"MyClass is %@ responsed to protocol %s",class_conformsToProtocol(cls, protocol)?@"":@"not",protocol_getName(protocol));
    
    NSLog(@"===================================");
}

void imp_submethod1(id self, SEL _cmd) {
    NSLog(@"run sub method 1");
}

- (IBAction)runtimeCreateClass {
    
    Class cls = objc_allocateClassPair(MyClass.class, "MySubClass", 0);
    SNUndeclaredSelectorWarning(
    class_addMethod(cls, @selector(submethod1), (IMP)imp_submethod1, "v@:");
                                class_replaceMethod(cls, @selector(method1), (IMP)imp_submethod1, "v@:"););
    class_addIvar(cls, "_ivar1", sizeof(NSString *), log(sizeof(NSString *)), "i");
    
    objc_property_attribute_t type = {
        "T",
        "@\"NSString\""
    };
    objc_property_attribute_t ownership = { "C", "" };
    objc_property_attribute_t backingivar = { "V", "_ivar"};
    objc_property_attribute_t attrs[] = {type,ownership,backingivar};
    
    class_addProperty(cls, "property2", attrs, 3);
    objc_registerClassPair(cls);
    
    id instance = [[cls alloc] init];
    SNUndeclaredSelectorWarning(
    [instance performSelector:@selector(submethod1)];
    [instance performSelector:@selector(method1)];
                                );
}


@end

