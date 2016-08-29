//
//  BRKEdgeValue.m
//  Bricks
//
//  Created by Makarov Yury on 27/08/16.
//  Copyright © 2016 Makarov Yury. All rights reserved.
//

#import "BRKEdgeValue.h"

@implementation BRKEdgeValue

@synthesize view = _view;

- (instancetype)initWithEdge:(UIRectEdge)edge view:(UIView *)view {
    self = [super init];
    if (self) {
        _edge = edge;
        _view = view;
    }
    return self;
}

@end
