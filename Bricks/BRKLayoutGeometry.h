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

extern CGRect CGRectMoveTop(CGRect rect, CGFloat y);
extern CGRect CGRectMoveBottom(CGRect rect, CGFloat y);
extern CGRect CGRectMoveLeft(CGRect rect, CGFloat x);
extern CGRect CGRectMoveRight(CGRect rect, CGFloat x);

extern CGRect CGRectSetTop(CGRect rect, CGFloat y);
extern CGRect CGRectSetBottom(CGRect rect, CGFloat y);
extern CGRect CGRectSetLeft(CGRect rect, CGFloat x);
extern CGRect CGRectSetRight(CGRect rect, CGFloat x);

extern CGRect CGRectSetWidth(CGRect rect, CGFloat width);
extern CGRect CGRectSetHeight(CGRect rect, CGFloat height);

extern CGRect CGRectSetCenterX(CGRect rect, CGFloat x);
extern CGRect CGRectSetCenterY(CGRect rect, CGFloat y);
extern CGRect CGRectSetCenter(CGRect rect, CGPoint center);

extern CGPoint CGRectGetCenter(CGRect rect);

extern CGFloat CGRectGetEdge(CGRect rect, UIRectEdge edge);

extern CGFloat CGRectGetDistanceFromEdgeToEdgeInRect(CGRect rect, UIRectEdge edge, CGRect otherRect, UIRectEdge otherEdge);

extern UIEdgeInsets UIEdgeInsetsByAddingEdgeInsets(UIEdgeInsets insets, UIEdgeInsets insetsToAdd);

extern BOOL CGSizeIsNull(CGSize size);
extern BOOL CGPointIsNull(CGPoint point);

extern const CGSize CGSizeNull;
extern const CGPoint CGPointNull;

NS_ASSUME_NONNULL_END