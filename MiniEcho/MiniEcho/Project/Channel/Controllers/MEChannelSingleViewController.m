//
//  MEChannelSingleViewController.m
//  MiniEcho
//
//  Created by vcredit on 16/11/16.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#import "MEChannelSingleViewController.h"

#import "MESingleChannelCollectionCell.h"
#import "MEPlayer.h"
#import "MEPlayMusicController.h"
#import "DataModels.h"
static NSString *MEChannelSupplementaryViewCellID = @"MEChannelSupplementaryViewCellID";
static NSInteger backBtnTag = 110;
static NSInteger rightBtnTag = 120;
static NSInteger centerLabelTag = 111;
@interface MEChannelSingleViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)UICollectionView *collectionView;

@property (nonatomic,strong) NSMutableArray *dataArrayM;

@property (nonatomic,strong) UIView *topNavigationBar;
@end

@implementation MEChannelSingleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initWithSubViews];
    [self requestInitDataFromServer];
    self.navigationController.navigationBar.hidden = YES;
    
}
- (void)viewWillDisappear:(BOOL)animated {

    self.navigationController.navigationBar.hidden = NO;
}
- (void)initWithSubViews {
    __weak typeof(self)weakSelf = self;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0.f;
    layout.minimumInteritemSpacing = 0.f;
    layout.itemSize = CGSizeMake(10, 10);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [collectionView registerNib:[MESingleChannelCollectionCell nib] forCellWithReuseIdentifier:MESingleChannelCollectionCellID];
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:MEChannelSupplementaryViewCellID];
    collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

    _collectionView = collectionView;
    
    UIView *topNavBar = [[UIView alloc] init];
    topNavBar.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 64);
    topNavBar.backgroundColor = [UIColor redColor];
    [self.view addSubview:topNavBar];
    UILabel *centerLabel = [[UILabel alloc] init];
    [centerLabel setTextColor:[UIColor whiteColor]];
    [centerLabel setTextAlignment:NSTextAlignmentCenter];
    centerLabel.tag = centerLabelTag;
    [topNavBar addSubview:centerLabel];
    [centerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(topNavBar.mas_bottom);
        make.centerX.equalTo(topNavBar);
        make.height.equalTo(@34);
        make.width.equalTo(@200);
    }];
    UIButton *BackBtn = [[UIButton alloc] init];
    BackBtn.tag = backBtnTag;
    [BackBtn setImage:[UIImage imageNamed:@"back_white"] forState:UIControlStateNormal];
    [BackBtn addActionHandler:^(NSInteger tag) {
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [topNavBar addSubview:BackBtn];
    [BackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topNavBar).with.offset(5);
        make.bottom.equalTo(topNavBar.mas_bottom);
        make.height.equalTo(@30);
        make.width.equalTo(@30);
    }];
    UIButton *rightBtn = [[UIButton alloc] init];
    rightBtn.tag = rightBtnTag;
    [rightBtn setImage:[UIImage imageNamed:@"back_white"] forState:UIControlStateNormal];
    [rightBtn addActionHandler:^(NSInteger tag) {
        NSLog(@"rightBtnclick");
    }];
    [topNavBar addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(topNavBar).with.offset(-5);
        make.bottom.equalTo(topNavBar.mas_bottom);
        make.height.equalTo(@30);
        make.width.equalTo(@30);
    }];

    _topNavigationBar = topNavBar;
}
#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    return CGSizeMake(CGRectGetWidth(self.view.frame)/2 - 20, CGRectGetWidth(self.view.frame)/2+20);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {

    return UIEdgeInsetsMake(12, 10, 20, 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 10.f;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 10.f;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    

    return CGSizeMake(CGRectGetWidth(self.view.frame), 200);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    
    return CGSizeZero;
}
#pragma mark UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return [self.dataArrayM count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    

    MESingleChannelCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MESingleChannelCollectionCellID forIndexPath:indexPath ];
    cell.model = [self.dataArrayM safeObjectAtIndex:indexPath.item];
    cell.backgroundColor = [UIColor yellowColor];
    
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:MEChannelSupplementaryViewCellID forIndexPath:indexPath];
    for (UIView *obj in view.subviews) {
        [obj removeFromSuperview];
    }
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 200);
    [view addSubview:imageView];
    imageView.backgroundColor = [UIColor yellowColor];
    
    return view;
}
#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"selected %ld",indexPath.item);
    NSMutableArray *soundsIDArrayM = [NSMutableArray array];
    for (MESingleChannelSounds *soundModel in self.dataArrayM) {
        [soundsIDArrayM safeAddObject:soundModel.soundsIdentifier];
    }
    [MEPlayer shareMEPlayer].onlineMusicData = soundsIDArrayM;
    MEPlayMusicController *playVC = [[MEPlayMusicController alloc] init];
    playVC.index = indexPath.item;
    playVC.isLocal = NO;
    [self.navigationController pushViewController:playVC animated:YES];
    
}
#pragma mark Helper
- (void)requestInitDataFromServer {
    
    __weak typeof(self)WeakSelf = self;
    NSDictionary *parametDic = @{@"id":_identifi,@"page ":@"1",@"list_order":@"recommend",@"with_sound":@"0"};
    [MEHttpUtil get:ChannerInfo parameters:parametDic success:^(id result) {

        MESingleChannelBaseModel *baseModel = [MESingleChannelBaseModel modelObjectWithDictionary:result];
        WeakSelf.dataArrayM = [NSMutableArray arrayWithArray:baseModel.data.sounds];
        UILabel *centerLabel = [WeakSelf.topNavigationBar viewWithTag:centerLabelTag];
        [centerLabel setText:[baseModel.data.channel name] ];
        [WeakSelf.collectionView reloadData];
    } failure:^(NSError *error) {
        
    }];

}

@end
