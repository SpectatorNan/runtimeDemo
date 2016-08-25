//
//  runtimeDemo.h
//  rutimeDemo
//
//  Created by Spectator on 16/8/24.
//  Copyright © 2016年 Spectator. All rights reserved.
//

#ifndef runtimeDemo_h
#define runtimeDemo_h

#import "objc/runtime.h"



#define SNPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

#define SNMethodProtocolNotImplementedWarning(Stuff) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wprotocol\"") \
Stuff; \
_Pragma("clang diagnostic pop") \


#define SNUndeclaredSelectorWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wundeclared-selector\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)



#endif /* runtimeDemo_h */
