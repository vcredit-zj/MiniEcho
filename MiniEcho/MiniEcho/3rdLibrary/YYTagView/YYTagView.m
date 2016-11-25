//
//  YYTagView.m
//  YYTagViewDemo
//
//  Created by 胡阳 on 2016/11/20.
//  Copyright © 2016年 young4ever. All rights reserved.
//

#import "YYTagView.h"

@interface YYTagView ()

@property (nonatomic, strong) UIButton *titleBtn;

@end

@implementation YYTagView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_titleBtn setTitle:_title forState:UIControlStateNormal];
        
        [_titleBtn setBackgroundColor:[UIColor whiteColor]];
        
        [_titleBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        
        [_titleBtn setFrame:frame];
        
        [_titleBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_titleBtn];
    }
    return self;
}

#pragma mark - Action

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [_titleBtn setBackgroundColor:backgroundColor];
}

- (void)buttonClicked:(UIButton *)btn
{
    if (_action) {
        _action(btn.tag);
    }
}

#pragma mark - Setter

- (void)setIndex:(NSInteger)index
{
    _index = index;
    
    [_titleBtn setTag:_index];
}

- (void)setFontSize:(CGFloat)fontSize
{
    _fontSize = fontSize;
    _titleBtn.titleLabel.font = [UIFont systemFontOfSize:_fontSize];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    [_titleBtn setTitle:_title forState:UIControlStateNormal];
}

- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    [_titleBtn setTitleColor:_titleColor forState:UIControlStateNormal];
}

- (void)setRadius:(CGFloat)radius
{
    _radius = radius;
    
    if (_radius) {
        _titleBtn.layer.cornerRadius = _radius;
        _titleBtn.clipsToBounds = YES;
    }
}


@end
