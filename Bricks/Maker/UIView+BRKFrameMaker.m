//
//  UIView+BRKFrameMaker.m
//  Bricks
//
//  Created by Makarov Yury on 24/08/16.
//  Copyright © 2016 Makarov Yury. All rights reserved.
//

#import "BRKFrameMaker.h"
#import "UIView+BRKFrameMaker.h"

NS_ASSUME_NONNULL_BEGIN

@implementation UIView (BRKFrameMaker)

- (CGFloat)brk_top {
    return CGRectGetMinY(self.frame);
}

- (CGFloat)brk_left {
    return CGRectGetMinX(self.frame);
}

- (CGFloat)brk_bottom {
    return CGRectGetMaxY(self.frame);
}

- (CGFloat)brk_right {
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)brk_centerX {
    return CGRectGetMidX(self.frame);
}

- (CGFloat)brk_centerY {
    return CGRectGetMidY(self.frame);
}

- (void)brk_make:(void(NS_NOESCAPE ^)(BRKFrameMaker *make))block {
    self.frame = brk_makeWithFrame(block, self.superview.frame);
}

@end

NS_ASSUME_NONNULL_END
