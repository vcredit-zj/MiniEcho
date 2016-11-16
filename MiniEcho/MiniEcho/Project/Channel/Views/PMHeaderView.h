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

@interface PMHeaderView : UIView

@property (nonatomic, assign) float offset;

@property (nonatomic, strong) PMHerderModel *model;

@property (nonatomic, strong) UIImage *image;


@property (nonatomic, copy) HeaderViewTapAction action;



@end
