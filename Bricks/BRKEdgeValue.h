//
//  BRKEdgeValue.h
//  Bricks
//
//  Created by Makarov Yury on 27/08/16.
//  Copyright © 2016 Makarov Yury. All rights reserved.
//

#import "BRKLayoutValue.h"

NS_ASSUME_NONNULL_BEGIN

@interface BRKEdgeValue : NSObject <BRKLayoutValue>

@property (nonatomic, assign, readonly) UIRectEdge edge;

- (instancetype)initWithEdge:(UIRectEdge)edge view:(UIView *)view NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END