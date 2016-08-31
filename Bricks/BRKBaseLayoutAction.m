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

@synthesize view = _view;
@synthesize insets = _insets;

- (instancetype)initWithView:(UIView *)view {
    self = [super init];
    if (self) {
        _view = view;
    }
    return self;
}

- (void)setAttribute:(id)attr {
    if ([attr isKindOfClass:[NSNumber class]]) {
        [self setNumberAttribute:[attr doubleValue]];
        
    } else if ([attr isKindOfClass:[NSValue class]]) {
        if (strcmp([attr objCType], @encode(CGPoint)) == 0) {
            CGPoint point;
            [attr getValue:&point];
            [self setPointAttribute:point];
            
        } else if (strcmp([attr objCType], @encode(CGSize)) == 0) {
            CGSize size;
            [attr getValue:&size];
            [self setSizeAttribute:size];
            
        } else if (strcmp([attr objCType], @encode(CGRect)) == 0) {
            CGRect rect;
            [attr getValue:&rect];
            [self setRectAttribute:rect];
            
        } else if (strcmp([attr objCType], @encode(UIEdgeInsets)) == 0) {
            UIEdgeInsets insets;
            [attr getValue:&insets];
            [self setInsets:insets];
        }
        
    } else if ([attr isKindOfClass:[BRKEdgeValue class]]) {
        [self setEdgeAttribute:attr];
        
    } else if ([attr isKindOfClass:[BRKAxisValue class]]) {
        [self setAxisAttribute:attr];
        
    } else if ([attr isKindOfClass:[UIView class]]) {
        [self setViewAttribute:attr];
    }
}

- (void)setNumberAttribute:(CGFloat)value {
    NSParameterAssert(NO);
}

- (void)setPointAttribute:(CGPoint)point {
    NSParameterAssert(NO);
}

- (void)setSizeAttribute:(CGSize)size {
    NSParameterAssert(NO);
}

- (void)setRectAttribute:(CGRect)rect {
    NSParameterAssert(NO);
}

- (void)setViewAttribute:(UIView *)value {
    NSParameterAssert(NO);
}

- (void)setEdgeAttribute:(BRKEdgeValue *)value {
    NSParameterAssert(NO);
}

- (void)setAxisAttribute:(BRKAxisValue *)value {
    NSParameterAssert(NO);
}

- (CGRect)applyToFrame:(CGRect)frame {
    NSParameterAssert(NO);
    return frame;
}

@end

