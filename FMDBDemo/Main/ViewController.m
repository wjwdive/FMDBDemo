//
//  ViewController.m
//  FMDBDemo
//
//  Created by jiangwei.wang on 2018/8/6.
//  Copyright © 2018年 jiangwei.wang. All rights reserved.
//

#import "ViewController.h"
#import "WJWPlayerListVC.h"
#import "WJWEquipmentVC.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *menuTableView;
@property (nonatomic, copy) NSArray *menuArr;

@end

@implementation ViewController

static NSString *cellID = @"cellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.menuTableView.delegate = self;
    self.menuTableView.dataSource = self;
    self.menuArr = @[@"player",@"equipments"];
    
    [self.menuTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    
}

#pragma mark =============== tableView datasource ==============
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
//    }
    cell.textLabel.text = self.menuArr[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark =============== tableView delegate ==============
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        WJWPlayerListVC *playerListVC = [[WJWPlayerListVC alloc] init];
        [self.navigationController pushViewController:playerListVC animated:YES];
    }else {
        WJWEquipmentVC *equipVC = [[WJWEquipmentVC alloc] init];
         [self.navigationController pushViewController:equipVC animated:YES];
    }
    
}


#pragma mark =============== setter getter ==============
-(NSArray *)menuArr {
    if (!_menuArr) {
        _menuArr = [NSArray array];
    }
    return _menuArr;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
