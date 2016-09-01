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

@interface BRKEdgeLayoutAction ()

@property (nonatomic, assign) CGRect result;

@end


@implementation BRKEdgeLayoutAction

- (instancetype)initWithView:(UIView *)view edges:(UIRectEdge)edges {
    self = [super initWithView:view];
    if (self) {
        _edges = edges;
        _result = view.frame;
    }
    return self;
}

- (instancetype)initWithView:(UIView *)view {
    return [self initWithView:view edges:UIRectEdgeNone];
}

- (CGRect)updateEdge:(UIRectEdge)edge inRect:(CGRect)rect withValue:(CGFloat)value {
    if (self.type == BRKEdgeActionTypeMove) {
        return BRKRectMoveEdge(rect, edge, value);
    } else {
        return BRKRectSetEdge(rect, edge, value);
    }
}

- (void)updateEdgesWithBlock:(void(^)(UIRectEdge edge))block {
    if (self.edges & UIRectEdgeTop) {
        block(UIRectEdgeTop);
    }
    if (self.edges & UIRectEdgeLeft) {
        block(UIRectEdgeLeft);
    }
    if (self.edges & UIRectEdgeBottom) {
        block(UIRectEdgeBottom);
    }
    if (self.edges & UIRectEdgeRight) {
        block(UIRectEdgeRight);
    }
}

- (void)setOffset:(CGFloat)offset {
    NSParameterAssert(self.edges != UIRectEdgeNone);
    
    [self updateEdgesWithBlock:^(UIRectEdge edge) {
        self.result = [self updateEdge:edge inRect:self.result withValue:BRKRectGetEdge(self.result, edge) + offset];
    }];
}

- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets {
    NSParameterAssert(self.edges != UIRectEdgeNone);
    
    CGRect insetRect = BRKRectApplyEdgeInsets(self.result, edgeInsets);
    
    [self updateEdgesWithBlock:^(UIRectEdge edge) {
        self.result = [self updateEdge:edge inRect:self.result withValue:BRKRectGetEdge(insetRect, edge)];
    }];
}

- (void)setView:(UIView *)view {
    NSParameterAssert(self.edges != UIRectEdgeNone);
    
    CGRect viewFrame = [view convertRect:view.bounds toView:self.ownerView.superview];

    [self updateEdgesWithBlock:^(UIRectEdge edge) {
        self.result = [self updateEdge:edge inRect:self.result withValue:BRKRectGetEdge(viewFrame, edge)];
    }];
}

- (void)setEdge:(BRKEdgeValue *)edge {
    NSParameterAssert(self.edges != UIRectEdgeNone);
    NSParameterAssert(edge.edge != UIRectEdgeNone);
    
    CGRect viewFrame = [edge.view convertRect:edge.view.bounds toView:self.ownerView.superview];
    CGFloat value = BRKRectGetEdge(viewFrame, edge.edge);
    
    [self updateEdgesWithBlock:^(UIRectEdge edge) {
        self.result = [self updateEdge:edge inRect:self.result withValue:value];
    }];
}

- (CGRect)applyToFrame:(CGRect)frame {
    __block CGRect updatedFrame = frame;
    
    [self updateEdgesWithBlock:^(UIRectEdge edge) {
        updatedFrame = [self updateEdge:edge inRect:updatedFrame withValue:BRKRectGetEdge(self.result, edge)];
    }];
    return updatedFrame;
}

@end