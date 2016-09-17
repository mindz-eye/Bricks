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

- (CGRect)applyActions;

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
    }
    return self;
}

- (void)applyPendingOperationIfNeeded {
    if (self.pendingOperation) {
        self.frame = [self.pendingOperation applyActions];
        if ([self.view isKindOfClass:NSClassFromString(@"PXQuantityStepper")]) {
            
        }
        self.pendingOperation = nil;
    }
}

- (BRKLayoutOperation *)beginOperation {
    [self applyPendingOperationIfNeeded];
    self.pendingOperation = [[BRKLayoutOperation alloc] initWithView:self.view frame:self.frame];
    return self.pendingOperation;
}

- (BRKLayoutOperation *)beginOperationWithEdges:(UIRectEdge)edges {
    BRKLayoutOperation *pendingOperation = [self beginOperation];
    BRKEdgeLayoutAction *action = [[BRKEdgeLayoutAction alloc] initWithView:self.view edges:edges initialValue:self.frame];
    [pendingOperation addAction:action];
    return pendingOperation;
}

- (BRKLayoutOperation *)beginOperationWithSizeAxis:(BRKAxis)axis {
    BRKLayoutOperation *pendingOperation = [self beginOperation];
    BRKSizeLayoutAction *action = [[BRKSizeLayoutAction alloc] initWithView:self.view axis:axis initialValue:self.frame.size];
    [pendingOperation addAction:action];
    return pendingOperation;
}

- (BRKLayoutOperation *)beginOperationWithCenterAxis:(BRKAxis)axis {
    BRKLayoutOperation *pendingOperation = [self beginOperation];
    BRKCenterLayoutAction *action = [[BRKCenterLayoutAction alloc] initWithView:self.view axis:axis initialValue:BRKRectGetCenter(self.frame)];
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

- (void)beginWithSize:(CGSize)size {
    self.frame = CGRectMake(0, 0, size.width, size.height);
}

- (void)begin {
    [self.view sizeToFit];
    self.frame = self.view.frame;
}

- (void)commit {
    [self applyPendingOperationIfNeeded];
    self.view.frame = self.frame;
}

@end
