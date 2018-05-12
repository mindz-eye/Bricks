//
//  BRKFrameMaker.m
//  Bricks
//
//  Created by Makarov Yury on 24/08/16.
//  Copyright © 2016 Makarov Yury. All rights reserved.
//

#import "BRKFrameMaker.h"
#import "BRKGeometry.h"
#import "BRKHelperMacros.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSInteger, BRKAttributes) {
    BRKAttributeNone    = 0,
    BRKAttributeTop     = 1 << 0,
    BRKAttributeLeft    = 1 << 1,
    BRKAttributeBottom  = 1 << 2,
    BRKAttributeRight   = 1 << 3,
    BRKAttributeWidth   = 1 << 4,
    BRKAttributeHeight  = 1 << 5,
    BRKAttributeCenterX = 1 << 6,
    BRKAttributeCenterY = 1 << 7,
};

typedef NS_ENUM(NSInteger, BRKOperation) {
    BRKOperationNone,
    BRKOperationMove,
    BRKOperationResize
};

typedef NS_OPTIONS(NSInteger, BRKUpdateOptions) {
    BRKUpdateOptionNone,
    BRKUpdateOptionRelativeToCurrentValue
};

static CGRect BRKRectUpdateEdge(CGRect rect,
                                UIRectEdge edge,
                                CGFloat value,
                                BRKOperation operation,
                                BRKUpdateOptions updateOptions) {
    
    NSCParameterAssert(operation != BRKOperationNone);
    
    if (updateOptions & BRKUpdateOptionRelativeToCurrentValue) {
        value += BRKRectGetEdge(rect, edge);
    }
    
    if (operation == BRKOperationMove) {
        return BRKRectMoveEdge(rect, edge, value);
    } else {
        return BRKRectSetEdge(rect, edge, value);
    }
}

static CGRect BRKRectUpdateCenter(CGRect rect,
                                  BRKAxis axis,
                                  CGFloat value,
                                  BRKUpdateOptions updateOptions) {
    
    if (updateOptions | BRKUpdateOptionRelativeToCurrentValue) {
        let center = BRKRectGetCenter(rect);
        value += (axis & BRKAxisHorizontal) ? center.x : 0;
        value += (axis & BRKAxisVertical) ? center.y : 0;
    }
    var result = rect;
    
    if (axis & BRKAxisHorizontal) {
        result = BRKRectSetCenterX(rect, value);
    }
    if (axis & BRKAxisVertical) {
        result = BRKRectSetCenterY(rect, value);
    }
    return result;
}

typedef void(^BRKFrameUpdateBlock)(CGRect frame, BRKOperation operation, BRKUpdateOptions updateOptions);

static void BRKThrowUnsupportedOperationException() {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"Unsupported operation"]
                                 userInfo:nil];
}

@interface BRKFrameMaker ()

@property (nonatomic, assign) CGRect frame;

@property (nonatomic, assign) BRKAttributes attributes;
@property (nonatomic, assign) BRKOperation operation;
@property (nonatomic, assign) BRKUpdateOptions updateOptions;

@property (nonatomic, assign) BRKAttributes appliedAttributes;
@property (nonatomic, assign) BRKOperation appliedOperation;

@end

@implementation BRKFrameMaker

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super init];
    if (self) {
        _frame = frame;
    }
    return self;
}

#pragma mark - Public

- (BRKFrameMaker *)top {
    [self reset];
    self.attributes |= BRKAttributeTop;
    return self;
}

- (BRKFrameMaker *)left {
    [self reset];
    self.attributes |= BRKAttributeLeft;
    return self;
}

- (BRKFrameMaker *)bottom {
    [self reset];
    self.attributes |= BRKAttributeBottom;
    return self;
}

- (BRKFrameMaker *)right {
    [self reset];
    self.attributes |= BRKAttributeRight;
    return self;
}

- (BRKFrameMaker *)edges {
    [self reset];
    self.attributes |= (BRKAttributeTop | BRKAttributeLeft | BRKAttributeBottom | BRKAttributeRight);
    return self;
}

- (BRKFrameMaker *)width {
    [self reset];
    self.attributes |= BRKAttributeWidth;
    return self;
}

- (BRKFrameMaker *)height {
    [self reset];
    self.attributes |= BRKAttributeHeight;
    return self;
}

- (BRKFrameMaker *)centerX {
    [self reset];
    self.attributes |= BRKAttributeCenterX;
    return self;
}

- (BRKFrameMaker *)centerY {
    [self reset];
    self.attributes |= BRKAttributeCenterY;
    return self;
}

- (BRKFrameMaker *)size {
    [self reset];
    self.attributes |= (BRKAttributeWidth | BRKAttributeHeight);
    return self;
}

- (BRKFrameMaker *)center {
    [self reset];
    self.attributes |= (BRKAttributeCenterX | BRKAttributeCenterY);
    return self;
}

- (BRKFrameMaker *)with {
    return self;
}

- (BRKFrameMaker *)and {
    return self;
}

- (BRKFrameMaker *(^)(id object))moveTo {
    return ^(id object) {
        self.operation = BRKOperationMove;
        [self applyObjectAttribute:object];
        [self saveAppliedAttributes];
        return self;
    };
}

- (BRKFrameMaker *(^)(id object))resizeTo {
    return ^(id object) {
        self.operation = BRKOperationResize;
        [self applyObjectAttribute:object];
        [self saveAppliedAttributes];
        return self;
    };
}

- (BRKFrameMaker *(^)(UIEdgeInsets))insets {
    return ^(UIEdgeInsets insets) {
        [self applyEdgeInsetsAttribute:insets];
        return self;
    };
}

- (BRKFrameMaker *(^)(CGFloat))offset {
    return ^(CGFloat offset) {
        self.updateOptions |= BRKUpdateOptionRelativeToCurrentValue;
        [self applyFloatAttribute:offset];
        return self;
    };
}

- (BRKFrameMaker *(^)(CGPoint))centerOffset {
    return ^(CGPoint offset) {
        self.updateOptions |= BRKUpdateOptionRelativeToCurrentValue;
        [self applyPointAttribute:offset];
        return self;
    };
}

- (BRKFrameMaker *(^)(NSValue *))valueOffset {
    return ^(NSValue *value) {
        self.updateOptions |= BRKUpdateOptionRelativeToCurrentValue;
        [self applyObjectAttribute:value];
        return self;
    };
}

#pragma mark - Frame Updates

- (void)applyObjectAttribute:(id)object {
    if ([object isKindOfClass:[NSNumber class]]) {
        [self applyFloatAttribute:[object doubleValue]];
        
    } else if ([object isKindOfClass:[NSValue class]]) {
        if (strcmp([object objCType], @encode(CGPoint)) == 0) {
            [self applyPointAttribute:[object CGPointValue]];
            
        } else if (strcmp([object objCType], @encode(CGSize)) == 0) {
            [self applySizeAttribute:[object CGSizeValue]];
            
        } else if (strcmp([object objCType], @encode(UIEdgeInsets)) == 0) {
            [self applyEdgeInsetsAttribute:[object UIEdgeInsetsValue]];
        }
    } else if ([object isKindOfClass:[UIView class]]) {
        [self applyFrameAttribute:[object frame]];
    }
}

- (void)applyFloatAttribute:(CGFloat)value {
    [self peformOperationForTop:^(CGRect frame, BRKOperation operation, BRKUpdateOptions updateOptions) {
        self.frame = BRKRectUpdateEdge(frame, UIRectEdgeTop, value, operation, updateOptions);
        
    } left:^(CGRect frame, BRKOperation operation, BRKUpdateOptions updateOptions) {
        self.frame = BRKRectUpdateEdge(frame, UIRectEdgeLeft, value, operation, updateOptions);
        
    } bottom:^(CGRect frame, BRKOperation operation, BRKUpdateOptions updateOptions) {
        self.frame = BRKRectUpdateEdge(frame, UIRectEdgeBottom, value, operation, updateOptions);
        
    } right:^(CGRect frame, BRKOperation operation, BRKUpdateOptions updateOptions) {
        self.frame = BRKRectUpdateEdge(frame, UIRectEdgeRight, value, operation, updateOptions);

    } width:^(CGRect frame, BRKOperation operation, BRKUpdateOptions updateOptions) {
        self.frame = BRKRectSetWidth(frame, value);
        
    } height:^(CGRect frame, BRKOperation operation, BRKUpdateOptions updateOptions) {
        self.frame = BRKRectSetHeight(frame, value);
        
    } centerX:^(CGRect frame, BRKOperation operation, BRKUpdateOptions updateOptions) {
        self.frame = BRKRectSetCenterX(frame, value);
        
    } centerY:^(CGRect frame, BRKOperation operation, BRKUpdateOptions updateOptions) {
        self.frame = BRKRectSetCenterY(frame, value);
    }];
}

- (void)applyPointAttribute:(CGPoint)value {
    [self peformOperationForTop:^(CGRect frame, BRKOperation operation, BRKUpdateOptions updateOptions) {
        BRKThrowUnsupportedOperationException();
        
    } left:^(CGRect frame, BRKOperation operation, BRKUpdateOptions updateOptions) {
        BRKThrowUnsupportedOperationException();
        
    } bottom:^(CGRect frame, BRKOperation operation, BRKUpdateOptions updateOptions) {
        BRKThrowUnsupportedOperationException();
        
    } right:^(CGRect frame, BRKOperation operation, BRKUpdateOptions updateOptions) {
        BRKThrowUnsupportedOperationException();

    } width:^(CGRect frame, BRKOperation operation, BRKUpdateOptions updateOptions) {
        BRKThrowUnsupportedOperationException();
        
    } height:^(CGRect frame, BRKOperation operation, BRKUpdateOptions updateOptions) {
        BRKThrowUnsupportedOperationException();
        
    } centerX:^(CGRect frame, BRKOperation operation, BRKUpdateOptions updateOptions) {
        NSParameterAssert(operation == BRKOperationMove);
        
        self.frame = BRKRectUpdateCenter(frame, BRKAxisHorizontal, CGRectGetMidX(frame), updateOptions);
        
    } centerY:^(CGRect frame, BRKOperation operation, BRKUpdateOptions updateOptions) {
        NSParameterAssert(operation == BRKOperationMove);
        
        self.frame = BRKRectUpdateCenter(frame, BRKAxisVertical, CGRectGetMidY(frame), updateOptions);
    }];
}

- (void)applySizeAttribute:(CGSize)value {
    [self peformOperationForTop:^(CGRect frame, BRKOperation operation, BRKUpdateOptions updateOptions) {
        BRKThrowUnsupportedOperationException();
        
    } left:^(CGRect frame, BRKOperation operation, BRKUpdateOptions updateOptions) {
        BRKThrowUnsupportedOperationException();
        
    } bottom:^(CGRect frame, BRKOperation operation, BRKUpdateOptions updateOptions) {
        BRKThrowUnsupportedOperationException();
        
    } right:^(CGRect frame, BRKOperation operation, BRKUpdateOptions updateOptions) {
        BRKThrowUnsupportedOperationException();

    } width:^(CGRect frame, BRKOperation operation, BRKUpdateOptions updateOptions) {
        NSParameterAssert(operation == BRKOperationResize);
        self.frame = BRKRectSetWidth(frame, value.width);
        
    } height:^(CGRect frame, BRKOperation operation, BRKUpdateOptions updateOptions) {
        NSParameterAssert(operation == BRKOperationResize);
        self.frame = BRKRectSetHeight(frame, value.height);
        
    } centerX:^(CGRect frame, BRKOperation operation, BRKUpdateOptions updateOptions) {
        BRKThrowUnsupportedOperationException();
        
    } centerY:^(CGRect frame, BRKOperation operation, BRKUpdateOptions updateOptions) {
        BRKThrowUnsupportedOperationException();
    }];
}

- (void)applyEdgeInsetsAttribute:(UIEdgeInsets)value {
    [self peformOperationForTop:^(CGRect frame, BRKOperation operation, BRKUpdateOptions updateOptions) {
        self.frame = BRKRectUpdateEdge(frame, UIRectEdgeTop, BRKRectGetEdge(frame, UIRectEdgeTop) + value.top, operation, updateOptions);
        
    } left:^(CGRect frame, BRKOperation operation, BRKUpdateOptions updateOptions) {
        self.frame = BRKRectUpdateEdge(frame, UIRectEdgeLeft, BRKRectGetEdge(frame, UIRectEdgeLeft) + value.left, operation, updateOptions);
        
    } bottom:^(CGRect frame, BRKOperation operation, BRKUpdateOptions updateOptions) {
        self.frame = BRKRectUpdateEdge(frame, UIRectEdgeBottom, BRKRectGetEdge(frame, UIRectEdgeBottom) - value.bottom, operation, updateOptions);
        
    } right:^(CGRect frame, BRKOperation operation, BRKUpdateOptions updateOptions) {
        self.frame = BRKRectUpdateEdge(frame, UIRectEdgeRight, BRKRectGetEdge(frame, UIRectEdgeRight) - value.right, operation, updateOptions);

    } width:^(CGRect frame, BRKOperation operation, BRKUpdateOptions updateOptions) {
        BRKThrowUnsupportedOperationException();
        
    } height:^(CGRect frame, BRKOperation operation, BRKUpdateOptions updateOptions) {
        BRKThrowUnsupportedOperationException();
        
    } centerX:^(CGRect frame, BRKOperation operation, BRKUpdateOptions updateOptions) {
        BRKThrowUnsupportedOperationException();
        
    } centerY:^(CGRect frame, BRKOperation operation, BRKUpdateOptions updateOptions) {
        BRKThrowUnsupportedOperationException();
    }];
}

- (void)applyFrameAttribute:(CGRect)value {
    [self peformOperationForTop:^(CGRect frame, BRKOperation operation, BRKUpdateOptions updateOptions) {
        self.frame = BRKRectUpdateEdge(frame, UIRectEdgeTop, CGRectGetMinY(value), operation, updateOptions);
        
    } left:^(CGRect frame, BRKOperation operation, BRKUpdateOptions updateOptions) {
        self.frame = BRKRectUpdateEdge(frame, UIRectEdgeLeft, CGRectGetMinX(value), operation, updateOptions);
        
    } bottom:^(CGRect frame, BRKOperation operation, BRKUpdateOptions updateOptions) {
        self.frame = BRKRectUpdateEdge(frame, UIRectEdgeBottom, CGRectGetMaxY(value), operation, updateOptions);

    } right:^(CGRect frame, BRKOperation operation, BRKUpdateOptions updateOptions) {
        self.frame = BRKRectUpdateEdge(frame, UIRectEdgeRight, CGRectGetMaxX(value), operation, updateOptions);

    } width:^(CGRect frame, BRKOperation operation, BRKUpdateOptions updateOptions) {
        NSParameterAssert(operation == BRKOperationResize);
        self.frame = BRKRectSetWidth(frame, value.size.width);
        
    } height:^(CGRect frame, BRKOperation operation, BRKUpdateOptions updateOptions) {
        NSParameterAssert(operation == BRKOperationResize);
        self.frame = BRKRectSetHeight(frame, value.size.height);
        
    } centerX:^(CGRect frame, BRKOperation operation, BRKUpdateOptions updateOptions) {
        NSParameterAssert(operation == BRKOperationMove);
        self.frame = BRKRectSetCenterX(frame, CGRectGetMidX(frame));
        
    } centerY:^(CGRect frame, BRKOperation operation, BRKUpdateOptions updateOptions) {
        NSParameterAssert(operation == BRKOperationMove);
        self.frame = BRKRectSetCenterY(frame, CGRectGetMidY(frame));
    }];
}

#pragma mark - Helpers

- (void)peformOperationForTop:(NS_NOESCAPE BRKFrameUpdateBlock)top
                         left:(NS_NOESCAPE BRKFrameUpdateBlock)left
                       bottom:(NS_NOESCAPE BRKFrameUpdateBlock)bottom
                        right:(NS_NOESCAPE BRKFrameUpdateBlock)right
                        width:(NS_NOESCAPE BRKFrameUpdateBlock)width
                       height:(NS_NOESCAPE BRKFrameUpdateBlock)height
                      centerX:(NS_NOESCAPE BRKFrameUpdateBlock)centerX
                      centerY:(NS_NOESCAPE BRKFrameUpdateBlock)centerY {
    
    let attributes = self.attributes != BRKAttributeNone ? self.attributes : self.appliedAttributes;
    let operation = self.operation != BRKOperationNone ? self.operation : self.appliedOperation;
    
    NSAssert(attributes != BRKAttributeNone, nil);
    NSAssert(operation != BRKOperationNone, nil);
    
    if (attributes & BRKAttributeTop) {
        top(self.frame, operation, self.updateOptions);
    }
    if (attributes & BRKAttributeLeft) {
        left(self.frame, operation, self.updateOptions);
    }
    if (attributes & BRKAttributeBottom) {
        bottom(self.frame, operation, self.updateOptions);
    }
    if (attributes & BRKAttributeRight) {
        right(self.frame, operation, self.updateOptions);
    }
    if (attributes & BRKAttributeWidth) {
        width(self.frame, operation, self.updateOptions);
    }
    if (attributes & BRKAttributeHeight) {
        height(self.frame, operation, self.updateOptions);
    }
    if (attributes & BRKAttributeCenterX) {
        centerX(self.frame, operation, self.updateOptions);
    }
    if (attributes & BRKAttributeCenterY) {
        centerY(self.frame, operation, self.updateOptions);
    }
}

- (void)saveAppliedAttributes {
    self.appliedAttributes = self.attributes;
    self.appliedOperation = self.operation;
    
    self.operation = BRKOperationNone;
    self.attributes = BRKAttributeNone;
}

- (void)reset {
    self.appliedAttributes = BRKAttributeNone;
    self.appliedOperation = BRKOperationNone;
    self.updateOptions = BRKUpdateOptionNone;
}

@end

CGRect brk_make(void(NS_NOESCAPE ^block)(BRKFrameMaker *make)) {
    return brk_makeWithFrame(block, CGRectZero);
}

CGRect brk_makeWithFrame(void(NS_NOESCAPE ^block)(BRKFrameMaker *make), CGRect frame) {
    let maker = [[BRKFrameMaker alloc] initWithFrame:frame];
    block(maker);
    return maker.frame;
}

NS_ASSUME_NONNULL_END
