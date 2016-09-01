//
//  BRKLayoutGeometry.h
//  Bricks
//
//  Created by Makarov Yury on 25/08/16.
//  Copyright © 2016 Makarov Yury. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSInteger, BRKAxis) {
    BRKAxisNone          = 0,
    BRKAxisHorizontal    = 1 << 0,
    BRKAxisVertical      = 1 << 1,
    BRKAxisAll           = BRKAxisHorizontal | BRKAxisVertical
};

extern CGRect BRKRectSetWidth(CGRect rect, CGFloat width);
extern CGRect BRKRectSetHeight(CGRect rect, CGFloat height);

extern CGRect BRKRectSetCenterX(CGRect rect, CGFloat x);
extern CGRect BRKRectSetCenterY(CGRect rect, CGFloat y);
extern CGRect BRKRectSetCenter(CGRect rect, CGPoint center);

extern CGPoint BRKRectGetCenter(CGRect rect);

extern CGRect BRKRectSetEdge(CGRect rect, UIRectEdge edge, CGFloat value);
extern CGRect BRKRectMoveEdge(CGRect rect, UIRectEdge edge, CGFloat value);

extern CGFloat BRKRectGetEdge(CGRect rect, UIRectEdge edge);

extern CGRect BRKRectApplyEdgeInsets(CGRect rect, UIEdgeInsets insets);

NS_ASSUME_NONNULL_END