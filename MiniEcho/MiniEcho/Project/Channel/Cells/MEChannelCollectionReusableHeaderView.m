//
//  MEChannelCollectionReusableHeaderView.m
//  MiniEcho
//
//  Created by vcredit on 16/11/15.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#import "MEChannelCollectionReusableHeaderView.h"


@implementation HeaderModel

@end
@interface MEChannelCollectionReusableHeaderView ()
@property (nonatomic,strong)UIImageView *leftImageView;
@end
@implementation MEChannelCollectionReusableHeaderView
+ (UINib *)nib
{
    NSString *className = NSStringFromClass(self) ;
    return [UINib nibWithNibName:className bundle:nil] ;
}
- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(10, 10, 20, 20);
        [self addSubview:imageView];
        self.leftImageView = imageView;
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(10, 10, 20, 20);
    [self addSubview:imageView];
    self.leftImageView = imageView;
    
}
- (void)setModel:(HeaderModel *)model {

    _model = model;
    if (!model) return;
    [_leftImageView setImage:[UIImage imageNamed:model.imageName]];
    for (id subView in self.subviews) {
        if ([subView isKindOfClass:[UIButton class] ]) {
            [subView removeFromSuperview];
        }
    }
    NSInteger index = 0;
    CGFloat allX = CGRectGetMaxX(_leftImageView.frame) + 4;
    for (NSString *title in model.titleArray) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = index;
        CGFloat titleWidth = [MEUtil widthForSingleLineText:title fontSize:12.f];
        button.frame = CGRectMake( allX, 10, titleWidth, 20);
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:12.f]];
        [button addTarget:self action:@selector(headerViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        index++;
        allX += titleWidth + 4;
    }

}
- (void)headerViewBtnClick:(UIButton *)sender {

    NSLog(@"click===%ld",sender.tag);
    if (_callBlock) {
        _callBlock(sender.tag);
    }
}

@end
