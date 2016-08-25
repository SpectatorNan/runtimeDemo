//
//  MRCViewController.m
//  runtimeDemo
//
//  Created by Spectator on 16/8/25.
//  Copyright © 2016年 Spectator. All rights reserved.
//

#import "MRCViewController.h"

@interface MRCViewController ()

@end

@implementation MRCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)runtimeCreateInstance:(id)sender {
    
    id theObject = class_createInstance(NSString.class, sizeof(unsigned));
    
    id str1 = [theObject init];
    
    NSLog(@"%@",[str1 class]);
    
    id str2 = [[NSString alloc] initWithString:@"test"];
    NSLog(@"%@", [str2 class]);
}

@end
