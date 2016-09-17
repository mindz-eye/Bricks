//
//  BRKLayoutOperation.h
//  Bricks
//
//  Created by Makarov Yury on 27/08/16.
//  Copyright © 2016 Makarov Yury. All rights reserved.
//

#import "BRKUtilities.h"
@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@protocol BRKLayoutAction;

@interface BRKLayoutOperation : NSObject

@property (nonatomic, strong, readonly) UIView *view;

- (instancetype)initWithView:(UIView *)view frame:(CGRect)frame NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

- (BRKLayoutOperation *)left;
- (BRKLayoutOperation *)top;
- (BRKLayoutOperation *)right;
- (BRKLayoutOperation *)bottom;
- (BRKLayoutOperation *)width;
- (BRKLayoutOperation *)height;
- (BRKLayoutOperation *)centerX;
- (BRKLayoutOperation *)centerY;

- (BRKLayoutOperation * (^)(id attr))moveTo;
- (BRKLayoutOperation * (^)(id attr))resizeTo;

- (BRKLayoutOperation *)with;
- (BRKLayoutOperation *)and;

- (BRKLayoutOperation * (^)(UIEdgeInsets insets))insets;
- (BRKLayoutOperation * (^)(CGSize offset))sizeOffset;
- (BRKLayoutOperation * (^)(CGPoint offset))centerOffset;
- (BRKLayoutOperation * (^)(CGFloat offset))offset;
- (BRKLayoutOperation * (^)(NSValue *value))valueOffset;

@end

/**
 *  Convenience auto-boxing macros for BRKLayoutOperation methods.
 *
 *  Defining BRK_SHORTHAND_GLOBALS will turn on auto-boxing for default syntax.
 *  A potential drawback of this is that the unprefixed macros will appear in global scope.
 */
#define brk_resizeTo(...)                 resizeTo(BRKBoxValue((__VA_ARGS__)))
#define brk_moveTo(...)                   moveTo(BRKBoxValue((__VA_ARGS__)))

#ifdef BRK_SHORTHAND_GLOBALS

#define resizeTo(...)                     brk_resizeTo(__VA_ARGS__)
#define moveTo(...)                       brk_moveTo(__VA_ARGS__)

#endif


@interface BRKLayoutOperation (AutoboxingSupport)

/**
 *  Aliases to corresponding relation methods (for shorthand macros)
 *  Also needed to aid autocompletion
 */
- (BRKLayoutOperation * (^)(id attr))brk_resizeTo;
- (BRKLayoutOperation * (^)(id attr))brk_moveTo;

@end


NS_ASSUME_NONNULL_END