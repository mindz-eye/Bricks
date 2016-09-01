//
//  BRKBaseLayoutAction.m
//  Bricks
//
//  Created by Makarov Yury on 27/08/16.
//  Copyright © 2016 Makarov Yury. All rights reserved.
//

#import "BRKBaseLayoutAction.h"
#import "BRKEdgeValue.h"
#import "BRKAxisValue.h"

@implementation BRKBaseLayoutAction

- (instancetype)initWithView:(UIView *)view {
    self = [super init];
    if (self) {
        _ownerView = view;
    }
    return self;
}

- (void)setAttribute:(id)attr {
    if ([attr isKindOfClass:[NSNumber class]]) {
        [self setView:self.ownerView.superview];
        [self setOffset:[attr doubleValue]];
        
    } else if ([attr isKindOfClass:[NSValue class]]) {
        if (strcmp([attr objCType], @encode(CGPoint)) == 0) {
            [self setView:self.ownerView.superview];
            [self setCenterOffset:[attr CGPointValue]];
            
        } else if (strcmp([attr objCType], @encode(CGSize)) == 0) {
            [self setView:self.ownerView.superview];
            [self setSize:[attr CGSizeValue]];
            
        } else if (strcmp([attr objCType], @encode(UIEdgeInsets)) == 0) {
            [self setView:self.ownerView.superview];
            [self setEdgeInsets:[attr UIEdgeInsetsValue]];
        }
        
    } else if ([attr isKindOfClass:[BRKEdgeValue class]]) {
        [self setEdge:attr];
        
    } else if ([attr isKindOfClass:[BRKAxisValue class]]) {
        [self setAxis:attr];
        
    } else if ([attr isKindOfClass:[UIView class]]) {
        [self setView:attr];
    }
}

- (void)setOffset:(CGFloat)offset {
    NSParameterAssert(NO);
}

- (void)setValueOffset:(NSValue *)value {
    if ([value isKindOfClass:[NSNumber class]]) {
        [self setOffset:[(NSNumber *)value doubleValue]];
        
    } else if (strcmp([value objCType], @encode(CGPoint)) == 0) {
            [self setCenterOffset:value.CGPointValue];
            
    } else if (strcmp([value objCType], @encode(UIEdgeInsets)) == 0) {
        [self setEdgeInsets:value.UIEdgeInsetsValue];
        
    } else {
        NSParameterAssert(NO);
    }
}

- (void)setCenterOffset:(CGPoint)centerOffset {
    NSParameterAssert(NO);
}

- (void)setSize:(CGSize)size {
    NSParameterAssert(NO);
}

- (void)setRect:(CGRect)rect {
    NSParameterAssert(NO);
}

- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets {
    NSParameterAssert(NO);
}

- (void)setView:(UIView *)view {
    NSParameterAssert(NO);
}

- (void)setEdge:(BRKEdgeValue *)edge {
    NSParameterAssert(NO);
}

- (void)setAxis:(BRKAxisValue *)axis {
    NSParameterAssert(NO);
}

- (CGRect)applyToFrame:(CGRect)frame {
    NSParameterAssert(NO);
    return frame;
}

@end

