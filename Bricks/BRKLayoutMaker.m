//
//  BRKLayoutMaker.m
//  Bricks
//
//  Created by Makarov Yury on 24/08/16.
//  Copyright © 2016 Makarov Yury. All rights reserved.
//

#import "BRKLayoutMaker.h"
#import "BRKLayoutOperation.h"
#import "BRKEdgeLayoutAction.h"
#import "BRKSizeLayoutAction.h"
#import "BRKCenterLayoutAction.h"

@interface BRKLayoutOperation (Private)

@property (nonatomic, readonly, copy) NSDictionary<NSString *, id<BRKLayoutAction>> *actions;

- (void)addAction:(id<BRKLayoutAction>)action;

@end


@interface BRKLayoutMaker ()

@property (nonatomic, weak, readonly, nullable) UIView *view;
@property (nonatomic, assign) CGRect frame;

@property (nonatomic, strong, nullable) BRKLayoutOperation *pendingOperation;

@end


@implementation BRKLayoutMaker

- (instancetype)initWithView:(UIView *)view {
    self = [super init];
    if (self) {
        _view = view;
        _frame = view.frame;
    }
    return self;
}

- (void)applyPendingOperationIfNeeded {
    if (self.pendingOperation) {
        for (id<BRKLayoutAction> action in self.pendingOperation.actions.allValues) {
            self.frame = [action applyToFrame:self.frame];
        }
        self.pendingOperation = nil;
    }
}

- (BRKLayoutOperation *)beginOperation {
    NSParameterAssert(self.view.superview);
    
    [self applyPendingOperationIfNeeded];
    self.pendingOperation = [[BRKLayoutOperation alloc] initWithView:self.view];
    return self.pendingOperation;
}

- (BRKLayoutOperation *)beginOperationWithEdges:(UIRectEdge)edges {
    BRKLayoutOperation *pendingOperation = [self beginOperation];
    BRKEdgeLayoutAction *action = [[BRKEdgeLayoutAction alloc] initWithView:self.view edges:edges];
    [pendingOperation addAction:action];
    return pendingOperation;
}

- (BRKLayoutOperation *)beginOperationWithSizeAxis:(BRKAxis)axis {
    BRKLayoutOperation *pendingOperation = [self beginOperation];
    BRKSizeLayoutAction *action = [[BRKSizeLayoutAction alloc] initWithView:self.view axis:axis];
    [pendingOperation addAction:action];
    return pendingOperation;
}

- (BRKLayoutOperation *)beginOperationWithCenterAxis:(BRKAxis)axis {
    BRKLayoutOperation *pendingOperation = [self beginOperation];
    BRKCenterLayoutAction *action = [[BRKCenterLayoutAction alloc] initWithView:self.view axis:axis];
    [pendingOperation addAction:action];
    return pendingOperation;
}

- (BRKLayoutOperation *)left {
    return [self beginOperationWithEdges:UIRectEdgeLeft];
}

- (BRKLayoutOperation *)right {
    return [self beginOperationWithEdges:UIRectEdgeRight];
}

- (BRKLayoutOperation *)top {
    return [self beginOperationWithEdges:UIRectEdgeTop];
}

- (BRKLayoutOperation *)bottom {
    return [self beginOperationWithEdges:UIRectEdgeBottom];
}

- (BRKLayoutOperation *)edges {
    return [self beginOperationWithEdges:UIRectEdgeAll];
}

- (BRKLayoutOperation *)width {
    return [self beginOperationWithSizeAxis:BRKAxisHorizontal];
}

- (BRKLayoutOperation *)height {
    return [self beginOperationWithSizeAxis:BRKAxisVertical];
}

- (BRKLayoutOperation *)size {
    return [self beginOperationWithSizeAxis:BRKAxisAll];
}

- (BRKLayoutOperation *)centerX {
    return [self beginOperationWithCenterAxis:BRKAxisHorizontal];
}

- (BRKLayoutOperation *)centerY {
    return [self beginOperationWithCenterAxis:BRKAxisVertical];
}

- (BRKLayoutOperation *)center {
    return [self beginOperationWithCenterAxis:BRKAxisAll];
}

- (void)commit {
    [self applyPendingOperationIfNeeded];
    self.view.frame = self.frame;
}

@end
