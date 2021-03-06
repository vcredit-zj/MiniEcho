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

// model
#import "DataModels.h"



static NSString *headerID = @"headerCategoryIdentifier";
static NSString *fCellID = @"fCellIdentifier";

@interface MEChannelCategoryViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *categoryNameArr;

@property (nonatomic, strong) NSString *categoryData;

@property (nonatomic, strong) NSMutableArray *dataArrayM;

@end

@implementation MEChannelCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"类别";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initSubviews];
    
    _categoryData = [NSString stringWithFormat:@"%zd", (NSInteger)self.model.dataIdentifier];
    [self requestDataFromServer];
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
    [_collectionView registerNib:[MEChannelCollectionViewCell nib] forCellWithReuseIdentifier:MEChannelCollectionViewCellID];
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

    return CGSizeMake((CGRectGetWidth(self.view.frame) - 24)/2, 80 * kScreenWidth/320);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {

    return UIEdgeInsetsMake(10, 8, 0, 8);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 14.f;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 8.f;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(kScreenWidth, 170.f);
}
#pragma mark UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataArrayM.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MEChannelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MEChannelCollectionViewCellID forIndexPath:indexPath];
    cell.model = [self.dataArrayM safeObjectAtIndex:indexPath.item];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:cell.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.path = path.CGPath;
    cell.layer.mask = shapeLayer;
    return cell;
}

#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) weakSelf = self;
    if (kind == UICollectionElementKindSectionHeader){
        
        CategoryCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID forIndexPath:indexPath];
        headerView.model = self.model;
        headerView.block = ^(NSString *tag){
            weakSelf.categoryData = tag;
            [weakSelf requestDataFromServer];
        };
        return headerView;
    } else {
    return nil;
    }
}

- (void)setModel:(MEChannelCategrayData *)model
{
    _model = model;
}

#pragma mark - requestData
- (void)requestDataFromServer
{
    __weak typeof(self) weakSelf = self;
    NSDictionary *parametDic = @{@"order":@"hot",@"page ":@"1",@"tag":_categoryData,@"with_sound":@"0"};
    [MEHttpUtil get:ChannerType parameters:parametDic success:^(id result) {
        NSLog(@"~~~~~~result = %@", result);
        MEChannelHotBaseModel *baseModel = [MEChannelHotBaseModel mj_objectWithKeyValues:result];
        weakSelf.dataArrayM = [NSMutableArray arrayWithArray:baseModel.data];

        
    } failure:^(NSError *error) {
        
    }];
}

- (void)setDataArrayM:(NSMutableArray *)dataArrayM
{
    _dataArrayM = dataArrayM;
    [_collectionView reloadData];
}

@end
