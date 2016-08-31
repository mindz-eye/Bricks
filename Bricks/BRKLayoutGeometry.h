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

extern CGRect BRKRectMoveTop(CGRect rect, CGFloat y);
extern CGRect BRKRectMoveBottom(CGRect rect, CGFloat y);
extern CGRect BRKRectMoveLeft(CGRect rect, CGFloat x);
extern CGRect BRKRectMoveRight(CGRect rect, CGFloat x);

extern CGRect BRKRectSetTop(CGRect rect, CGFloat y);
extern CGRect BRKRectSetBottom(CGRect rect, CGFloat y);
extern CGRect BRKRectSetLeft(CGRect rect, CGFloat x);
extern CGRect BRKRectSetRight(CGRect rect, CGFloat x);

extern CGRect BRKRectSetWidth(CGRect rect, CGFloat width);
extern CGRect BRKRectSetHeight(CGRect rect, CGFloat height);

extern CGRect BRKRectSetCenterX(CGRect rect, CGFloat x);
extern CGRect BRKRectSetCenterY(CGRect rect, CGFloat y);
extern CGRect BRKRectSetCenter(CGRect rect, CGPoint center);

extern CGPoint BRKRectGetCenter(CGRect rect);

extern CGFloat BRKRectGetEdge(CGRect rect, UIRectEdge edge);

extern CGFloat BRKRectGetDistanceFromEdgeToEdgeInRect(CGRect rect, UIRectEdge edge, CGRect otherRect, UIRectEdge otherEdge);

extern UIEdgeInsets BRKEdgeInsetsByAddingEdgeInsets(UIEdgeInsets insets, UIEdgeInsets insetsToAdd);

extern BOOL BRKSizeIsNull(CGSize size);
extern BOOL BRKPointIsNull(CGPoint point);

extern const CGSize BRKSizeNull;
extern const CGPoint BRKPointNull;

NS_ASSUME_NONNULL_END