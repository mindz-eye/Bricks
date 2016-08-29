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
@property (nonatomic, assign) CGRect targetFrame;

- (instancetype)initWithView:(UIView *)view edges:(UIRectEdge)edges NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END