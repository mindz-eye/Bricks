//
//  BRKLayoutOperation.m
//  Bricks
//
//  Created by Makarov Yury on 27/08/16.
//  Copyright © 2016 Makarov Yury. All rights reserved.
//

#import "BRKLayoutOperation.h"
#import "BRKEdgeLayoutAction.h"
#import "BRKSizeLayoutAction.h"
#import "BRKCenterLayoutAction.h"

@interface BRKLayoutOperation ()

@property (nonatomic, copy) NSDictionary<NSString *, id<BRKLayoutAction>> *actions;

@end

@implementation BRKLayoutOperation

- (instancetype)initWithView:(UIView *)view {
    self = [super init];
    if (self) {
        _view = view;
        _actions = @{};
    }
    return self;
}

- (void)addAction:(id<BRKLayoutAction>)action {
    NSMutableDictionary<Class, id<BRKLayoutAction>> *mutableActions = [self.actions mutableCopy];
    mutableActions[NSStringFromClass([action class])] = action;
    self.actions = mutableActions;
}

- (id<BRKLayoutAction>)actionByClass:(Class)cls {
    return self.actions[NSStringFromClass(cls)];
}

- (BRKEdgeLayoutAction *)edgeAction {
    BRKEdgeLayoutAction *action = [self actionByClass:[BRKEdgeLayoutAction class]];
    if (!action) {
        action = [[BRKEdgeLayoutAction alloc] initWithView:self.view];
        [self addAction:action];
    }
    return action;
}

- (BRKCenterLayoutAction *)centerAction {
    BRKCenterLayoutAction *action = [self actionByClass:[BRKCenterLayoutAction class]];
    if (!action) {
        action = [[BRKCenterLayoutAction alloc] initWithView:self.view];
        [self addAction:action];
    }
    return action;
}

- (BRKSizeLayoutAction *)sizeAction {
    BRKSizeLayoutAction *action = [self actionByClass:[BRKSizeLayoutAction class]];
    if (!action) {
        action = [[BRKSizeLayoutAction alloc] initWithView:self.view];
        [self addAction:action];
    }
    return action;
}

- (BRKLayoutOperation * (^)(UIEdgeInsets))insets {
    return ^BRKLayoutOperation *(UIEdgeInsets insets) {
        for (id<BRKLayoutAction> action in self.actions.allValues) {
            [action setEdgeInsets:insets];
        }
        return self;
    };
}

- (BRKLayoutOperation * (^)(CGSize))sizeOffset {
    return ^BRKLayoutOperation *(CGSize size) {
        for (id<BRKLayoutAction> action in self.actions.allValues) {
            [action setSize:size];
        }
        return self;
    };
}

- (BRKLayoutOperation * (^)(CGFloat))offset {
    return ^BRKLayoutOperation *(CGFloat offset) {
        for (id<BRKLayoutAction> action in self.actions.allValues) {
            [action setOffset:offset];
        }
        return self;
    };
}

- (BRKLayoutOperation * (^)(CGPoint))centerOffset {
    return ^BRKLayoutOperation *(CGPoint centerOffset) {
        for (id<BRKLayoutAction> action in self.actions.allValues) {
            [action setCenterOffset:centerOffset];
        }
        return self;
    };
}

- (BRKLayoutOperation * (^)(NSValue *value))valueOffset {
    return ^BRKLayoutOperation *(NSValue *value) {
        for (id<BRKLayoutAction> action in self.actions.allValues) {
            [action setValueOffset:value];
        }
        return self;
    };
}

- (BRKLayoutOperation * (^)(id))moveTo {
    return ^BRKLayoutOperation *(id attr) {
        BRKEdgeLayoutAction *edgeAction = [self actionByClass:[BRKEdgeLayoutAction class]];
        edgeAction.type = BRKEdgeActionTypeMove;
        
        for (id<BRKLayoutAction> action in self.actions.allValues) {
            [action setAttribute:attr];
        }
        return self;
    };
}

- (BRKLayoutOperation * (^)(id))resizeTo {
    return ^BRKLayoutOperation *(id attr) {
        BRKEdgeLayoutAction *edgeAction = [self actionByClass:[BRKEdgeLayoutAction class]];
        edgeAction.type = BRKEdgeActionTypeSet;

        for (id<BRKLayoutAction> action in self.actions.allValues) {
            [action setAttribute:attr];
        }
        return self;
    };
}

- (BRKLayoutOperation *)left {
    self.edgeAction.edges |= UIRectEdgeLeft;
    return self;
}

- (BRKLayoutOperation *)right {
    self.edgeAction.edges |= UIRectEdgeRight;
    return self;
}

- (BRKLayoutOperation *)top {
    self.edgeAction.edges |= UIRectEdgeTop;
    return self;
}

- (BRKLayoutOperation *)bottom {
    self.edgeAction.edges |= UIRectEdgeBottom;
    return self;
}

- (BRKLayoutOperation *)width {
    self.sizeAction.axis |= BRKAxisHorizontal;
    return self;
}

- (BRKLayoutOperation *)height {
    self.sizeAction.axis |= BRKAxisVertical;
    return self;
}

- (BRKLayoutOperation *)centerX {
    self.centerAction.axis |= BRKAxisHorizontal;
    return self;
}

- (BRKLayoutOperation *)centerY {
    self.centerAction.axis |= BRKAxisVertical;
    return self;
}

- (BRKLayoutOperation *)with {
    return self;
}

- (BRKLayoutOperation *)and {
    return self;
}

@end


@implementation BRKLayoutOperation (AutoboxingSupport)

- (BRKLayoutOperation * (^)(id attr))brk_resizeTo {
    return [self resizeTo];
}

- (BRKLayoutOperation * (^)(id attr))brk_moveTo {
    return [self moveTo];
}

@end
