//
//  MEOffLineSongTableViewCell.m
//  MiniEcho
//
//  Created by vcredit on 2016/11/23.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#import "MEOffLineSongTableViewCell.h"

#import "MELocalSound.h"
NSString *MEOffLineSongTableViewCellID = @"MEOffLineSongTableViewCellID";

@interface MEOffLineSongTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *songNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *songSingleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;

@end

@implementation MEOffLineSongTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [_songSingleLabel setTextColor:[UIColor colorWithHexString:@"#999999"] ];
    [_songNameLabel setTextColor:[UIColor colorWithHexString:@"#666666"] ];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    NSMutableArray *tempArrayM = [NSMutableArray array];
    for ( int i = 0;  i < 8;i++) {
        UIImage *aImage = [UIImage imageNamed:[NSString stringWithFormat:@"icon_playing_tag_%d",i]];
        [tempArrayM safeAddObject:aImage];
    }
    [_rightImageView setAnimationImages:tempArrayM];
    [_rightImageView setAnimationDuration:2.5];
    [_rightImageView setAnimationRepeatCount:0];
    
    _rightImageView.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    if (selected) {
        [_songSingleLabel setTextColor:[UIColor colorWithHexString:@"#6ed56c"] ];
        [_songNameLabel setTextColor:[UIColor colorWithHexString:@"#6ed56c"] ];
        [_rightImageView startAnimating];
        _rightImageView.hidden = NO;
    } else {
    
        [_songSingleLabel setTextColor:[UIColor colorWithHexString:@"#999999"] ];
        [_songNameLabel setTextColor:[UIColor colorWithHexString:@"#666666"] ];
        [_rightImageView stopAnimating];
        _rightImageView.hidden = YES;
        
    }
    
    
}
- (void)setModel:(MELocalSound *)model {

    _model = model;
    _songNameLabel.text = model.name;
    _songSingleLabel.text = model.singer;
    
}
@end
