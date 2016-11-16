//
//  MEPlayToolBar.h
//  MiniEcho
//
//  Created by ALittleNasty on 16/11/15.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, PlayToolBarButtonState) {

    PlayToolBarButtonStateNormalPlay = 0,
    PlayToolBarButtonStateRandomPlay = 1,
    PlayToolBarButtonStatePreviousSound = 2,
    PlayToolBarButtonStateNextSound = 3,
    PlayToolBarButtonStatePlayMusic = 4,
    PlayToolBarButtonStateStopPlayMusic = 5,
    PlayToolBarButtonStateMore = 6
};

@interface MEPlayToolBar : UIView;

@end
