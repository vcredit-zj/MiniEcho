//
//  SearchHomeController.m
//  MiniEcho
//
//  Created by ALittleNasty on 2016/11/25.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#import "SearchHomeController.h"
#import "HotSearchResultController.h"
#import "YYTag.h"
#import "SearchHotModel.h"

@interface SearchHomeController ()<YYTagListViewDelegate>


@property (nonatomic, strong) NSArray *hotTags;

@property (nonatomic, weak) YYTagListView *listView;


@end

@implementation SearchHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"搜索";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self initSubviews];
    
    [self requsetHotList];
}

- (void)initSubviews
{
    YYTagViewLayout *layout = [YYTagViewLayout layoutWithInset:UIEdgeInsetsMake(10.f, 10.f, 10.f, 10.f)
                                                    itemHeight:35.f
                                                 verticalSpace:10.f
                                               horizontalSpace:10.f];
    
    YYTagListView *tagListView = [[YYTagListView alloc] initWithFrame:self.view.bounds WithLayout:layout];
    tagListView.backgroundColor = [UIColor whiteColor];
    tagListView.tintColor = [UIColor greenColor];
    tagListView.delegate = self;
    [self.view addSubview:tagListView];
    _listView = tagListView;
}

#pragma mark - YYTagListViewDelegate

- (void)didSelectedTagAtIndex:(NSInteger)index
{
    SearchHotModel *model = self.hotTags[index];
    HotSearchResultController *hotResultVC = [[HotSearchResultController alloc] init];
    hotResultVC.keyword = model.name;
    hotResultVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:hotResultVC animated:YES];
}

#pragma mark - Util

- (void)requsetHotList
{
    __weak typeof(self) wealSelf = self;
    [SVProgressHUD show];
    [MEHttpUtil get:SearchHotList parameters:nil success:^(id result) {
        [SVProgressHUD dismiss];
        DLog(@"%@",result);
        wealSelf.hotTags = [SearchHotModel mj_objectArrayWithKeyValuesArray:result[@"data"]];
        [wealSelf dealHotTags];
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
}

- (void)dealHotTags
{
    NSMutableArray *array = [NSMutableArray array];
    
    for (SearchHotModel *model in self.hotTags) {
        [array addObject:model.name];
    }
    
    [self.listView addYYTags:[array copy]];
}

@end
