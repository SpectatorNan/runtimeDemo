//
//  AssociatedObjectViewController.m
//  runtimeDemo
//
//  Created by spectator Mr.Z on 2016/8/26.
//  Copyright © 2016年 Spectator. All rights reserved.
//

#import "AssociatedObjectViewController.h"

@implementation AssociatedObjectViewController

static const char kSNActionHandlerTapGestureKey;
static const char kSNActionHandlerTapBlockKey;

// 这段代码检测了手势识别的关联对象。如果没有，则创建并建立关联关系。同时，将传入的块对象连接到指定的key上。注意block对象的关联内存管理策略。
- (void)setTapActionWithBlock:(void(^)(void))block {
    
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &kSNActionHandlerTapGestureKey);
    
    if (!gesture) {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(__handleActionForTapGesture:)];
        [self.view addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kSNActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    
    objc_setAssociatedObject(self, &kSNActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
}


// 手势识别对象需要一个target和action，所以接下来我们定义处理方法
- (void)__handleActionForTapGesture:(UITapGestureRecognizer *)gesture {
    // 检测手势识别对象的状态，我们只需在点击手势呗识别出来时才执行操作。
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        
        void(^action)() = objc_getAssociatedObject(self, &kSNActionHandlerTapBlockKey);
        
        if (action) {
            action();
        }
    }
}

@end
