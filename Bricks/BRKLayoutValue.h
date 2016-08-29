//
//  BRKLayoutValue.h
//  Bricks
//
//  Created by Makarov Yury on 27/08/16.
//  Copyright © 2016 Makarov Yury. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@protocol BRKLayoutValue <NSObject>

@property (nonatomic, strong, readonly) UIView *view;

@end

NS_ASSUME_NONNULL_END