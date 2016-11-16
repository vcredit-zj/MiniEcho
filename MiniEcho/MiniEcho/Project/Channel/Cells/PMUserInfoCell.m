//
//  PMUserInfoCell.m
//  MiniEcho
//
//  Created by ALittleNasty on 16/11/15.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#import "PMUserInfoCell.h"
#import "MEUser.h"

@interface PMUserInfoCell ()

@end

@implementation PMUserInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.avatorImage.layer.cornerRadius = 17.5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Setter

- (void)setUser:(MEUser *)user
{
    _user = user;
    
    [_avatorImage sd_setImageWithURL:[NSURL URLWithString:_user.avatar_50]];
    _nameLabel.text = _user.name;
    _fansLabel.text = [NSString stringWithFormat:@"粉丝 %zd",_user.followed_count];
    
    if ([_user.is_follow boolValue]) {
        _followButton.selected = NO;
    } else {
        _followButton.selected = YES;
    }
    
    NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"此回声由 "];
    one.yy_font = [UIFont systemFontOfSize:12.f];
    one.yy_color = [UIColor colorWithHexString:@"999999"];
    
    NSMutableAttributedString *two = [[NSMutableAttributedString alloc] initWithString:_user.name];
    two.yy_font = [UIFont systemFontOfSize:12.f];
    two.yy_color = MEColor(151, 250, 48);
    
    NSMutableAttributedString *three = [[NSMutableAttributedString alloc] initWithString:@" 上传"];
    three.yy_font = [UIFont systemFontOfSize:12.f];
    three.yy_color = [UIColor colorWithHexString:@"999999"];
    
    [one appendAttributedString:two];
    [one appendAttributedString:three];
    _uploadAuthorLabel.attributedText = one;
}

@end
