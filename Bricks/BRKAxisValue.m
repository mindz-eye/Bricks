//
//  BRKAxisValue.m
//  Bricks
//
//  Created by Makarov Yury on 27/08/16.
//  Copyright © 2016 Makarov Yury. All rights reserved.
//

#import "BRKAxisValue.h"

@implementation BRKAxisValue

@synthesize view = _view;

- (instancetype)initWithAxis:(BRKAxis)axis view:(UIView *)view {
    self = [super init];
    if (self) {
        _axis = axis;
        _view = view;
    }
    return self;
}

@end
