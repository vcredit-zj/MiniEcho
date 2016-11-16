//
//  MEChannelViewController.m
//  MiniEcho
//
//  Created by vcredit on 16/11/11.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#import "MEChannelViewController.h"
#import "MEChannelCategoryViewController.h"
#import "MEPlayer.h"

#import "MEChannelSingleViewController.h"
#import "MEChannelCollectionViewCell.h"
#import "MEchannelCollectionViewAnotherCell.h"
#import "MEChannelCollectionReusableHeaderView.h"

#import "DataModels.h"
static NSString *MEChannelSupplementaryViewCellID = @"MEChannelSupplementaryViewCellID";
@interface MEChannelViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)UICollectionView *collectionView;

@property (nonatomic, strong) MEChannelCategrayBaseModel *categrayBaseModel;

@property (nonatomic,strong) NSMutableArray *dataArrayM;

/**
 最热、最新展示page
 */
@property (nonatomic, assign) NSInteger page;
@end

@implementation MEChannelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initWithSubViews];
    [self requestInitDataFromServer];

}
- (void)initWithSubViews {

    self.page = 1;
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
    __weak typeof(self)WeakSelf = self;
    collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        NSString *page = [NSString stringWithFormat:@"%ld",WeakSelf.page];
        NSDictionary *parametDic = @{@"order":@"hot",@"page ":page,@"with_sound":@"0"};
        [WeakSelf requestDataFromServerWithParameters:parametDic];
        
    }];
    _collectionView = collectionView;
    
    
}
#pragma mark UICollectionViewDelegateFlowLayout 
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        return CGSizeMake(CGRectGetWidth(self.view.frame), 80);
    }
    return CGSizeMake(CGRectGetWidth(self.view.frame)/2 - 20, 80);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {

    if (section == 0) {
        return UIEdgeInsetsMake(10, 0, 0, 0);
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
        return CGSizeMake(200, 30);
    }
    return CGSizeMake(200, 30);
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
    __weak typeof(self) weakSelf = self;
    if (indexPath.section == 0) {
        MEchannelCollectionViewAnotherCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MEchannelCollectionViewAnotherCellID forIndexPath:indexPath];
        cell.dataArray = self.categrayBaseModel.data;
        cell.callBcak = ^(MEChannelCategrayData *model){
            
            MEChannelCategoryViewController *meVC = [[MEChannelCategoryViewController alloc] init];
            meVC.model = model;
            meVC.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:meVC animated:YES];
        };
        return cell;
    }
    MEChannelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MEChannelCollectionViewCellID forIndexPath:indexPath ];
    cell.model = [self.dataArrayM safeObjectAtIndex:indexPath.item];
    cell.backgroundColor = [UIColor yellowColor];

    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

    MEChannelCollectionReusableHeaderView *view = (MEChannelCollectionReusableHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:MEChannelSupplementaryViewCellID forIndexPath:indexPath];
    for (UIView *obj in view.subviews) {
        [obj removeFromSuperview];
    }
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(10, 10, 20, 20);
    [view addSubview:imageView];
    HeaderModel *model = [[HeaderModel alloc] init];
    if (indexPath.section == 0) {
        model.imageName = @"icon_channel_category";
        model.titleArray = @[@"频道分类"];
    } else {
    
        model.imageName = @"icon_channel_follow";
        model.titleArray = @[@"最热",@"最新"];

    }
    [imageView setImage:[UIImage imageNamed:model.imageName]];
    NSInteger index = 1;
    CGFloat allX = CGRectGetMaxX(imageView.frame) + 4;
    for (NSString *title in model.titleArray) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = index;
        CGFloat titleWidth = [MEUtil widthForSingleLineText:title fontSize:12.f];
        button.frame = CGRectMake( allX, 10, titleWidth, 20);
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:12.f]];
        [button addTarget:self action:@selector(headerViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        index++;
        allX += titleWidth + 4;
    }
    return view;
}
#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    MEChannelHotData *model = [self.dataArrayM safeObjectAtIndex:indexPath.item];
    MEChannelSingleViewController *singleChannelVC = [[MEChannelSingleViewController alloc] init];
    singleChannelVC.identifi = [NSString stringWithFormat:@"%d",(int)model.dataIdentifier];
    singleChannelVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:singleChannelVC animated:YES];
    NSLog(@"selected %ld",indexPath.item);
}

#pragma mark ====

- (void)requestInitDataFromServer {

    __weak typeof(self)WeakSelf = self;
    [MEHttpUtil get:ChannelCategory parameters:nil success:^(id result) {
//        NSLog(@"result == %@", result);
        MEChannelCategrayBaseModel *baseModel = [MEChannelCategrayBaseModel modelObjectWithDictionary:result];
        WeakSelf.categrayBaseModel = baseModel;
        
    } failure:^(NSError *error) {
        
    }];
    NSString *page = [NSString stringWithFormat:@"%ld",_page];
    NSDictionary *parametDic = @{@"order":@"hot",@"page ":page,@"with_sound":@"0"};
    [self requestDataFromServerWithParameters:parametDic];
}
- (void)requestDataFromServerWithParameters:(id)parame {

    __weak typeof(self)WeakSelf = self;
    [MEHttpUtil get:ChannerType parameters:parame success:^(id result) {
        MEChannelHotBaseModel *baseModel = [MEChannelHotBaseModel modelObjectWithDictionary:result];
        if (WeakSelf.page > 1) {
            [WeakSelf.dataArrayM addObjectsFromArray:baseModel.data];
        } else {
        WeakSelf.dataArrayM = [NSMutableArray arrayWithArray:baseModel.data];
            
        }
        WeakSelf.page += 1;
        [WeakSelf.collectionView.mj_footer endRefreshing];
        [WeakSelf.collectionView reloadData];
        
        
    } failure:^(NSError *error) {
        [WeakSelf.collectionView.mj_footer endRefreshing];
    }];

}

- (void)headerViewBtnClick:(UIButton *)btn {

    NSLog(@"%ld",btn.tag);
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
