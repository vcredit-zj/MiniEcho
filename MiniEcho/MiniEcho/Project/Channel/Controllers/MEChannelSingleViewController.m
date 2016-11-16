//
//  MEChannelSingleViewController.m
//  MiniEcho
//
//  Created by vcredit on 16/11/16.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#import "MEChannelSingleViewController.h"

#import "MESingleChannelCollectionCell.h"

#import "MEPlayMusicController.h"
#import "DataModels.h"
@interface MEChannelSingleViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)UICollectionView *collectionView;

@property (nonatomic,strong) NSMutableArray *dataArrayM;
@end

@implementation MEChannelSingleViewController

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
    [collectionView registerNib:[MESingleChannelCollectionCell nib] forCellWithReuseIdentifier:MESingleChannelCollectionCellID];
//    [collectionView registerNib:[MEchannelCollectionViewAnotherCell nib] forCellWithReuseIdentifier:MEchannelCollectionViewAnotherCellID];
//    [collectionView registerNib:[MEChannelCollectionReusableHeaderView nib] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:MEChannelSupplementaryViewCellID];
    collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

    _collectionView = collectionView;
    
    
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
    

    return CGSizeMake(200, 20);
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
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    
//    MEChannelCollectionReusableHeaderView *view = (MEChannelCollectionReusableHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:MEChannelSupplementaryViewCellID forIndexPath:indexPath];
//    for (UIView *obj in view.subviews) {
//        [obj removeFromSuperview];
//    }
//    UIImageView *imageView = [[UIImageView alloc] init];
//    imageView.frame = CGRectMake(10, 0, 20, 20);
//    [view addSubview:imageView];
//    HeaderModel *model = [[HeaderModel alloc] init];
//    if (indexPath.section == 0) {
//        model.imageName = @"icon_channel_category";
//        model.titleArray = @[@"频道分类"];
//    } else {
//        
//        model.imageName = @"icon_channel_follow";
//        model.titleArray = @[@"最热",@"最新"];
//        
//    }
//    [imageView setImage:[UIImage imageNamed:model.imageName]];
//    NSInteger index = 1;
//    CGFloat allX = CGRectGetMaxX(imageView.frame) + 4;
//    for (NSString *title in model.titleArray) {
//        UIButton *button = [[UIButton alloc] init];
//        button.tag = index;
//        CGFloat titleWidth = [MEUtil widthForSingleLineText:title fontSize:12.f];
//        button.frame = CGRectMake( allX, 0, titleWidth, 20);
//        [button setTitle:title forState:UIControlStateNormal];
//        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [button.titleLabel setFont:[UIFont systemFontOfSize:12.f]];
//        [button addTarget:self action:@selector(headerViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//        [view addSubview:button];
//        index++;
//        allX += titleWidth + 4;
//    }
//    return view;
//}
#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"selected %ld",indexPath.item);
    MESingleChannelSounds *model = [self.dataArrayM safeObjectAtIndex:indexPath.item];
    MEPlayMusicController *playVC = [[MEPlayMusicController alloc] init];
    playVC.index = [model.soundsIdentifier integerValue];
    playVC.isLocal = NO;
    [self.navigationController pushViewController:playVC animated:YES];
    
}

- (void)requestInitDataFromServer {
    
    __weak typeof(self)WeakSelf = self;
    //id: 1155, page : 1, list_order : recommend , limit : 20
    NSDictionary *parametDic = @{@"id":_identifi,@"page ":@"1",@"list_order":@"recommend",@"with_sound":@"0"};
    [MEHttpUtil get:ChannerInfo parameters:parametDic success:^(id result) {

        MESingleChannelBaseModel *baseModel = [MESingleChannelBaseModel modelObjectWithDictionary:result];
        WeakSelf.dataArrayM = [NSMutableArray arrayWithArray:baseModel.data.sounds];

        [WeakSelf.collectionView reloadData];
    } failure:^(NSError *error) {
        
    }];

}

@end
