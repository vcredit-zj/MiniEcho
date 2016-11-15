//
//  MEPlayToolBar.m
//  MiniEcho
//
//  Created by ALittleNasty on 16/11/15.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#import "MEPlayToolBar.h"

@interface MEPlayToolBar ()



@end

@implementation MEPlayToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews
{
    self.backgroundColor = [UIColor whiteColor];
    
    NSArray *btnImages = @[[UIImage imageNamed:@"m_normal"],
                           [UIImage imageNamed:@"m_previous"],
                           [UIImage imageNamed:@"m_play"],
                           [UIImage imageNamed:@"m_next"],
                           [UIImage imageNamed:@"m_more"]];
    
    CGFloat btnWidth = (kScreenWidth - 20.f) * 0.2;
    CGFloat btnHeight = 45.f;
    for (NSInteger i=0; i < 5; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:btnImages[i] forState:UIControlStateNormal];
        if (i == 0) {
            [btn setImage:[UIImage imageNamed:@"m_random"] forState:UIControlStateSelected];
        } else if (i == 2) {
            [btn setImage:[UIImage imageNamed:@"m_stop"] forState:UIControlStateSelected];
        }
        btn.tag = i;
        [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(10.0 + btnWidth * i, 5.f, btnWidth, btnHeight);
        [self addSubview:btn];
    }
}

#pragma mark - Action

- (void)buttonAction:(UIButton *)btn
{
    if (btn.tag == 0) {
        btn.selected = !btn.selected;
    } else if (btn.tag == 2) {
        btn.selected = !btn.selected;
    } else {
    
    }

}

@end
