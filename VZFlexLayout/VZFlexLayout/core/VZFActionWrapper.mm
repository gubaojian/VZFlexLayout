//
//  VZFActionWrapper.m
//  VZFlexLayout
//
//  Created by Sleen on 16/2/29.
//  Copyright © 2016年 Vizlab. All rights reserved.
//

#import "VZFActionWrapper.h"
#import "VZFNodeViewManager.h"
#import "VZFNodeInternal.h"

@implementation BlockWrapper
- (instancetype)initWithBlock:(UIControlActionBlock)block {
    if (self = [super init]) {
        self.block = block;
    }
    return self;
}

- (void) dealloc {
    self.block = nil;
}

- (void) invoke:(id)sender event:(UIEvent *)event {
    self.block(sender);
}
@end


@implementation SelectorWrapper
{
    SEL _selector;
}

- (instancetype)initWithSelector:(SEL)selector {
    if (self = [super init]) {
        _selector = selector;
    }
    return self;
}

- (void)invoke:(UIControl *)sender event:(UIEvent *)event {
    id responder = [sender.node responderForSelector:_selector];
    NSAssert(responder, @"could not found responder for action '%@'", NSStringFromSelector(_selector));
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [responder performSelector:_selector withObject:sender.node withObject:event];
#pragma clang diagnostic pop
}

@end


id<VZFActionWrapper> vz_actionWrapper(VZ::ActionWrapper action) {
    if (action.block) {
        return [[BlockWrapper alloc] initWithBlock:action.block];
    }
    else if (action.selector) {
        return [[SelectorWrapper alloc] initWithSelector:action.selector];
    }
    return nil;
}