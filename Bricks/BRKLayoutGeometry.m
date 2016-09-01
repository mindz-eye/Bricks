//
//  BRKGeometryHelpers.m
//  Bricks
//
//  Created by Makarov Yury on 25/08/16.
//  Copyright © 2016 Makarov Yury. All rights reserved.
//

#import "BRKLayoutGeometry.h"

static inline CGRect BRKRectMoveTop(CGRect rect, CGFloat y) {
    rect.origin.y = y;
    return rect;
}

static inline CGRect BRKRectMoveBottom(CGRect rect, CGFloat y) {
    rect.origin.y = rect.origin.y + y - rect.size.height;
    return rect;
}

static inline CGRect BRKRectMoveLeft(CGRect rect, CGFloat x) {
    rect.origin.x = x;
    return rect;
}

static inline CGRect BRKRectMoveRight(CGRect rect, CGFloat x) {
    rect.origin.x = rect.origin.x + x - rect.size.width;
    return rect;
}

static inline CGRect BRKRectSetTop(CGRect rect, CGFloat y) {
    rect.size.height += rect.origin.y - y;
    rect.origin.y = y;
    return rect;
}

static inline CGRect BRKRectSetLeft(CGRect rect, CGFloat x) {
    rect.size.width += rect.origin.x - x;
    rect.origin.x = x;
    return rect;
}

static inline CGRect BRKRectSetBottom(CGRect rect, CGFloat y) {
    rect.size.height += y - (rect.origin.y + rect.size.height);
    return rect;
}

static inline CGRect BRKRectSetRight(CGRect rect, CGFloat x) {
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

CGRect BRKRectSetEdge(CGRect rect, UIRectEdge edge, CGFloat value) {
    switch (edge) {
        case UIRectEdgeTop: return BRKRectSetTop(rect, value);
        case UIRectEdgeLeft: return BRKRectSetLeft(rect, value);
        case UIRectEdgeBottom: return BRKRectSetBottom(rect, value);
        case UIRectEdgeRight: return BRKRectSetRight(rect, value);
        default: NSCParameterAssert(NO);
    }
    return CGRectNull;
}

CGRect BRKRectMoveEdge(CGRect rect, UIRectEdge edge, CGFloat value) {
    switch (edge) {
        case UIRectEdgeTop: return BRKRectMoveTop(rect, value);
        case UIRectEdgeLeft: return BRKRectMoveLeft(rect, value);
        case UIRectEdgeBottom: return BRKRectMoveBottom(rect, value);
        case UIRectEdgeRight: return BRKRectMoveRight(rect, value);
        default: NSCParameterAssert(NO);
    }
    return CGRectNull;
}

CGRect BRKRectApplyEdgeInsets(CGRect rect, UIEdgeInsets insets) {
    return CGRectMake(rect.origin.x + insets.left, rect.origin.y + insets.top,
                      rect.size.width - insets.left - insets.right, rect.size.height - insets.top - insets.bottom);
}
