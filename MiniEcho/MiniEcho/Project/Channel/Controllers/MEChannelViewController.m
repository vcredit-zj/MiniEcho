//
//  MEChannelViewController.m
//  MiniEcho
//
//  Created by vcredit on 16/11/11.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#import "MEChannelViewController.h"
#import "MEChannelCategoryViewController.h"
#import "MEChannelSingleViewController.h"

#import "MEPlayer.h"
#import "MERefreshHeader.h"

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

/**
 标示选择最热/最新分类
 */
@property (nonatomic, assign, getter=isSelectedNew) BOOL selectedNew;
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
    [collectionView registerClass:[MEChannelCollectionReusableHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:MEChannelSupplementaryViewCellID];
//    [collectionView registerNib:[MEChannelCollectionReusableHeaderView nib] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:MEChannelSupplementaryViewCellID];
    collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    __weak typeof(self)WeakSelf = self;
    collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        NSString *page = [NSString stringWithFormat:@"%ld",WeakSelf.page];
        NSString *order = WeakSelf.selectedNew?@"new":@"hot";
        NSDictionary *parametDic = @{@"order":order,@"page":page,@"with_sound":@"0"};
        [WeakSelf requestDataFromServerWithParameters:parametDic];
        
    }];
    collectionView.mj_header = [MERefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    _collectionView = collectionView;
}
- (void)headerRefresh {

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.collectionView.mj_header endRefreshing];
    });

}
#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        return CGSizeMake(CGRectGetWidth(self.view.frame), 80);
    }
    return CGSizeMake((CGRectGetWidth(self.view.frame) - 24)/2, 80 * kScreenWidth/320);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {

    if (section == 0) {
        return UIEdgeInsetsMake(15, 0, 0, 0);
    }
    return UIEdgeInsetsMake(20, 8, 0, 8);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {

    return 14.f;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{

    return 8.f;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        return CGSizeMake(kScreenWidth, 30);
    }
    return CGSizeMake(kScreenWidth, 30);
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

    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:cell.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.path = path.CGPath;
    cell.layer.mask = shapeLayer;
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

    __weak typeof(self)weakSelf = self;
    if (kind == UICollectionElementKindSectionHeader) {
        MEChannelCollectionReusableHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:MEChannelSupplementaryViewCellID forIndexPath:indexPath];
        view.model = nil;
        view.callBlock = nil;
        HeaderModel *model = [[HeaderModel alloc] init];
        if (indexPath.section == 0) {
            model.imageName = @"icon_channel_category";
            model.titleArray = @[@"频道分类"];
        } else {
            
            model.imageName = @"icon_channel_follow";
            model.titleArray = @[@"最热",@"最新"];
            
        }
        view.model = model;
        view.callBlock = ^(NSInteger tag){
        
            if (indexPath.section == 1) {
                weakSelf.selectedNew = tag;
            }
        };
        
        return view;
    }
    return nil;
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
    NSDictionary *parametDic = @{@"order":@"hot",@"page":page,@"with_sound":@"0"};
    [self requestDataFromServerWithParameters:parametDic];
}
- (void)requestDataFromServerWithParameters:(id)parame {

    __weak typeof(self)WeakSelf = self;
    [MEHttpUtil get:ChannerType parameters:parame showLoading:YES success:^(id result) {
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
- (void)setCategrayBaseModel:(MEChannelCategrayBaseModel *)categrayBaseModel {

    _categrayBaseModel = categrayBaseModel;
    [self.collectionView reloadData];
}
- (void)setDataArrayM:(NSMutableArray *)dataArrayM {

    _dataArrayM = dataArrayM;
    [self.collectionView reloadData];
}
- (void)setSelectedNew:(BOOL)selectedNew {

    if (self.isSelectedNew == selectedNew) return;
    _selectedNew = selectedNew;
    _page = 1;
    NSString *page = [NSString stringWithFormat:@"%ld",_page];
    NSString *order = selectedNew?@"new":@"hot";
    NSDictionary *parametDic = @{@"order":order,@"page ":page,@"with_sound":@"0"};
    [self requestDataFromServerWithParameters:parametDic];
}
@end
