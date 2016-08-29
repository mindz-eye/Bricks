//
//  BRKLayoutMaker.h
//  Bricks
//
//  Created by Makarov Yury on 24/08/16.
//  Copyright © 2016 Makarov Yury. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@class BRKLayoutOperation;


@interface BRKLayoutMaker : NSObject

@property (nonatomic, strong, readonly) BRKLayoutOperation *left;
@property (nonatomic, strong, readonly) BRKLayoutOperation *top;
@property (nonatomic, strong, readonly) BRKLayoutOperation *right;
@property (nonatomic, strong, readonly) BRKLayoutOperation *bottom;
@property (nonatomic, strong, readonly) BRKLayoutOperation *width;
@property (nonatomic, strong, readonly) BRKLayoutOperation *height;
@property (nonatomic, strong, readonly) BRKLayoutOperation *centerX;
@property (nonatomic, strong, readonly) BRKLayoutOperation *centerY;
@property (nonatomic, strong, readonly) BRKLayoutOperation *edges;
@property (nonatomic, strong, readonly) BRKLayoutOperation *size;
@property (nonatomic, strong, readonly) BRKLayoutOperation *center;

- (instancetype)initWithView:(UIView *)view NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

- (void)commit;

@end

NS_ASSUME_NONNULL_END