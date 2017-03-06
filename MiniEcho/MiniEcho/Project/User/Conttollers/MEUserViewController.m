//
//  MEUserViewController.m
//  MiniEcho
//
//  Created by vcredit on 16/11/17.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#import "MEUserViewController.h"
#import "MEOffLineViewController.h"
#import <MMDrawerController.h>
static NSString *MEUserViewCellId = @"MEUserViewControllerID";
@interface UserCellModel : NSObject
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *title;
+ (instancetype)modelWithDic:(NSDictionary<NSString * ,id> *)dic;
@end
@implementation UserCellModel
+ (instancetype)modelWithDic:(NSDictionary<NSString *,id> *)dic {
    UserCellModel *model = [[self alloc] init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}
@end


@interface MEUserViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *mainTableView;

@property (nonatomic,weak) UIImageView *headerBGImagView;

@property (nonatomic,weak) UIVisualEffectView *effectView;

@property (nonatomic,strong) NSArray *dataArray;
@end

@implementation MEUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initSubViews];
    [self requestDataFromServer];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    [self.mainTableView reloadData];
    
    
}
- (void)initSubViews {

    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 60.f;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:MEUserViewCellId];
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    _mainTableView = tableView;
    
    tableView.tableHeaderView = ({
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 300)];
        UIImageView *bgImageView = [[UIImageView alloc] init];
        bgImageView.frame = headerView.bounds;
        _headerBGImagView = bgImageView;
        [bgImageView setContentMode:UIViewContentModeScaleAspectFit];
        [bgImageView sd_setImageWithURL:[NSURL URLWithString:@"http://qn.qn-echo-image-cdn.app-echo.com/wb/3408bb2f7f2ed5943e2b6b09673d199232e97711"] placeholderImage:nil];
        [headerView addSubview:bgImageView];

        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark] ;
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        effectView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleHeight;
        effectView.frame = bgImageView.bounds;
        _effectView = effectView;
        [bgImageView addSubview:effectView];
        
        UIImageView *headImageView = [[UIImageView alloc] init];
        headImageView.layer.cornerRadius = 33;
        headImageView.clipsToBounds = YES;

        [headImageView sd_setImageWithURL:[NSURL URLWithString:@"http://al.qn-echo-image-cdn.app-echo.com/wb/3408bb2f7f2ed5943e2b6b09673d199232e97711?imageMogr2/auto-orient/quality/100%7CimageView2/0/w/250/q/100"] placeholderImage:nil];
        [headerView addSubview:headImageView];
        [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headerView).with.offset(17);
            make.bottom.equalTo(headerView).with.offset(-21);
            make.height.equalTo(@66);
            make.width.equalTo(@66);
        }];
        
        UILabel *nameLabel = [[UILabel alloc] init];
        [headerView addSubview:nameLabel];
        [nameLabel setFont:[UIFont systemFontOfSize:14.f]];
        [nameLabel setTextColor:[UIColor whiteColor]];
        nameLabel.text = @"Dr.";
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headImageView.mas_right).with.offset(7);
            make.right.equalTo(headerView);
            make.top.equalTo(headImageView).with.offset(7);
            make.height.equalTo(@15);
        }];
        
        UILabel *echoLabel = [[UILabel alloc] init];
        [headerView addSubview:echoLabel];
        [echoLabel setFont:[UIFont systemFontOfSize:12.f]];
        [echoLabel setTextColor:[UIColor whiteColor]];
        echoLabel.text = @"Just Kiss";
        [echoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headImageView.mas_right).with.offset(7);
            make.right.equalTo(headerView);
            make.top.equalTo(nameLabel.mas_bottom).with.offset(3);
            make.height.equalTo(@13);
        }];
        headerView;
    
    });
    
}
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.dataArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MEUserViewCellId];
    UserCellModel *model = [self.dataArray safeObjectAtIndex:indexPath.row];
    cell.textLabel.text = model.title;
    if (indexPath.row == 1) {
        CGFloat cacheSize = [[SDImageCache sharedImageCache] getSize] / 1024 / 1024;
        NSString *cacheTitle = cacheSize >= 1 ? [NSString stringWithFormat:@"清理缓存(%.2fM)",cacheSize] : [NSString stringWithFormat:@"清理缓存(%.2fK)",cacheSize * 1024];
        cell.textLabel.text = cacheTitle;
    }
    [cell.imageView setImage:[UIImage imageNamed:model.imageName] ];
    return cell;
}
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    __weak typeof(self)weakSelf = self;
    if (indexPath.row == 1) {
        [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
            [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
                [weakSelf.mainTableView reloadData];
            } title:@"清除缓存完成" message:nil cancelButtonName:@"确定" otherButtonTitles: nil];
        }];
    }
    if (indexPath.row == 0) {
        MEOffLineViewController *VC = [[MEOffLineViewController alloc] init];
        VC.hidesBottomBarWhenPushed = YES;
        MMDrawerController *rootVC = (MMDrawerController *)[[[UIApplication sharedApplication].delegate window] rootViewController];
        [rootVC closeDrawerAnimated:YES completion:^(BOOL finished) {
            
        }];
        UITabBarController *tabBarVC = (UITabBarController *)rootVC.centerViewController;
        
        UINavigationController *firstVC = [tabBarVC.viewControllers objectAtIndex:tabBarVC.selectedIndex];
        [firstVC pushViewController:VC animated:YES];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat y = scrollView.contentOffset.y;
    if (y > 0)return;
    CGRect oldRect = self.headerBGImagView.frame;
    oldRect.origin.y = y;
    oldRect.origin.x = y/2;
    oldRect.size.height = 300 - y;
    oldRect.size.width = CGRectGetWidth(self.view.frame) - y;
    self.headerBGImagView.frame = oldRect;
    
}
- (NSArray *)dataArray {

    if (!_dataArray) {
        UserCellModel *model0 = [UserCellModel modelWithDic:@{@"title":@"离线管理",@"imageName":@"self_offline"}];
        CGFloat cacheSize = [[SDImageCache sharedImageCache] getSize] / 1024 / 1024;
        NSString *cacheTitle = cacheSize >= 1 ? [NSString stringWithFormat:@"清理缓存(%.2fM)",cacheSize] : [NSString stringWithFormat:@"清理缓存(%.2fK)",cacheSize * 1024];
        UserCellModel *model1 = [UserCellModel modelWithDic:@{@"title":cacheTitle,@"imageName":@"self_offline"}];
        _dataArray = @[model0,model1];
    }
    return _dataArray;
}
#pragma mark Helper 
- (void)requestDataFromServer {
}
@end
