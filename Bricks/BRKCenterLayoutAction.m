//
//  BRKCenterLayoutAction.m
//  Bricks
//
//  Created by Makarov Yury on 27/08/16.
//  Copyright © 2016 Makarov Yury. All rights reserved.
//

#import "BRKCenterLayoutAction.h"
#import "BRKAxisValue.h"

@interface BRKCenterLayoutAction ()

@property (nonatomic, assign) CGPoint result;

@end

@implementation BRKCenterLayoutAction

- (instancetype)initWithView:(UIView *)view axis:(BRKAxis)axis initialValue:(CGPoint)initialValue {
    self = [super initWithView:view];
    if (self) {
        _axis = axis;
        _result = initialValue;
    }
    return self;
}

- (void)setOffset:(CGFloat)offset {
    if (self.axis & BRKAxisHorizontal) {
        self.result = CGPointMake(self.result.x + offset, self.result.y);
    }
    if (self.axis & BRKAxisVertical) {
        self.result = CGPointMake(self.result.x, self.result.y + offset);
    }
}

- (void)setCenterOffset:(CGPoint)resultOffset {
    self.result = resultOffset;
}

- (void)setView:(UIView *)view {
    self.result = [view.superview convertPoint:view.center toView:self.ownerView.superview];
}

- (void)setAxis:(BRKAxisValue *)axis {
    NSParameterAssert(axis.axis != BRKAxisNone);
    
    CGFloat value;
    
    if (axis.axis & BRKAxisHorizontal) {
        value = [self.ownerView.superview convertPoint:axis.view.center fromView:axis.view].x;
    } else {
        value = [self.ownerView.superview convertPoint:axis.view.center fromView:axis.view].y;
    }
    [self setOffset:value];
}
                 
- (CGRect)applyToFrame:(CGRect)frame {
    NSParameterAssert(self.axis != BRKAxisNone);
    
    if (self.axis & BRKAxisHorizontal) {
        frame = BRKRectSetCenterX(frame, self.result.x);
    }
    if (self.axis & BRKAxisVertical) {
        frame = BRKRectSetCenterY(frame, self.result.y);
    }
    return frame;
}

@end
