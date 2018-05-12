//
//  BRKView.m
//  Bricks
//
//  Created by Makarov Yury on 30/08/16.
//  Copyright © 2016 Makarov Yuriy. All rights reserved.
//

#define BRK_SHORTHAND_GLOBALS

#import "BRKView.h"
#import <Bricks/Bricks.h>

@interface BRKView ()

@property (nonatomic, strong, readonly) UIView *black;
@property (nonatomic, strong, readonly) UIView *darkGray;
@property (nonatomic, strong, readonly) UIView *gray;
@property (nonatomic, strong, readonly) UIView *lightGray;
@property (nonatomic, strong, readonly) UIView *redBorder;

@end


@implementation BRKView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    [self setupSubviews];
}

- (void)setupSubviews {
    _black = [[UIView alloc] init];
    self.black.backgroundColor = [UIColor blackColor];
    [self addSubview:self.black];
    
    _darkGray = [[UIView alloc] init];
    self.darkGray.backgroundColor = [UIColor darkGrayColor];
    [self addSubview:self.darkGray];
    
    _gray = [[UIView alloc] init];
    self.gray.backgroundColor = [UIColor grayColor];
    [self addSubview:self.gray];
    
    _lightGray = [[UIView alloc] init];
    self.lightGray.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:self.lightGray];
    
    _redBorder = [[UIView alloc] init];
    self.redBorder.layer.borderColor = [UIColor redColor].CGColor;
    self.redBorder.layer.borderWidth = 1.0;
    [self addSubview:self.redBorder];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.black brk_make:^(BRKFrameMaker * _Nonnull make) {
        make.left.top.moveTo(15);
        make.width.height.resizeTo(90);
    }];
    
    [self.redBorder brk_make:^(BRKFrameMaker * _Nonnull make) {
        make.edges.resizeTo(self.black);
    }];
    
    [self.darkGray brk_make:^(BRKFrameMaker * _Nonnull make) {
        make.height.resizeTo(15);
        make.left.moveTo(self.black.brk_right).with.offset(15);
        make.top.moveTo(self.black).with.offset(6);
        make.right.resizeTo(self.brk_right).with.offset(-15);
    }];
    
    [self.gray brk_make:^(BRKFrameMaker * _Nonnull make) {
        make.height.resizeTo(15);
        make.left.moveTo(self.black.brk_right).with.offset(15);
        make.top.moveTo(self.darkGray.brk_bottom).with.offset(15);
        make.right.resizeTo(self.brk_right).with.offset(-15);
    }];
    
    [self.lightGray brk_make:^(BRKFrameMaker * _Nonnull make) {
        make.height.resizeTo(15);
        make.left.moveTo(self.black.brk_right).with.offset(15);
        make.top.moveTo(self.gray.brk_bottom).with.offset(15);
        make.right.resizeTo(self.brk_right).with.offset(-15);
    }];
}

@end
