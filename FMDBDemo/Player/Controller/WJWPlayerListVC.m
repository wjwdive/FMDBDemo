//
//  WJWPlayerListVC.m
//  FMDBDemo
//
//  Created by jiangwei.wang on 2018/8/6.
//  Copyright © 2018年 jiangwei.wang. All rights reserved.
//

#import "WJWPlayerListVC.h"
#import "PlayerModel.h"
#import "PlayerModelManager.h"
#import "WJWAddPlayerPopVC.h"

@interface WJWPlayerListVC ()<UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate, WJWAddPlayerPopVCDelegate>
@property (strong, nonatomic) IBOutlet UITableView *playerTableView;
@property (nonatomic, strong) NSMutableArray *playersArrM;
@property (nonatomic, strong) PlayerModelManager *playerManager;
@property (nonatomic, assign) NSInteger dataPage;

@end

@implementation WJWPlayerListVC

static NSString *playerCellID = @"playerCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Players";
    [self loadData];
    [self customRightNavBtn];
    
    self.playerTableView.delegate = self;
    self.playerTableView.dataSource = self;
    
    self.playerTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadData)];
    self.playerTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [self.playerTableView.mj_header beginRefreshing];

    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
}

- (void)customRightNavBtn {
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
//    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame = CGRectMake(0, 0, 60, 40);
    [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)reloadData {
    [self.playersArrM removeAllObjects];
    self.playersArrM = [self.playerManager selectPlayersByCondition:nil];
    [self.playerTableView reloadData];

    [self.playerTableView.mj_header endRefreshing];
}
- (void)loadMoreData {
    [self.playerTableView.mj_footer endRefreshing];
}
- (void)addBtnClick:(id)sender {
    WJWAddPlayerPopVC *addPopVC = [[WJWAddPlayerPopVC alloc] init];
    addPopVC.delegate = self;
    
    addPopVC.modalPresentationStyle = UIModalPresentationPopover;
    addPopVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    UIPopoverPresentationController *popover = addPopVC.popoverPresentationController;
    popover.delegate = self;
    popover.sourceView = self.view;
    popover.sourceRect = self.view.frame;
    popover.permittedArrowDirections = 0;
    [self presentViewController:addPopVC animated:YES completion:nil];
    
}

- (void)loadData {
    
    self.playersArrM = [self.playerManager selectPlayersByCondition:nil];
    
}


#pragma mark =============== tableView datasource ==============
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.playersArrM.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:playerCellID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:playerCellID];
        }
    PlayerModel *model;
    model = self.playersArrM[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",model.lastName, model.firstName];
    cell.backgroundColor = [UIColor lightGrayColor];
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark =============== tableView delegate ==============
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


#pragma mark --  实现代理方法
//默认返回的是覆盖整个屏幕，需设置成UIModalPresentationNone。
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{
    return UIModalPresentationNone;
}

//点击蒙版是否消失，默认为yes；

-(BOOL)popoverPresentationControllerShouldDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{
    return YES;
}

//弹框消失时调用的方法
-(void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{
    
    NSLog(@"弹框已经消失");
    
}

#pragma mark =============== WJWAddPlayerPopVCDelegate  ==============
- (void)WJWAddPlayerPopVC:(WJWAddPlayerPopVC *)addPlayerPopVC didAddAction:(id)object {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)WJWAddPlayerPopVC:(WJWAddPlayerPopVC *)addPlayerPopVC didCancelAction:(id)object {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark =============== setter getter ==============
- (NSMutableArray *)playersArrM {
    if (!_playersArrM) {
        _playersArrM = [NSMutableArray array];
    }
    return _playersArrM;
}

- (PlayerModelManager *)playerManager {
    if (!_playerManager) {
        _playerManager = [[PlayerModelManager alloc] init];
    }
    return _playerManager;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
