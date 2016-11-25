//
//  MEOffLineViewController.m
//  MiniEcho
//
//  Created by vcredit on 2016/11/23.
//  Copyright © 2016年 vcredit. All rights reserved.
//

#import "MEOffLineViewController.h"
#import "MELocalSound.h"
#import "MESoundsDownloader.h"
#import "LocalSoundsInfo.h"
#import "MEOffLinePlayMusicController.h"
#import "MEPlayMusicController.h"
#import "MEOffLineSongTableViewCell.h"

@interface MEOffLineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *mainTableView;
@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,strong) NSMutableArray *offLineMusicData;
@end

@implementation MEOffLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initSubViews];
}

- (void)initSubViews {
    self.view.backgroundColor = [UIColor whiteColor];
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 60.f;
    [tableView registerNib:[MEOffLineSongTableViewCell nib] forCellReuseIdentifier:MEOffLineSongTableViewCellID];
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    _mainTableView = tableView;
}
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.dataArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MEOffLineSongTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MEOffLineSongTableViewCellID];
    cell.model = [self.dataArray safeObjectAtIndex:indexPath.row];
    return cell;
}
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [MEPlayer shareMEPlayer].onlineMusicData = self.offLineMusicData;
    MEOffLinePlayMusicController *playVC = [MEOffLinePlayMusicController sharePlayMusicController];
    playVC.index = indexPath.row;
    [self.navigationController pushViewController:playVC animated:YES];
}
- (NSArray *)dataArray {
    
    if (!_dataArray) {
        NSMutableArray *tempArrayM = [NSMutableArray array];
        RLMResults<MELocalSound *> *results = [MELocalSound allObjects];
        for (MELocalSound *localSound in results) {
            [tempArrayM safeAddObject:localSound];
        }
        _dataArray = [NSArray arrayWithArray:tempArrayM];

    }
    return _dataArray;
}
- (NSMutableArray *)offLineMusicData {

    if (!_offLineMusicData) {
        NSMutableArray *tempArrayM = [NSMutableArray array];
        for (MELocalSound *localSound in self.dataArray) {

            [tempArrayM safeAddObject:localSound.source];
        }
        _offLineMusicData = tempArrayM;
    }
    return _offLineMusicData;
}
@end
