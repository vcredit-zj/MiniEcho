//
//  MESingleChannelCollectionCell.m
//  MiniEcho
//
//  Created by vcredit on 16/11/16.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#import "MESingleChannelCollectionCell.h"

#import "MESingleChannelSounds.h"
#import "MESingleChannelUser.h"
NSString *MESingleChannelCollectionCellID = @"MESingleChannelCollectionCellID";

@interface MESingleChannelCollectionCell ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (nonatomic,strong) UILabel *describeLabel;
@property (nonatomic,strong) UILabel *nameLabel;
@end

@implementation MESingleChannelCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    if (_describeLabel) {
        return;
    }
    UILabel *describeLabel = [[UILabel alloc] init];
    [describeLabel setFont:[UIFont systemFontOfSize:14.f]];
    [self.contentView addSubview:describeLabel];
    [describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bgImageView.mas_bottom);
        make.left.equalTo(_bgImageView);
        make.right.equalTo(_bgImageView);
        make.height.equalTo(@20);
    }];
    _describeLabel = describeLabel;
    UILabel *nameLabel = [[UILabel alloc] init];
    [nameLabel setFont:[UIFont systemFontOfSize:12.f]];
    [nameLabel setTextColor:[UIColor colorWithHexString:@"#999999"]];
    [self.contentView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(describeLabel.mas_bottom);
        make.left.equalTo(_bgImageView);
        make.right.equalTo(_bgImageView);
        make.height.equalTo(@15);
    }];

    _nameLabel = nameLabel;
    
    
    
}
- (void)setModel:(MESingleChannelSounds *)model {

    _model = model;
    
    [_bgImageView sd_setImageWithURL:[NSURL URLWithString:model.pic640] placeholderImage:nil];
    [_label setText:[NSString stringWithFormat:@"%d",(int)model.likeCount]];
    
    [_describeLabel setText:model.name];
    [_nameLabel setText:model.user.name];
    
}
@end
