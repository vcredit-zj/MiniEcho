//
//  MEchannelCollectionViewAnotherCell.m
//  MiniEcho
//
//  Created by vcredit on 16/11/15.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#import "MEchannelCollectionViewAnotherCell.h"
#import "MEChannelCategrayData.h"
NSString *MEchannelCollectionViewAnotherCellID = @"NSString *MEchannelCollectionViewAnotherCellID";

@interface MEchannelCollectionViewAnotherCell ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end
@implementation MEchannelCollectionViewAnotherCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    }
- (void)setDataArray:(NSArray *)dataArray {

    _dataArray = dataArray;
    CGFloat viewWidth = 55;
    CGFloat margin = 10;
    for (int i = 0; i < [dataArray count]; i++) {
        MEChannelCategrayData *dataModel = [dataArray safeObjectAtIndex:i];
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor orangeColor];
        view.frame =  CGRectMake(i*(viewWidth + margin) + margin, 0, viewWidth, viewWidth + 20);
        UIImageView *imageView = [[UIImageView alloc] init];
        [view addSubview:imageView];
        [imageView sd_setImageWithURL:[NSURL URLWithString:dataModel.icoUrl] placeholderImage:nil];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view.mas_top);
            make.left.equalTo(view.mas_left);
            make.right.equalTo(view.mas_right);
            make.width.equalTo(view);
            make.height.equalTo(view.mas_width);
        }];
        UILabel *bottomLabel = [[UILabel alloc] init];
        [view addSubview:bottomLabel];
        [bottomLabel setText:dataModel.name];
        [bottomLabel setFont:[UIFont systemFontOfSize:12.f]];
        [bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imageView.mas_bottom);
            make.bottom.equalTo(view.mas_bottom);
            make.left.equalTo(view.mas_left);
            make.right.equalTo(view.mas_right);
            make.width.equalTo(view);
        }];
        [self.scrollView addSubview:view];
        
    }
    self.scrollView.contentSize = CGSizeMake((viewWidth + margin) * [dataArray count], 0);

}
@end
