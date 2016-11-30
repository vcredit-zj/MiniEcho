//
//  MEOffLinePlayself.m
//  MiniEcho
//
//  Created by vcredit on 2016/11/28.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#import "MEOffLinePlayBottomBar.h"
@implementation MEOffLinePlayBottomBar

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {
        UILabel *currentTimelabel = [[UILabel alloc] init];
        [self addSubview:currentTimelabel];
        currentTimelabel.text = @"00:00";
        [currentTimelabel setTextAlignment:NSTextAlignmentCenter];
        [currentTimelabel setFont:[UIFont systemFontOfSize:12.f]];
        [currentTimelabel setTextColor:[UIColor whiteColor]];
        [currentTimelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).with.offset(3);
            make.top.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(45, 20));
        }];
        UILabel *totalTimelabel = [[UILabel alloc] init];
        [self addSubview:totalTimelabel];
        totalTimelabel.text = @"02:02";
        [totalTimelabel setTextAlignment:NSTextAlignmentCenter];
        [totalTimelabel setFont:[UIFont systemFontOfSize:12.f]];
        [totalTimelabel setTextColor:[UIColor whiteColor]];
        [totalTimelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).with.offset(-3);
            make.top.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(45, 20));
        }];
        UISlider *playSongSlider = [[UISlider alloc] init];
        [self addSubview:playSongSlider];
        [playSongSlider setMinimumValue:0.f];
        [playSongSlider setMaximumValue:2.0f];
        [playSongSlider setThumbImage:[UIImage imageNamed:@"cm2_lay_icn_dot"] forState:UIControlStateNormal];
        playSongSlider.value = 1.0f;
        [playSongSlider setMinimumTrackTintColor:[UIColor redColor]];
        [playSongSlider setMaximumTrackTintColor:[UIColor grayColor]];
        [playSongSlider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(currentTimelabel.mas_right);
            make.right.equalTo(totalTimelabel.mas_left);
            make.centerY.equalTo(currentTimelabel);
            make.height.equalTo(@12);
        }];
        UIButton *playBtn = [[UIButton alloc] init];
        [self addSubview:playBtn];
        [playBtn setImage:[UIImage imageNamed:@"cm2_fm_btn_pause"] forState:UIControlStateNormal];
        [playBtn setImage:[UIImage imageNamed:@"cm2_btn_play"] forState:UIControlStateSelected];
        [playBtn addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        playBtn.tag = BottomBarBtnTypePlay;
        [playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self).with.offset(25);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
        UIButton *nextBtn = [[UIButton alloc] init];
        [self addSubview:nextBtn];
        UIImage *oriImage = [UIImage imageNamed:@"cm2_fm_btn_next"];
        [oriImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [nextBtn setImage:[oriImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        
        [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(playBtn.mas_right).with.offset(5);
            make.centerY.equalTo(playBtn);
            make.size.mas_equalTo(CGSizeMake(39, 39));
        }];
        [nextBtn addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        nextBtn.tag = BottomBarBtnTypeNext;
        UIButton *prevBtn = [[UIButton alloc] init];
        [self addSubview:prevBtn];
        [prevBtn setImage:[[UIImage imageNamed:@"cm2_play_btn_prev"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ] forState:UIControlStateNormal];
        [prevBtn addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        prevBtn.tag = BottomBarBtnTypePrev;
        [prevBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(playBtn.mas_left).with.offset(-5);
            make.centerY.equalTo(playBtn);
            make.size.mas_equalTo(CGSizeMake(39, 39));
        }];
        UIButton *listBtn = [[UIButton alloc] init];
        [self addSubview:listBtn];
        [listBtn setImage:[[UIImage imageNamed:@"cm2_icn_list"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ] forState:UIControlStateNormal];
        [listBtn addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        listBtn.tag = BottomBarBtnTypeList;
        [listBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).with.offset(-15);
            make.centerY.equalTo(playBtn);
            make.size.mas_equalTo(CGSizeMake(39, 39));
        }];
        //cm2_play_btn_loop
        UIButton *playModelBtn = [[UIButton alloc] init];
        [self addSubview:playModelBtn];
        [playModelBtn setImage:[[UIImage imageNamed:@"cm2_icn_loop"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ] forState:UIControlStateNormal];
        [playModelBtn setImage:[[UIImage imageNamed:@"cm2_icn_shuffle"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ] forState:UIControlStateSelected];
        [playModelBtn addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        playModelBtn.tag = BottomBarBtnTypeModel;
        [playModelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).with.offset(15);
            make.centerY.equalTo(playBtn);
            make.size.mas_equalTo(CGSizeMake(56, 56));
        }];


    }
    return self;
}
- (void)bottomBtnClick:(UIButton *)sender {
    if (!_btnClickCallBcak) return;
    if (sender.tag == BottomBarBtnTypePlay || sender.tag == BottomBarBtnTypeModel) {
        DLog(@"play");
        sender.selected = !sender.isSelected;
    }
     _btnClickCallBcak(sender.tag,sender.isSelected);
}
@end
