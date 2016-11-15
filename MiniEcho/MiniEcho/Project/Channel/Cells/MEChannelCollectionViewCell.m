//
//  MEChannelCollectionViewCell.m
//  MiniEcho
//
//  Created by vcredit on 16/11/15.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#import "MEChannelCollectionViewCell.h"
NSString *MEChannelCollectionViewCellID = @"NSString *MEChannelCollectionViewCellID";

@interface MEChannelCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation MEChannelCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(MEChannelHotData *)model {

    _model = model;
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.pic640] placeholderImage:nil];
    _label.text = model.name;
}
@end
