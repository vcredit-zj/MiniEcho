//
//  HotSearchResultController.m
//  MiniEcho
//
//  Created by ALittleNasty on 2016/11/25.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#import "HotSearchResultController.h"

#import "SearchResultCell.h"

static NSString *cellID = @"SearchResultCellIdentifier";

@interface HotSearchResultController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;


@property (nonatomic, copy) NSArray *dataArray;



@end

@implementation HotSearchResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [_tableView registerNib:[SearchResultCell nib] forCellReuseIdentifier:cellID];
    
    [self requestHotSearchResult];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLog(@"~~~%zd~~~",indexPath.row);
}

#pragma mark - Util

- (void)requestHotSearchResult
{
    [SVProgressHUD show];
    NSDictionary *params = @{@"keyword" : _keyword,
                             @"page" : @1,
                             @"src" : @1,
                             @"with_channel_user" : @1};
    NSString *url = @"search/sound?keyword=Faded&page=1&src=1&with_channel_user=1";
    [MEHttpUtil get:url parameters:nil success:^(id result) {
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"请求失败!"];
    }];
}

@end
