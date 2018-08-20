//
//  WJWEquipmentVC.m
//  FMDBDemo
//
//  Created by jiangwei.wang on 2018/8/6.
//  Copyright © 2018年 jiangwei.wang. All rights reserved.
//

#import "WJWEquipmentVC.h"
#import "WJWEquipCell.h"
#import "EquipmentModelManager.h"
#import "WJWEquipMenuPopVC.h"
#import "WJWCreateEquipVC.h"

@interface WJWEquipmentVC ()<UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate, WJWEquipMenuPopVCDelegate>
@property (strong, nonatomic) IBOutlet UITableView *equipmentTableView;
@property (strong, nonatomic) NSMutableArray *equipArrM;
@property (strong, nonatomic) EquipmentModelManager *equipManager;

@end

@implementation WJWEquipmentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Equipments";
    [self customRightNavBtn];
    
    
    self.equipmentTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.equipmentTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [self.equipmentTableView.mj_header beginRefreshing];
//    [self.equipmentTableView.mj_footer beginRefreshing];
    

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

- (void)loadNewData {
    [self.equipManager selectAllEquipmentByPlayerId:0];
    [self.equipmentTableView reloadData];
    [self.equipmentTableView.mj_header endRefreshing];
}

- (void)loadMoreData {
    [self.equipmentTableView.mj_footer endRefreshing];

}

- (void)addBtnClick:(id)sender {
    WJWEquipMenuPopVC *menuPopVC = [[WJWEquipMenuPopVC alloc] init];
    menuPopVC.delegate = self;
    menuPopVC.modalPresentationStyle = UIModalPresentationPopover;
    
    UIPopoverPresentationController *popover = menuPopVC.popoverPresentationController;
    popover.delegate = self;
    popover.barButtonItem = self.navigationItem.rightBarButtonItem;
//    popover.sourceRect = self.navigationItem.rightBarButtonItem.accessibilityFrame;
    [self presentViewController:menuPopVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark =============== WJWEquipMenuPopVC delegate ==============
- (void)menuPopVC:(WJWEquipMenuPopVC *)menPopVC didSelectMenuItmeAtIndex:(NSInteger)menuIndex {
    if (menuIndex == 0) {
        __weak typeof(self) weakSelf = self;
        [self dismissViewControllerAnimated:YES completion:^{
            WJWCreateEquipVC *createEquipVC = [[WJWCreateEquipVC alloc] init];
            [weakSelf.navigationController pushViewController:createEquipVC animated:YES];
        }];
    }else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}


#pragma mark =============== UITableView datasource ==============
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.equipArrM.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    WJWEquipCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [WJWEquipCell cellWithTableView:tableView];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
#pragma mark =============== UITableView delegate ==============
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark =============== UIPopoverPrensentViewController Delegate ==============
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


#pragma mark =============== setter getter ==============
- (NSMutableArray *)equipArrM {
    if (!_equipArrM) {
        _equipArrM = [NSMutableArray array];
    }
    return _equipArrM;
}

- (EquipmentModelManager *)equipManager {
    if (!_equipManager) {
        _equipManager = [[EquipmentModelManager alloc] init];
    }
    return _equipManager;
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
