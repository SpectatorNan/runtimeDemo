//
//  INstanceModel.m
//  runtimeDemo
//
//  Created by spectator Mr.Z on 2016/8/26.
//  Copyright © 2016年 Spectator. All rights reserved.
//

#import "INstanceModel.h"

// 通常的方法是写两个方法分别做转换，不过如果能灵活地运用runtime的话，可以只实现一个转换方法，为此，我们需要先定义一个映射字典（全局变量）
static NSMutableDictionary *map = nil;

@implementation INstanceModel

+ (void)load {
    
    map = [NSMutableDictionary dictionary];
    
    map[@"name1"] =  @"name";
    map[@"status1"] = @"status";
    
    map[@"name2"] = @"name";
    map[@"status2"] = @"status";
}

- (void)setDataWithDic:(NSDictionary *)dic {
    
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *propertyKey = [self propertyForKey:key];
        
        if (propertyKey) {
            
            objc_property_t property = class_getProperty([self class], [propertyKey UTF8String]);
            
            // 针对特殊数据做处理
            NSString *attributeString = [NSString stringWithUTF8String:property_getAttributes(property)];
            
            NSLog(@"attributeString -- %@",attributeString);
            
            [self setValue:obj forKey:propertyKey];
        }
    }];
}

- (NSString *)propertyForKey:(NSString *)key {
    
    NSString *replaceKey = map[key];
    if (replaceKey) {
        return replaceKey;
    } else {
    
    return key;
    }
}

@end
