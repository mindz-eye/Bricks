//
//  BRKGeometryHelpers.m
//  Bricks
//
//  Created by Makarov Yury on 25/08/16.
//  Copyright © 2016 Makarov Yury. All rights reserved.
//

#import "BRKLayoutGeometry.h"

CGRect BRKRectMoveTop(CGRect rect, CGFloat y) {
    rect.origin.y = y;
    return rect;
}

CGRect BRKRectMoveBottom(CGRect rect, CGFloat y) {
    rect.origin.y = rect.origin.y + y - rect.size.height;
    return rect;
}

CGRect BRKRectMoveLeft(CGRect rect, CGFloat x) {
    rect.origin.x = x;
    return rect;
}

CGRect BRKRectMoveRight(CGRect rect, CGFloat x) {
    rect.origin.x = rect.origin.x + x - rect.size.width;
    return rect;
}

CGRect BRKRectSetTop(CGRect rect, CGFloat y) {
    rect.size.height += rect.origin.y - y;
    rect.origin.y = y;
    return rect;
}

CGRect BRKRectSetLeft(CGRect rect, CGFloat x) {
    rect.size.width += rect.origin.x - x;
    rect.origin.x = x;
    return rect;
}

CGRect BRKRectSetBottom(CGRect rect, CGFloat y) {
    rect.size.height += y - (rect.origin.y + rect.size.height);
    return rect;
}

CGRect BRKRectSetRight(CGRect rect, CGFloat x) {
    rect.size.width += x - (rect.origin.x + rect.size.width);
    return rect;
}

CGRect BRKRectSetWidth(CGRect rect, CGFloat width) {
    rect.size.width = width;
    return rect;
}

CGRect BRKRectSetHeight(CGRect rect, CGFloat height) {
    rect.size.height = height;
    return rect;
}

CGRect BRKRectSetCenterX(CGRect rect, CGFloat x) {
    rect.origin = CGPointMake(x - rect.size.width / 2.0f, rect.origin.y);
    return rect;
}

CGRect BRKRectSetCenterY(CGRect rect, CGFloat y) {
    rect.origin = CGPointMake(rect.origin.x, y - rect.size.height / 2.0f);
    return rect;
}

CGRect BRKRectSetCenter(CGRect rect, CGPoint center) {
    rect.origin = CGPointMake(center.x - rect.size.width / 2.0f, center.y - rect.size.height / 2.0f);
    return rect;
}

CGPoint BRKRectGetCenter(CGRect rect) {
    return CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
}

CGFloat BRKRectGetEdge(CGRect rect, UIRectEdge edge) {
    switch (edge) {
        case UIRectEdgeTop: return CGRectGetMinY(rect);
        case UIRectEdgeLeft: return CGRectGetMinX(rect);
        case UIRectEdgeBottom: return CGRectGetMaxY(rect);
        case UIRectEdgeRight: return CGRectGetMaxX(rect);
        default: NSCParameterAssert(NO);
    }
    return CGFLOAT_MAX;
}

CGFloat BRKRectGetDistanceFromEdgeToEdgeInRect(CGRect rect, UIRectEdge edge, CGRect otherRect, UIRectEdge otherEdge) {
    return BRKRectGetEdge(rect, edge) - BRKRectGetEdge(otherRect, otherEdge);
}

UIEdgeInsets BRKEdgeInsetsByAddingEdgeInsets(UIEdgeInsets insets, UIEdgeInsets insetsToAdd) {
    return UIEdgeInsetsMake(insets.top + insetsToAdd.top, insets.left + insetsToAdd.left,
                            insets.bottom + insetsToAdd.bottom, insets.right + insetsToAdd.right);
}

const CGSize BRKSizeNull = { CGFLOAT_MAX, CGFLOAT_MAX };

const CGPoint BRKPointNull = { CGFLOAT_MAX, CGFLOAT_MAX };

BOOL BRKSizeIsNull(CGSize size) {
    return CGSizeEqualToSize(size, BRKSizeNull);
}

BOOL BRKPointIsNull(CGPoint point) {
    return CGPointEqualToPoint(point, BRKPointNull);
}
