//
//  BRKSizeLayoutAction.m
//  Bricks
//
//  Created by Makarov Yury on 27/08/16.
//  Copyright © 2016 Makarov Yury. All rights reserved.
//

#import "BRKSizeLayoutAction.h"
#import "BRKLayoutGeometry.h"

@interface BRKSizeLayoutAction ()

@property (nonatomic, assign) CGSize result;

@end

@implementation BRKSizeLayoutAction

- (instancetype)initWithView:(UIView *)view axis:(BRKAxis)axis initialValue:(CGSize)initialValue {
    self = [super initWithView:view];
    if (self) {
        _axis = axis;
        _result = view.bounds.size;
    }
    return self;
}

- (void)setOffset:(CGFloat)value {
    if (self.axis & BRKAxisHorizontal) {
        self.result = CGSizeMake(value, self.result.height);
    }
    if (self.axis & BRKAxisVertical) {
        self.result = CGSizeMake(self.result.width, value);
    }
}

- (void)setSize:(CGSize)size {
    self.result = size;
}

- (void)setView:(UIView *)view {
    self.result = view.bounds.size;
}

- (CGRect)applyToFrame:(CGRect)frame {
    NSParameterAssert(self.axis != BRKAxisNone);
    
    if (self.axis & BRKAxisHorizontal) {
        frame = BRKRectSetWidth(frame, self.result.width);
    }
    if (self.axis & BRKAxisVertical) {
        frame = BRKRectSetHeight(frame, self.result.height);
    }
    return frame;
}

@end
