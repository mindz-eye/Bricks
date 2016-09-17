//
//  BRKEdgeLayoutAction.h
//  Bricks
//
//  Created by Makarov Yury on 27/08/16.
//  Copyright © 2016 Makarov Yury. All rights reserved.
//

#import "BRKBaseLayoutAction.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, BRKEdgeActionType) {
    BRKEdgeActionTypeMove,
    BRKEdgeActionTypeSet
};

@interface BRKEdgeLayoutAction : BRKBaseLayoutAction

@property (nonatomic, assign) UIRectEdge edges;
@property (nonatomic, assign) BRKEdgeActionType type;

- (instancetype)initWithView:(UIView *)view edges:(UIRectEdge)edges initialValue:(CGRect)initialValue NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithView:(UIView *)view NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END