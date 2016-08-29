//
//  UIView+BRKLayoutMaker.h
//  Bricks
//
//  Created by Makarov Yury on 24/08/16.
//  Copyright © 2016 Makarov Yury. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@class BRKLayoutMaker;
@protocol BRKLayoutValue;


@interface UIView (BRKLayoutMaker)

@property (nonatomic, strong, readonly) id<BRKLayoutValue> brk_left;
@property (nonatomic, strong, readonly) id<BRKLayoutValue> brk_top;
@property (nonatomic, strong, readonly) id<BRKLayoutValue> brk_right;
@property (nonatomic, strong, readonly) id<BRKLayoutValue> brk_bottom;
@property (nonatomic, strong, readonly) id<BRKLayoutValue> brk_centerX;
@property (nonatomic, strong, readonly) id<BRKLayoutValue> brk_centerY;

- (void)brk_make:(void(^)(BRKLayoutMaker *maker))block;

@end

NS_ASSUME_NONNULL_END