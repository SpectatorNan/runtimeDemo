//
//  ViewController.m
//  rutimeDemo
//
//  Created by Spectator on 16/8/24.
//  Copyright © 2016年 Spectator. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@" nil class name %s", object_getClassName(nil));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
