//
//  BRKSizeLayoutAction.m
//  Bricks
//
//  Created by Makarov Yury on 27/08/16.
//  Copyright © 2016 Makarov Yury. All rights reserved.
//

#import "BRKSizeLayoutAction.h"
#import "BRKLayoutGeometry.h"

@implementation BRKSizeLayoutAction

- (instancetype)initWithView:(UIView *)view axis:(BRKAxis)axis {
    self = [super initWithView:view];
    if (self) {
        _axis = axis;
        _targetSize = view.superview.bounds.size;
    }
    return self;
}

- (instancetype)initWithView:(UIView *)view {
    return [self initWithView:view axis:BRKAxisNone];
}

- (void)setNumberAttribute:(CGFloat)value {
    if (self.axis & BRKAxisHorizontal) {
        self.targetSize = CGSizeMake(value, self.targetSize.height);
    }
    if (self.axis & BRKAxisVertical) {
        self.targetSize = CGSizeMake(self.targetSize.width, value);
    }
}

- (void)setSizeAttribute:(CGSize)size {
    self.targetSize = size;
}

- (void)setRectAttribute:(CGRect)rect {
    self.targetSize = rect.size;
}

- (void)setViewAttribute:(UIView *)view {
    self.targetSize = view.bounds.size;
}

- (CGRect)applyToFrame:(CGRect)frame {
    NSParameterAssert(self.axis != BRKAxisNone);
    
    if (self.axis & BRKAxisHorizontal) {
        frame = CGRectSetWidth(frame, self.targetSize.width - self.insets.left - self.insets.right);
    }
    if (self.axis & BRKAxisVertical) {
        frame = CGRectSetHeight(frame, self.targetSize.height - self.insets.top - self.insets.bottom);
    }
    return frame;
}

@end
