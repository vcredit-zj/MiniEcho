//
//  MEChannelCategoryViewController.m
//  MiniEcho
//
//  Created by 潘杨东 on 2016/11/15.
//  Copyright © 2016年 vcredit. All rights reserved.
//

// controller
#import "MEChannelCategoryViewController.h"

// view
#import "CategoryCollectionReusableView.h"
#import "MEChannelCollectionViewCell.h"


static NSString *headerID = @"headerCategoryIdentifier";
static NSString *fCellID = @"fCellIdentifier";

@interface MEChannelCategoryViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation MEChannelCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"类别";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initSubviews];
}

#pragma mark - Initilization
- (void)initSubviews
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 15.f;
    layout.minimumInteritemSpacing = 15.f;
    layout.itemSize = CGSizeMake((kScreenWidth - 30) / 2, 80);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [_collectionView registerNib:[MEChannelCollectionViewCell nib] forCellWithReuseIdentifier:fCellID];
    [_collectionView registerClass:[CategoryCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID];
    [self.view addSubview:_collectionView];        
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(0.0);
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
    }];
}

#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = (kScreenWidth - 40) / 2;
    return CGSizeMake(width, 80.f);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(0, 10, 10, 10);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(kScreenWidth, 170.f);
}

#pragma mark UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 16;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MEChannelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:fCellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor orangeColor];
    return cell;
}

#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader){
        
        CategoryCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID forIndexPath:indexPath];
        return headerView;
    } else {
    return nil;
    }
}

@end
