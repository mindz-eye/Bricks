//
//  BRKFrameMaker.h
//  Bricks
//
//  Created by Makarov Yury on 24/08/16.
//  Copyright © 2016 Makarov Yury. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface BRKFrameMaker : NSObject

@property (nonatomic, strong, readonly) BRKFrameMaker *top;
@property (nonatomic, strong, readonly) BRKFrameMaker *left;
@property (nonatomic, strong, readonly) BRKFrameMaker *bottom;
@property (nonatomic, strong, readonly) BRKFrameMaker *right;
@property (nonatomic, strong, readonly) BRKFrameMaker *edges;
@property (nonatomic, strong, readonly) BRKFrameMaker *width;
@property (nonatomic, strong, readonly) BRKFrameMaker *height;
@property (nonatomic, strong, readonly) BRKFrameMaker *centerX;
@property (nonatomic, strong, readonly) BRKFrameMaker *centerY;
@property (nonatomic, strong, readonly) BRKFrameMaker *size;
@property (nonatomic, strong, readonly) BRKFrameMaker *center;

@property (nonatomic, strong, readonly) BRKFrameMaker *with;
@property (nonatomic, strong, readonly) BRKFrameMaker *and;

@property (nonatomic, copy, readonly) BRKFrameMaker *(^insets)(UIEdgeInsets insets);
@property (nonatomic, copy, readonly) BRKFrameMaker *(^offset)(CGFloat offset);
@property (nonatomic, copy, readonly) BRKFrameMaker *(^centerOffset)(CGPoint offset);
@property (nonatomic, copy, readonly) BRKFrameMaker *(^valueOffset)(NSValue *value);

@property (nonatomic, copy, readonly) BRKFrameMaker *(^moveTo)(id object);
@property (nonatomic, copy, readonly) BRKFrameMaker *(^resizeTo)(id object);

- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;

@end

extern CGRect brk_make(void(NS_NOESCAPE ^block)(BRKFrameMaker *make));
extern CGRect brk_makeWithFrame(void(NS_NOESCAPE ^block)(BRKFrameMaker *make), CGRect frame);

NS_ASSUME_NONNULL_END
