//
//  INstanceModel.h
//  runtimeDemo
//
//  Created by spectator Mr.Z on 2016/8/26.
//  Copyright © 2016年 Spectator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface INstanceModel : NSObject

@property (nonatomic, copy) NSString * name;

@property (nonatomic, copy) NSString * status;


- (void)setDataWithDic:(NSDictionary *)dic;
@end
