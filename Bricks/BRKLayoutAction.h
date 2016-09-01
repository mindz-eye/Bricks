//
//  BRKLayoutAction.h
//  Bricks
//
//  Created by Makarov Yury on 27/08/16.
//  Copyright © 2016 Makarov Yury. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@class BRKEdgeValue;
@class BRKAxisValue;


@protocol BRKLayoutAction <NSObject>

- (void)setOffset:(CGFloat)offset;
- (void)setValueOffset:(NSValue *)value;
- (void)setCenterOffset:(CGPoint)centerOffset;
- (void)setSize:(CGSize)size;
- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets;
- (void)setView:(UIView *)view;
- (void)setEdge:(BRKEdgeValue *)edge;
- (void)setAxis:(BRKAxisValue *)axis;
- (void)setAttribute:(id)attribute;

- (CGRect)applyToFrame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END