//
//  MEchannelCollectionViewAnotherCell.m
//  MiniEcho
//
//  Created by vcredit on 16/11/15.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#import "MEchannelCollectionViewAnotherCell.h"
#import "MEChannelCategrayData.h"
#import "MEChannelCategrayChildren.h"
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
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGFloat viewWidth = 55;
    CGFloat margin = 10;
    for (int i = 0; i < [dataArray count]; i++) {
        MEChannelCategrayData *dataModel = [dataArray safeObjectAtIndex:i];
        UIView *view = [[UIView alloc] init];
        view.tag = i;
        view.frame =  CGRectMake(i*(viewWidth + margin) + margin, 0, viewWidth, viewWidth + 20);
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.userInteractionEnabled = YES;
        [view addSubview:imageView];
        [imageView sd_setImageWithURL:[NSURL URLWithString:dataModel.ico_url] placeholderImage:[MEUtil imageWithColor:[UIColor yellowColor]]];
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
        [bottomLabel setTextAlignment:NSTextAlignmentCenter];
        [bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imageView.mas_bottom);
            make.bottom.equalTo(view.mas_bottom);
            make.left.equalTo(view.mas_left);
            make.right.equalTo(view.mas_right);
            make.width.equalTo(view);
        }];
        [self.scrollView addSubview:view];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] init];
        
        [tapGesture addTarget:self action:@selector(tapAction:)];
        [view addGestureRecognizer:tapGesture];
        
    }
    self.scrollView.contentSize = CGSizeMake((viewWidth + margin) * [dataArray count], 0);

}
- (void)tapAction:(UITapGestureRecognizer *)gesture {

    NSLog(@"click === %ld",gesture.view.tag);
    if (_callBcak) {
         MEChannelCategrayData *model = [self.dataArray safeObjectAtIndex:gesture.view.tag];
        if (!model) return;
        _callBcak(model);
    }
}
@end
