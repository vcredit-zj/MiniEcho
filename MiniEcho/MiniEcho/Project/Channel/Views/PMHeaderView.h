//
//  PMHeaderView.h
//  MiniEcho
//
//  Created by ALittleNasty on 16/11/15.
//  Copyright © 2016年 vcredit. All rights reserved.


/**
 *  播放音乐界面HeaderView
 */
#import <UIKit/UIKit.h>
@class PMHerderModel;

typedef void(^HeaderViewTapAction)(NSInteger index);

typedef void(^DragSliderAction)(float progress);

@interface PMHeaderView : UIView

@property (nonatomic, assign) float offset;

@property (nonatomic, strong) PMHerderModel *model;

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, assign) float playProgress;


@property (nonatomic, copy) NSString *currentTime;


@property (nonatomic, copy) DragSliderAction sliderAction;



@property (nonatomic, copy) HeaderViewTapAction action;



@end
