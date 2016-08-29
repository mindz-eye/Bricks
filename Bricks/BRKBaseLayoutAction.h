//
//  BRKBaseLayoutAction.h
//  Bricks
//
//  Created by Makarov Yury on 27/08/16.
//  Copyright © 2016 Makarov Yury. All rights reserved.
//

#import "BRKLayoutAction.h"

NS_ASSUME_NONNULL_BEGIN

@class BRKEdgeValue;
@class BRKAxisValue;


@interface BRKBaseLayoutAction : NSObject <BRKLayoutAction>

- (instancetype)initWithView:(UIView *)view NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

- (void)setNumberAttribute:(CGFloat)value;
- (void)setPointAttribute:(CGPoint)point;
- (void)setSizeAttribute:(CGSize)size;
- (void)setRectAttribute:(CGRect)rect;
- (void)setViewAttribute:(UIView *)view;
- (void)setEdgeAttribute:(BRKEdgeValue *)attr;
- (void)setAxisAttribute:(BRKAxisValue *)attr;

@end

NS_ASSUME_NONNULL_END