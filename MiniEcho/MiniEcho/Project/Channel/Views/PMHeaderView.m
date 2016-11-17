//
//  PMHeaderView.m
//  MiniEcho
//
//  Created by ALittleNasty on 16/11/15.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#import "PMHeaderView.h"
#import "PMHerderModel.h"

@interface PMHeaderView ()

/** 大图 */
@property (nonatomic, strong) UIImageView *imageView;
/** 播放时间label */
@property (nonatomic, strong) UILabel *playTimeLabel;
/** 总时间label */
@property (nonatomic, strong) UILabel *totalTimeLabel;
/** 试听次数label */
@property (nonatomic, strong) UILabel *listenCountLabel;
/** 分割线 */
@property (nonatomic, strong) UIView  *lineView;
/** 下载图片按钮 */
@property (nonatomic, strong) UIButton *downloadImgBtn;
/** 下载次数按钮 */
@property (nonatomic, strong) UIButton *downloadCountBtn;
/** 点赞按钮 */
@property (nonatomic, strong) UIButton *likeBtn;
/** 音乐进度滑动条 */
@property (nonatomic, strong) UISlider *slider;

@end

@implementation PMHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

#pragma mark - Initialization

- (void)initSubviews
{
    self.backgroundColor = [UIColor whiteColor];
    
    _imageView = [[UIImageView alloc] init];
    _imageView.clipsToBounds = YES;
    _imageView.frame = CGRectMake(0.f, 0.f, kScreenWidth, kScreenWidth);
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.backgroundColor = RandomColor;
    [self addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.equalTo(@(kScreenWidth));
    }];
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(kScreenWidth);
        make.left.right.bottom.equalTo(self);
    }];
    
    _slider = [[UISlider alloc] init];
    _slider.minimumValue = 0.f;
    _slider.maximumValue = 1.f;
    _slider.value = 0.f;
    _slider.backgroundColor = [UIColor clearColor];
    _slider.tintColor = [UIColor colorWithHexString:@"#41FFF0"];
    [_slider setThumbImage:[UIImage imageNamed:@"adminOperate"] forState:UIControlStateNormal];
    [_slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_slider];
    [_slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.mas_top).offset(kScreenWidth-15);
        make.height.equalTo(@30);
    }];
    
    _playTimeLabel = [[UILabel alloc] init];
    _playTimeLabel.backgroundColor = [UIColor whiteColor];
    _playTimeLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    _playTimeLabel.text = @"00:00";
    _playTimeLabel.font = [UIFont systemFontOfSize:12.f];
    [self addSubview:_playTimeLabel];
    [_playTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(5);
        make.top.equalTo(_slider.mas_bottom);
        make.height.equalTo(@15);
        make.width.equalTo(@50);
    }];
    
    _totalTimeLabel = [[UILabel alloc] init];
    _totalTimeLabel.textAlignment = NSTextAlignmentRight;
    _totalTimeLabel.backgroundColor = [UIColor whiteColor];
    _totalTimeLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    _totalTimeLabel.text = @"00:00";
    _totalTimeLabel.font = [UIFont systemFontOfSize:12.f];
    [self addSubview:_totalTimeLabel];
    [_totalTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-5);
        make.top.equalTo(_slider.mas_bottom);
        make.height.equalTo(@15);
        make.width.equalTo(@50);
    }];
    
    _listenCountLabel = [[UILabel alloc] init];
    _listenCountLabel.backgroundColor = [UIColor whiteColor];
    _listenCountLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    _listenCountLabel.text = @"0 次试听";
    _listenCountLabel.font = [UIFont systemFontOfSize:12.f];
    [self addSubview:_listenCountLabel];
    [_listenCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(_slider.mas_bottom);
        make.height.equalTo(@15);
    }];
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = [UIColor colorWithHexString:@"#dddddd"];
    [self addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_playTimeLabel.mas_bottom).offset(5);
        make.height.equalTo(@0.5);
        make.left.right.equalTo(self);
    }];
    
    _downloadImgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _downloadImgBtn.titleLabel.font = [UIFont systemFontOfSize:12.f];
    [_downloadImgBtn setImage:[UIImage imageNamed:@"pm_image"] forState:UIControlStateNormal];
    [_downloadImgBtn setTitle:@"下载图片" forState:UIControlStateNormal];
    [_downloadImgBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 0)];
    [_downloadImgBtn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    [_downloadImgBtn addTarget:self action:@selector(downloadImageBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_downloadImgBtn];
    [_downloadImgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@80);
        make.left.equalTo(self.mas_left).offset(10);
        make.top.equalTo(_lineView.mas_bottom);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    _likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _likeBtn.titleLabel.font = [UIFont systemFontOfSize:12.f];
    [_likeBtn setImage:[UIImage imageNamed:@"pm_heart"] forState:UIControlStateNormal];
    [_likeBtn setTitle:@"喜欢" forState:UIControlStateNormal];
    [_likeBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 0)];
    [_likeBtn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    [_likeBtn addTarget:self action:@selector(likeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_likeBtn];
    [_likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@80);
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(_lineView.mas_bottom);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    _downloadCountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_downloadCountBtn setImage:[UIImage imageNamed:@"pm_download"] forState:UIControlStateNormal];
    [_downloadCountBtn setTitle:@"下载歌曲" forState:UIControlStateNormal];
    _downloadCountBtn.titleLabel.font = [UIFont systemFontOfSize:12.f];
    [_downloadCountBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 0)];
    [_downloadCountBtn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    [_downloadCountBtn addTarget:self action:@selector(downloadSoundBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_downloadCountBtn];
    [_downloadCountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@80);
        make.right.equalTo(self.mas_right).offset(-10);
        make.top.equalTo(_lineView.mas_bottom);
        make.bottom.equalTo(self.mas_bottom);
    }];
}

#pragma mark - Setter

- (void)setOffset:(float)offset
{
//    DLog(@"%.2f",offset);
    CGFloat limit = (kScreenWidth + 70.f + 64.f) * -1;
    _offset = offset;
    if (_offset > limit) return;
    
    float delta = (limit - offset) * 0.02;
    
    CGFloat x = kScreenWidth * -0.5 * delta; 
    CGFloat width = kScreenWidth * (1.0 + delta);
    _imageView.frame = CGRectMake(x, x, width, width);
    
}

- (void)setModel:(PMHerderModel *)model
{
    _model = model;
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:_model.picURL]];
    
    _listenCountLabel.text = [NSString stringWithFormat:@"%zd 次收听", _model.view_count];
    [_likeBtn setTitle:[NSString stringWithFormat:@"喜欢 %zd",_model.like_count] forState:UIControlStateNormal];
    [_downloadCountBtn setTitle:[NSString stringWithFormat:@"离线 %zd",_model.download_count] forState:UIControlStateNormal];
    
    int time = [_model.length intValue];
    int min = time/60;
    int sec = time%60;
    _totalTimeLabel.text = [NSString stringWithFormat:@"%02d:%02d",min, sec];
}

- (void)setPlayProgress:(float)playProgress
{
    _playProgress = playProgress;
    
    [_slider setValue:_playProgress animated:YES];
}

- (void)setCurrentTime:(NSString *)currentTime
{
    _playTimeLabel.text = currentTime;
}

- (UIImage *)image
{
    return _imageView.image;
}

#pragma mark - Action

- (void)sliderAction:(UISlider *)slider
{
    if (_sliderAction) {
        _sliderAction(slider.value);
    }
}

- (void)downloadImageBtnAction
{ 
    if (_action) {
        _action(0);
    }
}

- (void)downloadSoundBtnAction
{
    if (_action) {
        _action(2);
    }
}

- (void)likeBtnAction
{
    if (_action) {
        _action(1);
    }
}

@end
