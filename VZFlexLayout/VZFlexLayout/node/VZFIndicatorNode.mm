//
//  VZFIndicatorNode.m
//  O2OReact
//
//  Created by Sleen on 16/6/28.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "VZFIndicatorNode.h"
#import "VZFIndicatorNodeSpecs.h"
#import "VZFNodeSubClass.h"
#import "VZFNodeInternal.h"
#import "VZFIndicatorView.h"
#import "VZFlexNode.h"
#import "VZFMacros.h"

@implementation VZFIndicatorNode

+ (instancetype)newWithView:(const ViewClass &)viewClass NodeSpecs:(const NodeSpecs &)specs{
    VZ_NOT_DESIGNATED_INITIALIZER();
}

+ (id)newWithIndicatorAttributes:(const VZ::IndicatorNodeSpecs &)indicatorSpecs NodeSpecs:(const VZ::NodeSpecs &)specs {
    VZFIndicatorNode* indicatorNode = [super newWithView:[VZFIndicatorView class] NodeSpecs:specs];
    
    if (indicatorNode) {
        indicatorNode -> _indicatorSpecs = indicatorSpecs.copy();
        
        __weak typeof(indicatorNode) weakNode = indicatorNode;
        indicatorNode.flexNode.measure = ^(CGSize constraintedSize) {
            
            __strong typeof(weakNode) strongNode = weakNode;
            
            if (!strongNode) {
                return CGSizeZero;
            }
            
            return CGSize{ 20, 20 };
        };
    }
    return indicatorNode;
}

@end