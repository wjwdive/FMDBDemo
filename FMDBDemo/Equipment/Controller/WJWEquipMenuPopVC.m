//
//  WJWEquipMenuPopVC.m
//  FMDBDemo
//
//  Created by jiangwei.wang on 2018/8/8.
//  Copyright © 2018年 jiangwei.wang. All rights reserved.
//

#import "WJWEquipMenuPopVC.h"

@interface WJWEquipMenuPopVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *menuTableView;
@property (nonatomic, strong) NSMutableArray *menuItems;
@end

@implementation WJWEquipMenuPopVC

- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.menuItems = [@[@"Create equip", @"cancel"] mutableCopy];;
    self.menuTableView.delegate = self;
    self.menuTableView.dataSource = self;
    [self configUI];
}

- (void)configUI {
    
    [self.view addSubview:self.menuTableView];
    [self.menuTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}

- (void)didSelectAtIndex:(NSInteger)menuIndex {
    if ([self.delegate respondsToSelector:@selector(menuPopVC:didSelectMenuItmeAtIndex:)]) {
        [self.delegate menuPopVC:self didSelectMenuItmeAtIndex:menuIndex];
    }
}

#pragma mark =============== uitableview datasource ==============
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"menuItemCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = self.menuItems[indexPath.row];
    return cell;
}


#pragma mark =============== UITableView delegate ==============

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self didSelectAtIndex:indexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

#pragma mark =============== SETTER getter ==============
- (UITableView *)menuTableView{
    if (!_menuTableView) {
        _menuTableView = [[UITableView alloc] init];
    }
    return _menuTableView;
}

- (NSMutableArray *)menuItems{
    if (!_menuItems) {
        _menuItems = [NSMutableArray array];
    }
    return _menuItems;
}

- (CGSize)preferredContentSize {
    if (self.presentingViewController && self.view != nil) {
        CGSize size = CGSizeMake(150, 100);
        return size;
    }else {
        return [super preferredContentSize];
    }
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
