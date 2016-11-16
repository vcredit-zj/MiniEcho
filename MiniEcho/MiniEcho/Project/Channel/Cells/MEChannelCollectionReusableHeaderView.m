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
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(10, 0, 20, 20);
    [self addSubview:imageView];
    
}
- (void)setModel:(HeaderModel *)model {

    _model = model;
    
    [_leftImageView setImage:[UIImage imageNamed:model.imageName]];
    NSInteger index = 1;
    for (NSString *title in model.titleArray) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = index;
        button.frame = CGRectMake( index * 20, 0, 20, 20);
        [button setTitle:title forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:12.f]];
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        index++;
    }
    
}

@end
