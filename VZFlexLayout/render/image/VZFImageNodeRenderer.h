//
//  VZFImageNodeRenderer.h
//  VZFlexLayout-Example
//
//  Created by pep on 2017/1/16.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "VZFRenderer.h"
#import "VZFActionWrapper.h"

@interface VZFImageNodeRenderer : VZFRenderer <VZFActionWrapper>

@property (nonatomic, strong) UIImage* image;
@property (nonatomic, assign) UIViewContentMode contentMode;
@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, assign) NSInteger animateCount;

@property (nonatomic, strong) NSString *downloadImageUrl;
@end