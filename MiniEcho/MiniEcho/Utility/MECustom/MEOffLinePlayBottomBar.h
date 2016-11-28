//
//  MEOffLinePlayBottomBar.h
//  MiniEcho
//
//  Created by vcredit on 2016/11/28.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,BottomBarBtnType) {

    BottomBarBtnTypePlay = 0,
    BottomBarBtnTypeNext,
    BottomBarBtnTypePrev,
    BottomBarBtnTypeList
};

typedef void(^BottomBarBtnCallBack)(BottomBarBtnType btnType,BOOL isSelected);
@interface MEOffLinePlayBottomBar : UIView

@property (nonatomic, copy) BottomBarBtnCallBack btnClickCallBcak;

@end
