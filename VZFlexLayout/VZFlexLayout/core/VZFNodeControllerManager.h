//
//  VZFNodeControllerManager.h
//  VZFlexLayout
//
//  Created by moxin on 16/4/10.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VZFNodeController;
@interface VZFNodeControllerManager : NSObject

+ (instancetype)sharedInstance;
+ (VZFNodeController* )controllerForNodeClass:(Class) clz;

@end
