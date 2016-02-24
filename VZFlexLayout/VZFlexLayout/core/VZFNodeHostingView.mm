//
//  VZFNodeHostingView.m
//  VZFlexLayout
//
//  Created by moxin on 16/1/28.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFNodeHostingView.h"
#import "VZFNodeViewManager.h"
#import "VZFMacros.h"
#import "VZFNode.h"
#import "VZFNodeInternal.h"

@interface VZFNodeHostingView()
{
    Class<VZFNodeProvider> _nodeProvider;
    id<VZSizeRangeProvider> _sizeProvider;
    UIView* _containerView;
    VZFNode* _node;
}

@end

@implementation VZFNodeHostingView

- (id)initWithFrame:(CGRect)frame{
    VZ_NOT_DESIGNATED_INITIALIZER();
}


- (id)initWithNodeProvider:(Class<VZFNodeProvider>)nodeProvider RangeProvider:(id<VZSizeRangeProvider>)sizeProvider{

    self = [super initWithFrame:CGRectZero];
    if (self) {
        _nodeProvider = nodeProvider;
        _sizeProvider = sizeProvider;
        _containerView = [[UIView alloc]initWithFrame:CGRectZero];
        _containerView.backgroundColor = [UIColor blackColor];
        [self addSubview:_containerView];
            
    }
    return self;
}

- (void)renderWithState:(id)state{

    _node = [_nodeProvider nodeForItem:state context:nil];
    CGSize size = [_sizeProvider rangeSizeForBounds:self.bounds.size];
    VZFNodeLayout layout = [_node computeLayoutThatFits:size];
    NSLog(@"%s",layout.description().c_str());
    CGFloat containerWidth = layout.nodeSize().width + layout.nodeMargin().left + layout.nodeMargin().right;
    CGFloat containerHeight = layout.nodeSize().height + layout.nodeMargin().top + layout.nodeMargin().bottom;
    _containerView.frame = {{0,0}, {containerWidth, containerHeight}};
    UIView* fView = [VZFNodeViewManager viewForNode:_node withLayoutSpec:layout];
    if (fView) {
        
        [_containerView addSubview:fView];
        
        if ([self.delegate respondsToSelector:@selector(hostingViewDidInvalidate:)]) {
            [self.delegate hostingViewDidInvalidate:_containerView.frame.size];
        }
    }

}

- (void)renderWithState:(id)state reuseView:(UITableViewCell *)reuseView {
    _node = [_nodeProvider nodeForItem:state context:nil];
    CGSize size = [_sizeProvider rangeSizeForBounds:self.bounds.size];
    VZFNodeLayout layout = [_node computeLayoutThatFits:size];
    NSLog(@"%s",layout.description().c_str());
    CGFloat containerWidth = layout.nodeSize().width + layout.nodeMargin().left + layout.nodeMargin().right;
    CGFloat containerHeight = layout.nodeSize().height + layout.nodeMargin().top + layout.nodeMargin().bottom;
    _containerView.frame = {{0,0}, {containerWidth, containerHeight}};
    
    UIView* fView;
    
    //reuse的时候cell固定有一层hostView和containerView
    if (reuseView.contentView.subviews.count > 0 && reuseView.contentView.subviews[0].subviews.count >0 && reuseView.contentView.subviews[0].subviews[0].subviews.count > 0) {
        fView = [VZFNodeViewManager viewForNode:_node withLayoutSpec:layout reuseView:reuseView.contentView.subviews[0].subviews[0].subviews[0]];
    } else {
        fView = [VZFNodeViewManager viewForNode:_node withLayoutSpec:layout reuseView:nil];
    }
    if (fView) {
        
        [_containerView addSubview:fView];
        
        if ([self.delegate respondsToSelector:@selector(hostingViewDidInvalidate:)]) {
            [self.delegate hostingViewDidInvalidate:_containerView.frame.size];
        }
    }
}



@end
