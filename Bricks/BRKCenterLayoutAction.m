//
//  BRKCenterLayoutAction.m
//  Bricks
//
//  Created by Makarov Yury on 27/08/16.
//  Copyright © 2016 Makarov Yury. All rights reserved.
//

#import "BRKCenterLayoutAction.h"
#import "BRKAxisValue.h"

@implementation BRKCenterLayoutAction

- (instancetype)initWithView:(UIView *)view axis:(BRKAxis)axis {
    self = [super initWithView:view];
    if (self) {
        _axis = axis;
        _targetPoint = view.center;
    }
    return self;
}

- (instancetype)initWithView:(UIView *)view {
    return [self initWithView:view axis:BRKAxisNone];
}

- (void)setNumberAttribute:(CGFloat)value {
    if (self.axis & BRKAxisHorizontal) {
        self.targetPoint = CGPointMake(value, self.targetPoint.y);
    }
    if (self.axis & BRKAxisVertical) {
        self.targetPoint = CGPointMake(self.targetPoint.x, value);
    }
}

- (void)setPointAttribute:(CGPoint)point {
    self.targetPoint = point;
}

- (void)setRectAttribute:(CGRect)rect {
    self.targetPoint = BRKRectGetCenter(rect);
}

- (void)setViewAttribute:(UIView *)value {
    self.targetPoint = [value convertPoint:value.center toView:self.view];
}

- (void)setAxisAttribute:(BRKAxisValue *)attr {
    NSParameterAssert(attr.axis != BRKAxisNone);
    
    CGFloat value;
    
    if (attr.axis & BRKAxisHorizontal) {
        value = [self.view.superview convertPoint:attr.view.center fromView:attr.view].x;
    } else {
        value = [self.view.superview convertPoint:attr.view.center fromView:attr.view].y;
    }
    [self setNumberAttribute:value];
}
                 
- (CGRect)applyToFrame:(CGRect)frame {
    NSParameterAssert(self.axis != BRKAxisNone);
    
    if (self.axis & BRKAxisHorizontal) {
        frame = BRKRectSetCenterX(frame, self.targetPoint.x + self.insets.left - self.insets.right);
    }
    if (self.axis & BRKAxisVertical) {
        frame = BRKRectSetCenterY(frame, self.targetPoint.y + self.insets.top - self.insets.bottom);
    }
    return frame;
}

@end
