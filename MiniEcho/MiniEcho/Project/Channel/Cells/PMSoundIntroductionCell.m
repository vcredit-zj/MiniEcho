//
//  PMSoundIntroductionCell.m
//  MiniEcho
//
//  Created by ALittleNasty on 16/11/15.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#import "PMSoundIntroductionCell.h"

@implementation PMSoundIntroductionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Setter

- (void)setLyric:(NSString *)lyric
{
    NSMutableAttributedString *lyricAttr = [[NSMutableAttributedString alloc] initWithString:lyric];
    lyricAttr.yy_font = [UIFont systemFontOfSize:12.0];
    lyricAttr.yy_color = [UIColor colorWithHexString:@"#333333"];
    lyricAttr.yy_lineSpacing = 5.f;
    lyricAttr.yy_alignment = NSTextAlignmentCenter;
    
    _lyricLabel.attributedText = lyricAttr;
}

@end
