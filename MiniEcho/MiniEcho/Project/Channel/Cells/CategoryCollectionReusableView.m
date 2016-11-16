//
//  CategoryCollectionReusableView.m
//  MiniEcho
//
//  Created by 潘杨东 on 2016/11/15.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#import "CategoryCollectionReusableView.h"
#import "HXTagsView.h"
#import "MEChannelCategrayData.h"
#import "MEChannelCategrayChildren.h"
#define kScreenHeight   [UIScreen mainScreen].bounds.size.height
#define kScreenWidth    [UIScreen mainScreen].bounds.size.width

@interface CategoryCollectionReusableView ()<HXTagsViewDelegate>

@property (nonatomic, strong) UIImageView *leftImage;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *rightLabel;

@property (nonatomic, strong) HXTagsView *tagsView;

@property (nonatomic, strong) NSMutableArray *tagID;

@end

@implementation CategoryCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

#pragma mark - Initilization
- (void)initSubviews
{
    _leftImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    _leftImage.backgroundColor = [UIColor orangeColor];
    _leftImage.layer.masksToBounds = YES;
    _leftImage.layer.cornerRadius = 20.f;
    [self addSubview:_leftImage];
    [_leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15.f);
        make.size.mas_equalTo(CGSizeMake(40.f, 40.f));
        make.top.equalTo(self.mas_top).offset(10.f);
    }];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.text = @"专题";
    _titleLabel.font = [UIFont systemFontOfSize:15.f];
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftImage.mas_right).offset(15.f);
        make.top.equalTo(self.mas_top).offset(20.f);
        make.height.equalTo(@20.f);
    }];
    
    _rightLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _rightLabel.text = @"共9个频道";
    _rightLabel.font = [UIFont systemFontOfSize:15.f];
    [self addSubview:_rightLabel];
    [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-15.f);
        make.top.equalTo(self.mas_top).offset(20.f);
        make.height.equalTo(@20.f);
    }];
    
    //多行不滚动,则计算出全部展示的高度,让maxHeight等于计算出的高度即可,初始化不需要设置高度
    _tagsView = [[HXTagsView alloc] initWithFrame:CGRectMake(0, 60, kScreenWidth, 0)];
    _tagsView.type = 0;
    [self addSubview:_tagsView];
    
}

#pragma mark HXTagsViewDelegate

/**
 *  tagsView代理方法
 *
 *  @param tagsView tagsView
 *  @param sender   tag:sender.titleLabel.text index:sender.tag
 */
- (void)tagsViewButtonAction:(HXTagsView *)tagsView button:(UIButton *)sender {
    NSLog(@"tag:%@ index:%ld",sender.titleLabel.text, sender.tag);
    if (_block) {
        _block(_tagID[sender.tag]);
    }
}

- (void)setModel:(MEChannelCategrayData *)model
{
    _model = model;
    MEChannelCategrayChildren *childModel;
    _array = [NSMutableArray array];
    _tagID = [NSMutableArray array];
    for (NSInteger i = 0; i < model.children.count; i ++) {
        childModel = model.children[i];
        [_array addObject:childModel.name];
        [_tagID addObject:[NSString stringWithFormat:@"%zd", (NSInteger)childModel.childrenIdentifier]];
    }

    [_array insertObject:@"全部" atIndex:0];
    [_tagID safeInsertObject:[NSString stringWithFormat:@"%zd", (NSInteger)model.dataIdentifier] atIndex:0];
    [_tagsView setTagAry:_array delegate:self];
    
    NSURL *url = [NSURL URLWithString:model.icoUrl];
    [_leftImage sd_setImageWithURL:url];
    
    NSString *str = [NSString stringWithFormat:@"共%zd个频道", model.children.count + 1];
    _rightLabel.text = str;
    
    
}


@end
