//
//  VZFSwitchNodeSpecs.h
//  VZFlexLayout
//
//  Created by wuwen on 2017/2/13.
//  Copyright © 2017年 Vizlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VZFValue.h"
#import "VZFActionWrapper.h"

namespace VZ {
    namespace DefaultAttributesValue {
        extern BOOL enable;
    };
    struct SwitchNodeSpecs {
        BOOL on;
        Value<BOOL, DefaultAttributesValue::enable> enabled;
        UIColor *onTintColor;
        UIColor *thumbTintColor;
        /// Switch value changed event. Event body: {"on": YES/NO}
        VZFEventBlock onChange;

        SwitchNodeSpecs copy() const {
            return {
                on,
                enabled,
                onTintColor,
                thumbTintColor,
                [onChange copy]
            };
        }
    };
}
