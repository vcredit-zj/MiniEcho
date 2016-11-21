//
//  MEUserViewController.m
//  MiniEcho
//
//  Created by vcredit on 16/11/17.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#import "MEUserViewController.h"

@interface MEUserViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *mainTableView;

@property (nonatomic,weak) UIImageView *headerBGImagView;

@property (nonatomic,weak) UIVisualEffectView *effectView;
@end

@implementation MEUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initSubViews];
    [self requestDataFromServer];
}
- (void)initSubViews {

    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 60.f;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    _mainTableView = tableView;
    
    tableView.tableHeaderView = ({
    //http://al.qn-echo-image-cdn.app-echo.com/wb/3408bb2f7f2ed5943e2b6b09673d199232e97711?imageMogr2/auto-orient/quality/100%7CimageView2/0/w/250/q/100
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 300)];
        UIImageView *bgImageView = [[UIImageView alloc] init];
        bgImageView.frame = headerView.bounds;
        _headerBGImagView = bgImageView;
        [bgImageView setContentMode:UIViewContentModeScaleAspectFit];
        [bgImageView sd_setImageWithURL:[NSURL URLWithString:@"http://qn.qn-echo-image-cdn.app-echo.com/wb/3408bb2f7f2ed5943e2b6b09673d199232e97711"] placeholderImage:nil];
        [headerView addSubview:bgImageView];

        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark] ;
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        effectView.frame = bgImageView.bounds;
        _effectView = effectView;
        [bgImageView addSubview:effectView];
        headerView;
    
    });
    
}
#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = @"test";
    return cell;
}
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 0;
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
    self.effectView.frame = CGRectMake(0, 0, CGRectGetWidth(oldRect), CGRectGetHeight(oldRect));
    
}
#pragma mark Helper 
- (void)requestDataFromServer {

    NSDictionary *parame = @{@"user_id":@"19814940"};
    [MEHttpUtil get:UserInfo parameters:parame showLoading:NO success:^(id result) {
        NSLog(@"%@",result);
    } failure:^(NSError *error) {
        DLog(@"%@",error.localizedDescription);
    }];
}
@end
