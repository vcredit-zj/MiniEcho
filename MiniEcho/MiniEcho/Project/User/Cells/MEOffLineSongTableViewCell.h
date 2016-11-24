//
//  MEOffLineSongTableViewCell.h
//  MiniEcho
//
//  Created by vcredit on 2016/11/23.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MELocalSound;
extern NSString *MEOffLineSongTableViewCellID;
@interface MEOffLineSongTableViewCell : UITableViewCell
@property (nonatomic, strong) MELocalSound *model;
@end
