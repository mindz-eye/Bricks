//
//  BRKEdgeLayoutAction.m
//  Bricks
//
//  Created by Makarov Yury on 27/08/16.
//  Copyright © 2016 Makarov Yury. All rights reserved.
//

#import "BRKEdgeLayoutAction.h"
#import "BRKLayoutGeometry.h"
#import "BRKEdgeValue.h"

typedef CGRect(*CGRectFunc)(CGRect, CGFloat);

CGRectFunc CGRectFuncForEdgeAction(BRKEdgeActionType type, UIRectEdge edge) {
    if (edge == UIRectEdgeTop) {
        return type == BRKEdgeActionTypeMove ? CGRectMoveTop : CGRectSetTop;
    } else if (edge == UIRectEdgeLeft) {
        return type == BRKEdgeActionTypeMove ? CGRectMoveLeft : CGRectSetLeft;
    } else if (edge == UIRectEdgeBottom) {
        return type == BRKEdgeActionTypeMove ? CGRectMoveBottom : CGRectSetBottom;
    } else if (edge == UIRectEdgeRight) {
        return type == BRKEdgeActionTypeMove ? CGRectMoveRight : CGRectSetRight;
    } else {
        NSCParameterAssert(NO);
        return NULL;
    }
}


@implementation BRKEdgeLayoutAction

- (instancetype)initWithView:(UIView *)view edges:(UIRectEdge)edges {
    self = [super initWithView:view];
    if (self) {
        _edges = edges;
        _targetFrame = view.superview.bounds;
    }
    return self;
}

- (instancetype)initWithView:(UIView *)view {
    return [self initWithView:view edges:UIRectEdgeNone];
}

- (void)setNumberAttribute:(CGFloat)value {
    NSParameterAssert(self.edges != UIRectEdgeNone);
    
    if (self.edges & UIRectEdgeTop) {
        self.insets = UIEdgeInsetsByAddingEdgeInsets(self.insets, UIEdgeInsetsMake(value, 0, 0, 0));
    }
    if (self.edges & UIRectEdgeLeft) {
        self.insets = UIEdgeInsetsByAddingEdgeInsets(self.insets, UIEdgeInsetsMake(0, value, 0, 0));
    }
    if (self.edges & UIRectEdgeBottom) {
        self.insets = UIEdgeInsetsByAddingEdgeInsets(self.insets, UIEdgeInsetsMake(0, 0, -value, 0));
    }
    if (self.edges & UIRectEdgeRight) {
        self.insets = UIEdgeInsetsByAddingEdgeInsets(self.insets, UIEdgeInsetsMake(0, 0, 0, -value));
    }
}

- (void)setRectAttribute:(CGRect)rect {
    self.targetFrame = rect;
}

- (void)setViewAttribute:(UIView *)view {
    CGRect viewFrame = [view convertRect:view.bounds toView:self.view.superview];

    CGFloat value;
    if (self.edges & UIRectEdgeTop) {
        value = CGRectGetDistanceFromEdgeToEdgeInRect(viewFrame, UIRectEdgeTop, self.targetFrame, UIRectEdgeTop);
        self.insets = UIEdgeInsetsByAddingEdgeInsets(self.insets, UIEdgeInsetsMake(value, 0, 0, 0));
    }
    if (self.edges & UIRectEdgeLeft) {
        value = CGRectGetDistanceFromEdgeToEdgeInRect(viewFrame, UIRectEdgeLeft, self.targetFrame, UIRectEdgeLeft);
        self.insets = UIEdgeInsetsByAddingEdgeInsets(self.insets, UIEdgeInsetsMake(0, value, 0, 0));
    }
    if (self.edges & UIRectEdgeBottom) {
        value = CGRectGetDistanceFromEdgeToEdgeInRect(viewFrame, UIRectEdgeBottom, self.targetFrame, UIRectEdgeBottom);
        self.insets = UIEdgeInsetsByAddingEdgeInsets(self.insets, UIEdgeInsetsMake(0, 0, value, 0));
    }
    if (self.edges & UIRectEdgeRight) {
        value = CGRectGetDistanceFromEdgeToEdgeInRect(viewFrame, UIRectEdgeRight, self.targetFrame, UIRectEdgeRight);
        self.insets = UIEdgeInsetsByAddingEdgeInsets(self.insets, UIEdgeInsetsMake(0, 0, 0, value));
    }
}

- (void)setEdgeAttribute:(BRKEdgeValue *)attr {
    NSParameterAssert(attr.edge != UIRectEdgeNone);
    
    CGRect viewFrame = [attr.view convertRect:attr.view.bounds toView:self.view.superview];
    CGFloat value = CGRectGetDistanceFromEdgeToEdgeInRect(viewFrame, attr.edge, self.targetFrame, self.edges);
    
    [self setNumberAttribute:value];
}

- (CGRect)applyToFrame:(CGRect)frame {
    NSParameterAssert(self.edges != UIRectEdgeNone);
    
    if (self.edges & UIRectEdgeTop) {
        CGRectFunc func = CGRectFuncForEdgeAction(self.type, UIRectEdgeTop);
        frame = func(frame, CGRectGetMinY(self.targetFrame) + self.insets.top);
    }
    if (self.edges & UIRectEdgeLeft) {
        CGRectFunc func = CGRectFuncForEdgeAction(self.type, UIRectEdgeLeft);
        frame = func(frame, CGRectGetMinX(self.targetFrame) + self.insets.left);
    }
    if (self.edges & UIRectEdgeBottom) {
        CGRectFunc func = CGRectFuncForEdgeAction(self.type, UIRectEdgeBottom);
        frame = func(frame, CGRectGetMaxY(self.targetFrame) - self.insets.bottom);
    }
    if (self.edges & UIRectEdgeRight) {
        CGRectFunc func = CGRectFuncForEdgeAction(self.type, UIRectEdgeRight);
        frame = func(frame, CGRectGetMaxX(self.targetFrame) - self.insets.right);
    }
    return frame;
}

@end