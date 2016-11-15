//
//  MEChannelViewController.m
//  MiniEcho
//
//  Created by vcredit on 16/11/11.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#import "MEChannelViewController.h"

#import "MEChannelCollectionViewCell.h"
#import "MEchannelCollectionViewAnotherCell.h"
#import "MEChannelCollectionReusableHeaderView.h"

#import "DataModels.h"
static NSString *MEChannelSupplementaryViewCellID = @"MEChannelSupplementaryViewCellID";
@interface MEChannelViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)UICollectionView *collectionView;

@property (nonatomic, strong) MEChannelCategrayBaseModel *categrayBaseModel;

@property (nonatomic,strong) NSMutableArray *dataArrayM;
@end

@implementation MEChannelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initWithSubViews];
    [self requestInitDataFromServer];

}
- (void)initWithSubViews {

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0.f;
    layout.minimumInteritemSpacing = 0.f;
    layout.itemSize = CGSizeMake(10, 10);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [collectionView registerNib:[MEChannelCollectionViewCell nib] forCellWithReuseIdentifier:MEChannelCollectionViewCellID];
    [collectionView registerNib:[MEchannelCollectionViewAnotherCell nib] forCellWithReuseIdentifier:MEchannelCollectionViewAnotherCellID];
    [collectionView registerNib:[MEChannelCollectionReusableHeaderView nib] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:MEChannelSupplementaryViewCellID];
    collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    _collectionView = collectionView;
    
    
}
#pragma mark UICollectionViewDelegateFlowLayout 
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        return CGSizeMake(CGRectGetWidth(self.view.frame), 80);
    }
    return CGSizeMake(CGRectGetWidth(self.view.frame)/2 - 30, 80);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {

    if (section == 0) {
        return UIEdgeInsetsMake(10, 0, 10, 0);
    }
    return UIEdgeInsetsMake(12, 10, 20, 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {

    return 10.f;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{

    return 10.f;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        return CGSizeMake(200, 20);
    }
    return CGSizeMake(200, 20);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {

    return CGSizeZero;
}
#pragma mark UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    if (section == 0) {
        return 1;
    }
    return [self.dataArrayM count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        MEchannelCollectionViewAnotherCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MEchannelCollectionViewAnotherCellID forIndexPath:indexPath];
        cell.dataArray = self.categrayBaseModel.data;
        
        return cell;
    }
    MEChannelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MEChannelCollectionViewCellID forIndexPath:indexPath ];
    cell.model = [self.dataArrayM safeObjectAtIndex:indexPath.item];
    cell.backgroundColor = [UIColor yellowColor];

    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:MEChannelSupplementaryViewCellID forIndexPath:indexPath];
    view.backgroundColor = [UIColor redColor];
    return view;
}
#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    NSLog(@"selected %ld",indexPath.item);
}

#pragma mark ====

- (void)requestInitDataFromServer {

    __weak typeof(self)WeakSelf = self;
    [MEHttpUtil get:ChannelCategory parameters:nil success:^(id result) {
        
        MEChannelCategrayBaseModel *baseModel = [MEChannelCategrayBaseModel modelObjectWithDictionary:result];
        WeakSelf.categrayBaseModel = baseModel;
        
    } failure:^(NSError *error) {
        
    }];
    NSDictionary *parametDic = @{@"order":@"hot",@"page ":@"1",@"with_sound":@"0"};
    [MEHttpUtil get:ChannerType parameters:parametDic success:^(id result) {
        MEChannelHotBaseModel *baseModel = [MEChannelHotBaseModel modelObjectWithDictionary:result];
        WeakSelf.dataArrayM = [NSMutableArray arrayWithArray:baseModel.data];
        
    } failure:^(NSError *error) {
        
    }];
}
- (void)setCategrayBaseModel:(MEChannelCategrayBaseModel *)categrayBaseModel {

    _categrayBaseModel = categrayBaseModel;
    [self.collectionView reloadData];
}
- (void)setDataArrayM:(NSMutableArray *)dataArrayM {

    _dataArrayM = dataArrayM;
    [self.collectionView reloadData];
}
@end
