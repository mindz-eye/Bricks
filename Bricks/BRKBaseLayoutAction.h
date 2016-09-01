//
//  BRKBaseLayoutAction.h
//  Bricks
//
//  Created by Makarov Yury on 27/08/16.
//  Copyright © 2016 Makarov Yury. All rights reserved.
//

#import "BRKLayoutAction.h"

NS_ASSUME_NONNULL_BEGIN

@interface BRKBaseLayoutAction : NSObject <BRKLayoutAction>

@property (nonatomic, strong, readonly) UIView *ownerView;

- (instancetype)initWithView:(UIView *)view NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END