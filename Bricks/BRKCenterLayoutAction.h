//
//  BRKCenterLayoutAction.h
//  Bricks
//
//  Created by Makarov Yury on 27/08/16.
//  Copyright © 2016 Makarov Yury. All rights reserved.
//

#import "BRKBaseLayoutAction.h"
#import "BRKLayoutGeometry.h"

NS_ASSUME_NONNULL_BEGIN

@interface BRKCenterLayoutAction : BRKBaseLayoutAction

@property (nonatomic, assign) BRKAxis axis;

- (instancetype)initWithView:(UIView *)view axis:(BRKAxis)axis initialValue:(CGPoint)initialValue NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithView:(UIView *)view NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END