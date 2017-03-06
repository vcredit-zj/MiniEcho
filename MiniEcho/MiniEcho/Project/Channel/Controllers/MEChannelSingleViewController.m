//
//  MEChannelSingleViewController.m
//  MiniEcho
//
//  Created by vcredit on 16/11/16.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#import "MEChannelSingleViewController.h"
#import "MEOffLineViewController.h"
#import "MEPlayMusicController.h"

#import "MESingleChannelCollectionCell.h"
#import "MEPlayer.h"

#import "DataModels.h"

static NSString *MEChannelSupplementaryViewCellID = @"MEChannelSupplementaryViewCellID";
static NSInteger backBtnTag = 110;
static NSInteger rightBtnTag = 120;
static NSInteger centerLabelTag = 111;
static CGFloat headerImageHeight = 270 ;

@interface BottomBtnModel : NSObject
@property (nonatomic,copy) NSString *title;
@property (nonatomic,assign) NSInteger tag;
@property (nonatomic,copy) NSString *order;
+ (instancetype)modelWithDic:(NSDictionary<NSString *, id> *)dic;
@end
@implementation BottomBtnModel
+ (instancetype)modelWithDic:(NSDictionary<NSString *, id> *)dic {
    BottomBtnModel *model = [[BottomBtnModel alloc] init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}
@end


@interface MEChannelSingleViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)UICollectionView *collectionView;

@property (nonatomic,strong) NSMutableArray *dataArrayM;

@property (nonatomic,strong) UIView *topNavigationBar;

@property (nonatomic,strong) UIImageView *topImageView;

@property (nonatomic,strong) UIView *bottomView;

@property (nonatomic,strong) NSArray<BottomBtnModel *> *bottomBtnModelArray;

@property (nonatomic,copy) NSString *order;
/**
 最热、最新展示page
 */
@property (nonatomic, assign) NSInteger page;
//滑动结束Y
@property (nonatomic, assign) CGFloat oldContentOffsetY;
//滑动开始Y
@property (nonatomic, assign) CGFloat newContentOffsetY;
@end

@implementation MEChannelSingleViewController
#pragma mark ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.page = 1;
    self.order = @"recommend";
    self.navigationController.fd_fullscreenPopGestureRecognizer.enabled = NO;
    [self initWithSubViews];
    [self requestInitDataFromServer];
}
- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
#pragma mark INIT
- (void)initWithSubViews {
    __weak typeof(self)weakSelf = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
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

    collectionView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        NSString *page = [NSString stringWithFormat:@"%ld",weakSelf.page];
        NSDictionary *dic = @{@"id":weakSelf.identifi,@"page":page,@"list_order":weakSelf.order,@"with_sound":@"0"};
        [weakSelf requestDataFromServerWithParameters:dic];
    }];
    _collectionView = collectionView;
    
    UIView *topNavBar = [[UIView alloc] init];
    topNavBar.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 64);
    topNavBar.backgroundColor = [UIColor clearColor];
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
        make.left.equalTo(topNavBar).with.offset(15);
        make.centerY.equalTo(centerLabel);
        make.height.equalTo(@25);
        make.width.equalTo(@14);
    }];
    UIButton *rightBtn = [[UIButton alloc] init];
    rightBtn.tag = rightBtnTag;
    [rightBtn setImage:[UIImage imageNamed:@"disk_w"] forState:UIControlStateNormal];
    [rightBtn addActionHandler:^(NSInteger tag) {
        MEOffLineViewController *offLineVC = [[MEOffLineViewController alloc] init];
        [weakSelf.navigationController pushViewController:offLineVC animated:YES];
    }];
    [topNavBar addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(topNavBar).with.offset(-15);
        make.centerY.equalTo(centerLabel);
        make.height.equalTo(@25);
        make.width.equalTo(@25);
    }];
    _topNavigationBar = topNavBar;
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.height.equalTo(@49);
    }];
    
    CGFloat btnWidth = kScreenWidth/3;
    NSInteger index = 0;
    for (BottomBtnModel *model in self.bottomBtnModelArray) {
        UIButton *bottomBtn = [[UIButton alloc] init];
        bottomBtn.tag = model.tag;
        bottomBtn.selected = index == 0 ? YES:NO;
        [bottomBtn setTitle:model.title forState:UIControlStateNormal];
        [bottomBtn setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
        [bottomBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [bottomBtn.titleLabel setFont:[UIFont systemFontOfSize:14.f]];
        [bottomBtn addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:bottomBtn];
        [bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bottomView).with.offset(btnWidth*index);
            make.bottom.equalTo(bottomView);
            make.top.equalTo(bottomView).with.offset(0);
            make.width.equalTo(@(btnWidth));
        }];
        index++;
    }
    _bottomView = bottomView;
}
#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    return CGSizeMake((CGRectGetWidth(self.view.frame) - 30)/2, CGRectGetWidth(self.view.frame)/2+20);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {

    return UIEdgeInsetsMake(10, 10, 0, 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 10.f;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 10.f;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    

    return CGSizeMake(CGRectGetWidth(self.view.frame), headerImageHeight* kScreenWidth/320.0);
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
    if (!self.topImageView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView setContentMode:UIViewContentModeScaleAspectFill];
        imageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), headerImageHeight* kScreenWidth/320.0);
        [view addSubview:imageView];
        imageView.backgroundColor = [UIColor yellowColor];
        self.topImageView = imageView;
    }
    
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
#pragma mark UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

    self.newContentOffsetY = scrollView.contentOffset.y;
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGFloat currentContentOffsetY = scrollView.contentOffset.y;
    if (currentContentOffsetY > _oldContentOffsetY && _oldContentOffsetY > _newContentOffsetY) { // 向上滚动
        
    } else if (currentContentOffsetY < _oldContentOffsetY && _oldContentOffsetY < _newContentOffsetY) {// 向下滚动

    } else {

    }
    if (scrollView.dragging) { // 拖拽

        if ((scrollView.contentOffset.y - _newContentOffsetY) > 15.0f) {
            // 向上拖拽
            self.bottomView.alpha = 0;
            // 隐藏
        }
        else if ((_newContentOffsetY - scrollView.contentOffset.y) > 15.0f)
        {   // 向下拖拽
            // 显示
            self.bottomView.alpha = 1;
        } else {
            self.bottomView.alpha = (_newContentOffsetY - scrollView.contentOffset.y) / 15;
        }
    }
    CGFloat y = scrollView.contentOffset.y;
    if (y > 0)return;
    CGRect oldRect = self.topImageView.frame;
    oldRect.origin.y = y;
    oldRect.origin.x = y/2;
    oldRect.size.height = headerImageHeight* kScreenWidth/320.0 -y;
    oldRect.size.width = CGRectGetWidth(self.view.frame) - y;
    self.topImageView.frame = oldRect;
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    self.oldContentOffsetY = scrollView.contentOffset.y;
    NSLog(@"end");
}
#pragma mark ButtonAction
- (void)bottomBtnClick:(UIButton *)sender {

    self.page = 1;
    for (BottomBtnModel *model in self.bottomBtnModelArray) {
        UIView *subView = [self.bottomView viewWithTag:model.tag];
        if ([subView isKindOfClass:[UIButton class] ]) {
            UIButton *btn = (UIButton *)subView;
            btn.selected = NO;
        }
        if (model.tag == sender.tag) {
            sender.selected = YES;
            self.order = model.order;
            NSString *page = [NSString stringWithFormat:@"%ld",_page];
            NSDictionary *dic = @{@"id":_identifi,@"page":page,@"list_order":model.order,@"with_sound":@"0"};
            [self requestDataFromServerWithParameters:dic];
        }
    }
    
}
#pragma mark Helper
- (void)requestInitDataFromServer {
    
    __weak typeof(self)WeakSelf = self;
    NSDictionary *parametDic = @{@"id":_identifi,@"page":@"1",@"list_order":@"recommend",@"with_sound":@"0"};
    [MEHttpUtil get:ChannerInfo parameters:parametDic showLoading:YES success:^(id result) {
        MESingleChannelBaseModel *baseModel = [MESingleChannelBaseModel mj_objectWithKeyValues:result];
        WeakSelf.dataArrayM = [NSMutableArray arrayWithArray:baseModel.data.sounds];
        UILabel *centerLabel = [WeakSelf.topNavigationBar viewWithTag:centerLabelTag];
        [centerLabel setText:[baseModel.data.channel name] ];
        [WeakSelf.topImageView sd_setImageWithURL:[NSURL URLWithString:baseModel.data.channel.pic_640] placeholderImage:nil];
        [WeakSelf.collectionView reloadData];
    } failure:^(NSError *error) {
        
    }];

}
- (void)requestDataFromServerWithParameters:(id)parame {
    
    __weak typeof(self)WeakSelf = self;
    [MEHttpUtil get:ChannerInfo parameters:parame showLoading:YES success:^(id result) {
        MESingleChannelBaseModel *baseModel = [MESingleChannelBaseModel mj_objectWithKeyValues:result];
        if (WeakSelf.page > 1) {
            [WeakSelf.dataArrayM addObjectsFromArray:[NSMutableArray arrayWithArray:baseModel.data.sounds] ];
        } else {
        
            WeakSelf.dataArrayM = [NSMutableArray arrayWithArray:baseModel.data.sounds];
        }
        WeakSelf.page ++;
        [WeakSelf.collectionView.mj_footer endRefreshing];
        [WeakSelf.collectionView reloadData];
    } failure:^(NSError *error) {
        [WeakSelf.collectionView.mj_footer endRefreshing];
    }];
}
#pragma mark Lazy Inint
- (NSArray<BottomBtnModel *> *)bottomBtnModelArray {

    if (!_bottomBtnModelArray) {
        BottomBtnModel *model0 = [BottomBtnModel modelWithDic:@{@"title":@"推荐",@"tag":@(10),@"order":@"recommend"}];
        BottomBtnModel *model1 = [BottomBtnModel modelWithDic:@{@"title":@"最热",@"tag":@(11),@"order":@"hot"}];
        BottomBtnModel *model2 = [BottomBtnModel modelWithDic:@{@"title":@"最新",@"tag":@(12),@"order":@"new"}];
        _bottomBtnModelArray = @[model0,model1,model2];
    }
    return _bottomBtnModelArray;
}
@end
