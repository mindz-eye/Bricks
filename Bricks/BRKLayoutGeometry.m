//
//  BRKGeometryHelpers.m
//  Bricks
//
//  Created by Makarov Yury on 25/08/16.
//  Copyright © 2016 Makarov Yury. All rights reserved.
//

#import "BRKLayoutGeometry.h"

CGRect CGRectMoveTop(CGRect rect, CGFloat y) {
    rect.origin.y = y;
    return rect;
}

CGRect CGRectMoveBottom(CGRect rect, CGFloat y) {
    rect.origin.y = rect.origin.y + y - rect.size.height;
    return rect;
}

CGRect CGRectMoveLeft(CGRect rect, CGFloat x) {
    rect.origin.x = x;
    return rect;
}

CGRect CGRectMoveRight(CGRect rect, CGFloat x) {
    rect.origin.x = rect.origin.x + x - rect.size.width;
    return rect;
}

CGRect CGRectSetTop(CGRect rect, CGFloat y) {
    rect.size.height += rect.origin.y - y;
    rect.origin.y = y;
    return rect;
}

CGRect CGRectSetLeft(CGRect rect, CGFloat x) {
    rect.size.width += rect.origin.x - x;
    rect.origin.x = x;
    return rect;
}

CGRect CGRectSetBottom(CGRect rect, CGFloat y) {
    rect.size.height += y - (rect.origin.y + rect.size.height);
    return rect;
}

CGRect CGRectSetRight(CGRect rect, CGFloat x) {
    rect.size.width += x - (rect.origin.x + rect.size.width);
    return rect;
}

CGRect CGRectSetWidth(CGRect rect, CGFloat width) {
    rect.size.width = width;
    return rect;
}

CGRect CGRectSetHeight(CGRect rect, CGFloat height) {
    rect.size.height = height;
    return rect;
}

CGRect CGRectSetCenterX(CGRect rect, CGFloat x) {
    rect.origin = CGPointMake(x - rect.size.width / 2.0f, rect.origin.y);
    return rect;
}

CGRect CGRectSetCenterY(CGRect rect, CGFloat y) {
    rect.origin = CGPointMake(rect.origin.x, y - rect.size.height / 2.0f);
    return rect;
}

CGRect CGRectSetCenter(CGRect rect, CGPoint center) {
    rect.origin = CGPointMake(center.x - rect.size.width / 2.0f, center.y - rect.size.height / 2.0f);
    return rect;
}

CGPoint CGRectGetCenter(CGRect rect) {
    return CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
}

CGFloat CGRectGetEdge(CGRect rect, UIRectEdge edge) {
    switch (edge) {
        case UIRectEdgeTop: return CGRectGetMinY(rect);
        case UIRectEdgeLeft: return CGRectGetMinX(rect);
        case UIRectEdgeBottom: return CGRectGetMaxY(rect);
        case UIRectEdgeRight: return CGRectGetMaxX(rect);
        default: NSCParameterAssert(NO);
    }
    return CGFLOAT_MAX;
}

CGFloat CGRectGetDistanceFromEdgeToEdgeInRect(CGRect rect, UIRectEdge edge, CGRect otherRect, UIRectEdge otherEdge) {
    return CGRectGetEdge(rect, edge) - CGRectGetEdge(otherRect, otherEdge);
}

UIEdgeInsets UIEdgeInsetsByAddingEdgeInsets(UIEdgeInsets insets, UIEdgeInsets insetsToAdd) {
    return UIEdgeInsetsMake(insets.top + insetsToAdd.top, insets.left + insetsToAdd.left,
                            insets.bottom + insetsToAdd.bottom, insets.right + insetsToAdd.right);
}

const CGSize CGSizeNull = { CGFLOAT_MAX, CGFLOAT_MAX };

const CGPoint CGPointNull = { CGFLOAT_MAX, CGFLOAT_MAX };

BOOL CGSizeIsNull(CGSize size) {
    return CGSizeEqualToSize(size, CGSizeNull);
}

BOOL CGPointIsNull(CGPoint point) {
    return CGPointEqualToPoint(point, CGPointNull);
}
