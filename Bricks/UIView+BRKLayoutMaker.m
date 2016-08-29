//
//  UIView+BRKLayoutMaker.m
//  Bricks
//
//  Created by Makarov Yury on 24/08/16.
//  Copyright © 2016 Makarov Yury. All rights reserved.
//

#import "UIView+BRKLayoutMaker.h"
#import "BRKLayoutMaker.h"
#import "BRKEdgeValue.h"
#import "BRKAxisValue.h"
#import <objc/runtime.h>

@implementation UIView (BRKLayoutMaker)

- (id<BRKLayoutValue>)brk_left {
    return [self brk_objectForKey:_cmd factoryBlock:^id{
        return [[BRKEdgeValue alloc] initWithEdge:UIRectEdgeLeft view:self];
    }];
}

- (id<BRKLayoutValue>)brk_top {
    return [self brk_objectForKey:_cmd factoryBlock:^id{
        return [[BRKEdgeValue alloc] initWithEdge:UIRectEdgeTop view:self];
    }];
}

- (id<BRKLayoutValue>)brk_right {
    return [self brk_objectForKey:_cmd factoryBlock:^id{
        return [[BRKEdgeValue alloc] initWithEdge:UIRectEdgeRight view:self];
    }];
}

- (id<BRKLayoutValue>)brk_bottom {
    return [self brk_objectForKey:_cmd factoryBlock:^id{
        return [[BRKEdgeValue alloc] initWithEdge:UIRectEdgeBottom view:self];
    }];
}

- (id<BRKLayoutValue>)brk_centerX {
    return [self brk_objectForKey:_cmd factoryBlock:^id{
        return [[BRKAxisValue alloc] initWithAxis:BRKAxisHorizontal view:self];
    }];
}

- (id<BRKLayoutValue>)brk_centerY {
    return [self brk_objectForKey:_cmd factoryBlock:^id{
        return [[BRKAxisValue alloc] initWithAxis:BRKAxisVertical view:self];
    }];
}

- (void)brk_make:(void(^)(BRKLayoutMaker *make))block {
    BRKLayoutMaker *make = [self brk_objectForKey:_cmd factoryBlock:^id{
        return [[BRKLayoutMaker alloc] initWithView:self];
    }];
    block(make);
    [make commit];
}

- (id)brk_objectForKey:(const void *)key factoryBlock:(id(^)())factoryBlock {
    id object = objc_getAssociatedObject(self, key);
    if (!object) {
        object = factoryBlock();
        objc_setAssociatedObject(self, key, object, OBJC_ASSOCIATION_RETAIN);
    }
    return object;
}

@end
