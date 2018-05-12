//
//  UIView+BRKFrameMaker.h
//  Bricks
//
//  Created by Makarov Yury on 24/08/16.
//  Copyright © 2016 Makarov Yury. All rights reserved.
//

@import UIKit;

// Comment out nullability macro for this header to prevent Xcode from adding _Nonnull specifier to brk_make block parameter
//NS_ASSUME_NONNULL_BEGIN

@class BRKFrameMaker;

@interface UIView (BRKFrameMaker)

@property (nonatomic, assign, readonly) CGFloat brk_top;
@property (nonatomic, assign, readonly) CGFloat brk_left;
@property (nonatomic, assign, readonly) CGFloat brk_bottom;
@property (nonatomic, assign, readonly) CGFloat brk_right;
@property (nonatomic, assign, readonly) CGFloat brk_centerX;
@property (nonatomic, assign, readonly) CGFloat brk_centerY;

- (void)brk_make:(void(NS_NOESCAPE ^)(BRKFrameMaker *make))block;

@end

//NS_ASSUME_NONNULL_END
