//
//  PMRecommendCell.m
//  MiniEcho
//
//  Created by ALittleNasty on 16/11/15.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#import "PMRecommendCell.h"
#import "PMSoundCollectionCell.h"

static NSString *cellID = @"PMSoundCollectionCellIdentifier";

@interface PMRecommendCell ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>


@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


@end

@implementation PMRecommendCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[PMSoundCollectionCell nib] forCellWithReuseIdentifier:cellID]; 
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
    return _sounds.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat itemWidth = (kScreenWidth - 40.f) / 3;
    return CGSizeMake(itemWidth, itemWidth + 40.f);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PMSoundCollectionCell *soundCell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    soundCell.sound = _sounds[indexPath.item];
    return soundCell;
}

- (void)setSounds:(NSArray *)sounds
{
    _sounds = [PMSimilarSubSound mj_objectArrayWithKeyValuesArray:sounds];
    
    [_collectionView reloadData];
}

@end
