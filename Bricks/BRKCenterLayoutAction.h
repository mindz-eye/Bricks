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

- (instancetype)initWithView:(UIView *)view axis:(BRKAxis)axis NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END