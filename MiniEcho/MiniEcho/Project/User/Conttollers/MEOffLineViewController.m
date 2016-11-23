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

#import "MEOffLineSongTableViewCell.h"

@interface MEOffLineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *mainTableView;
@property (nonatomic,strong) NSArray *dataArray;
@end

@implementation MEOffLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    RLMResults<MELocalSound *> *results = [MELocalSound allObjects];
        for (MELocalSound *localSound in results) {
            NSLog(@"%@",localSound.name);
            NSLog(@"%@",localSound.singer);
            NSLog(@"%@",localSound.source);
            LocalSoundsInfo *soundInfo = [[MESoundsDownloader shareMusicDownloader] getLocalSoundsInfo];
            
            id obj = [soundInfo.soundsInfo objectForKey:localSound.source];
            NSLog(@"%@--class= %@",obj,[obj class]);
    }
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MEOffLineSongTableViewCellID];
    return cell;
}
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

- (NSArray *)dataArray {
    
    if (!_dataArray) {
        _dataArray = @[@"",@"",@"",@""];
    }
    return _dataArray;
}

@end
