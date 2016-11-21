//
//  PMChannelInfoCell.m
//  MiniEcho
//
//  Created by ALittleNasty on 16/11/15.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#import "PMChannelInfoCell.h"
#import "PMSoundCollectionCell.h"

static NSString *cellID = @"PMSoundCollectionCellIdentifier";

@interface PMChannelInfoCell ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


@property (nonatomic, copy) NSArray *hotSounds;



@end

@implementation PMChannelInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[PMSoundCollectionCell nib] forCellWithReuseIdentifier:cellID];
    
    CGFloat itemWidth = (kScreenWidth - 40.f) / 3;
    self.posterImageWidthCons.constant = itemWidth;
    
    // add tapGesture on channel image
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(channelImagetapAction:)];
    _posterImage.userInteractionEnabled = YES;
    [_posterImage addGestureRecognizer:tapGesture];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - UICollectionViewDelegate & UICollectionViewDataSource & UICollectionViewDelegateFlowLayout

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _hotSounds.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat itemWidth = (kScreenWidth - 40.f) / 3;
    return CGSizeMake(itemWidth, itemWidth + 40.f);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PMSoundCollectionCell *soundCell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    soundCell.sound = _hotSounds[indexPath.item];
    return soundCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PMSimilarSubSound *sound = _hotSounds[indexPath.item];
    if (self.delegate && [self.delegate respondsToSelector:@selector(channelCellDidTapSoundWithID:)])
    {
        [self.delegate channelCellDidTapSoundWithID:sound.sound_id];
    }
}

#pragma mark - Action

- (void)channelImagetapAction:(UITapGestureRecognizer *)tap
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(channelCellDidTapChannelWithID:)])
    {
        [self.delegate channelCellDidTapChannelWithID:_channel.channel_id];
    }
}

#pragma mark - Setter

- (void)setChannel:(PMChannel *)channel
{
    _channel = channel;
    
    [_posterImage sd_setImageWithURL:[NSURL URLWithString:_channel.pic_500]];
    _channelNameLabel.text = _channel.name;
    _channelDescLabel.text = _channel.info;
    
    _hotSounds = [PMSimilarSubSound mj_objectArrayWithKeyValuesArray:_channel.hot_sounds];
    
    [_collectionView reloadData];
}

@end
