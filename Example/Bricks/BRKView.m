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

@property (nonatomic, strong, readonly) UIView *first;
@property (nonatomic, strong, readonly) UIView *second;
@property (nonatomic, strong, readonly) UIView *third;
@property (nonatomic, strong, readonly) UIView *forth;
@property (nonatomic, strong, readonly) UIView *border;

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
    _first = [[UIView alloc] init];
    self.first.backgroundColor = [UIColor blackColor];
    [self addSubview:self.first];
    
    _second = [[UIView alloc] init];
    self.second.backgroundColor = [UIColor darkGrayColor];
    [self addSubview:self.second];
    
    _third = [[UIView alloc] init];
    self.third.backgroundColor = [UIColor grayColor];
    [self addSubview:self.third];
    
    _forth = [[UIView alloc] init];
    self.forth.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:self.forth];
    
    _border = [[UIView alloc] init];
    self.border.layer.borderColor = [UIColor redColor].CGColor;
    self.border.layer.borderWidth = 1.0;
    [self addSubview:self.border];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.first brk_make:^(BRKLayoutMaker * _Nonnull make) {
        make.left.top.moveTo(15);
        make.width.height.resizeTo(90);
    }];
    
    [self.border brk_make:^(BRKLayoutMaker * _Nonnull make) {
        make.edges.resizeTo(self.first);
    }];
    
    [self.second brk_make:^(BRKLayoutMaker * _Nonnull make) {
        make.height.resizeTo(15);
        make.left.moveTo(self.first.brk_right).with.offset(15);
        make.top.moveTo(self.first).with.offset(6);
        make.right.resizeTo(@(-15));
    }];
    
    [self.third brk_make:^(BRKLayoutMaker * _Nonnull make) {
        make.height.resizeTo(15);
        make.left.moveTo(self.first.brk_right).with.offset(15);
        make.top.moveTo(self.second.brk_bottom).with.offset(15);
        make.right.resizeTo(@(-15));
    }];
    
    [self.forth brk_make:^(BRKLayoutMaker * _Nonnull make) {
        make.height.resizeTo(15);
        make.left.moveTo(self.first.brk_right).with.offset(15);
        make.top.moveTo(self.third.brk_bottom).with.offset(15);
        make.right.resizeTo(@(-15));
    }];
}

@end
