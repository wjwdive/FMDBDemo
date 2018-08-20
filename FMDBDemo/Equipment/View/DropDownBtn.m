//
//  DropDownBtn.m
//  FMDBDemo
//
//  Created by jiangwei.wang on 2018/8/8.
//  Copyright © 2018年 jiangwei.wang. All rights reserved.
//

#import "DropDownBtn.h"

@interface DropDownBtn()<UITableViewDelegate, UITableViewDataSource>{
    UITableView *listView;
}

@end

@implementation DropDownBtn
- (instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title List:(NSArray *)list {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        self.title = [NSString stringWithString:title];
        self.list = [NSArray arrayWithArray:list];
        [self setup];
    }
    return self;
}

-(void)configTableViewUI {
    
    CGRect frame;
    frame.origin.x = self.frame.origin.x;
    frame.origin.y = self.frame.origin.y + self.frame.size.height;
    frame.size.width = self.frame.size.width;
    frame.size.height = 0;
    listView.frame = frame;
    
}

- (void)didMoveToSuperview {
    [self.superview addSubview:listView];
}

//通过Interface Builder直接在xib中添加DropDownButton对象，需要重写awakeFromNib方法，将listView添加到同一父视图上去，这里由于xib文件缘故，self.surperview不为nil。
- (void)awakeFromNib {
    [super awakeFromNib];
    self.title = self.titleLabel.text;
    [self setup];
    [self.superview addSubview:listView];
}

- (void)clickedToDropDown {
    self.tag++;
    self.tag%2 ? [self startDropDownAnimation] : [self startPackUpAnimation];
    [listView reloadData];
}

- (void)startDropDownAnimation {
    CGRect frame = listView.frame;
    frame.origin.x = self.frame.origin.x;
    frame.origin.y = self.frame.origin.y + self.frame.size.height;
    frame.size.width = self.frame.size.width;
    frame.size.height = self.frame.size.height * self.list.count;
    [UIView animateWithDuration:0.3 animations:^{
        self->listView.frame = frame;
        [self.superview bringSubviewToFront:self];
    } completion:^(BOOL finished) {
        
    }];
}
- (void)startPackUpAnimation {
    CGRect frame = listView.frame;
    frame.origin.x = self.frame.origin.x;
    frame.origin.y = self.frame.origin.y + self.frame.size.height;
    frame.size.width = self.frame.size.width;
    frame.size.height = 0;
    [UIView animateWithDuration:0.3 animations:^{
        self->listView.frame = frame;
    } completion:^(BOOL finished){
        
    }];
}
- (void)setUpDefaultTableView {
    listView = [[UITableView alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y + self.frame.size.height, self.frame.size.width, 0) style:UITableViewStylePlain];
    listView.dataSource = self;
    listView.delegate = self;
}


#pragma mark =============== uitableview datasource ==============
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"dropBtnCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.layer.cornerRadius = 4;
    cell.textLabel.text = self.list[indexPath.row];
    cell.textLabel.font = self.titleLabel.font;
    cell.textLabel.textColor = [UIColor blackColor];
    cell.backgroundColor = [UIColor lightGrayColor];
    
    return cell;
}

#pragma mark =============== uitableview delegate ==============
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self setTitle:self.list[indexPath.row] forState:UIControlStateNormal];
    [self clickedToDropDown];
}
//- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.frame.size.height;
}


- (void)setup {
    self.layer.cornerRadius = 4;
    
    [self setTitle:self.title forState:UIControlStateNormal];
    [self setUpDefaultTableView];
    [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [self addTarget:self action:@selector(clickedToDropDown) forControlEvents:UIControlEventTouchUpInside];
}


- (void)setSelected:(BOOL)selected {
    if (selected) {
        
    }else{
        
    }
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
