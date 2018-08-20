//
//  WJWAddPlayerPopVC.m
//  FMDBDemo
//
//  Created by jiangwei.wang on 2018/8/7.
//  Copyright © 2018年 jiangwei.wang. All rights reserved.
//

#import "WJWAddPlayerPopVC.h"
#import "PlayerModelManager.h"

@interface WJWAddPlayerPopVC ()<UITextFieldDelegate>
@property (nonatomic, strong) PlayerModelManager *dbManager;
@property (nonatomic, strong) UITextField *firstNameTF;
@property (nonatomic, strong) UITextField *lastNameTF;
@property (nonatomic, strong) UITextField *emailTF;

@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *commitBtn;

@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, copy) NSString *email;




@end

@implementation WJWAddPlayerPopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dbManager = [[PlayerModelManager alloc] init];
    [self configUI];
    
    self.commitBtn.enabled = NO;
}

- (void)configUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITextField *firstNameTF = [[UITextField alloc] init];
    firstNameTF.placeholder = @"firstName";
    firstNameTF.layer.cornerRadius = 4;
    firstNameTF.layer.borderColor = [UIColor lightGrayColor].CGColor;
    firstNameTF.layer.borderWidth = 1;
    
    //设置 placeholder 的格式
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor grayColor];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    NSAttributedString *attribute = [[NSAttributedString alloc] initWithString:firstNameTF.placeholder attributes:dict];
    [firstNameTF setAttributedPlaceholder:attribute];
    firstNameTF.delegate = self;
    self.firstNameTF = firstNameTF;
    [self.view addSubview:self.firstNameTF];
    
    UITextField *lastNameTF = [[UITextField alloc] init];
    lastNameTF.placeholder = @"lastName";
    lastNameTF.layer.cornerRadius = 4;
    lastNameTF.layer.borderColor = [UIColor lightGrayColor].CGColor;
    lastNameTF.layer.borderWidth = 1;
     NSAttributedString *attribute1 = [[NSAttributedString alloc] initWithString:lastNameTF.placeholder attributes:dict];
    [lastNameTF setAttributedPlaceholder:attribute1];
    lastNameTF.delegate = self;

    self.lastNameTF = lastNameTF;
    [self.view addSubview:self.lastNameTF];
    
    UITextField *emailTF = [[UITextField alloc] init];
    emailTF.placeholder = @"email";
    emailTF.layer.cornerRadius = 4;
    emailTF.layer.borderColor = [UIColor lightGrayColor].CGColor;
    emailTF.layer.borderWidth = 1;
    NSAttributedString *attribute2 = [[NSAttributedString alloc] initWithString:emailTF.placeholder attributes:dict];

    [emailTF setAttributedPlaceholder:attribute2];
    emailTF.delegate = self;
    self.emailTF = emailTF;
    [self.view addSubview:self.emailTF];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.imageView.frame = cancelBtn.frame;
    cancelBtn.layer.cornerRadius = 25;
    cancelBtn.layer.masksToBounds = YES;
    [cancelBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    NSString *path = [[NSBundle mainBundle]pathForResource:@"btnHightlight"ofType:@"png"];
    NSString *path1 = [[NSBundle mainBundle]pathForResource:@"btnNormal"ofType:@"png"];

//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:path]];
    [cancelBtn setBackgroundImage:[UIImage imageWithContentsOfFile:path] forState:UIControlStateHighlighted];
    [cancelBtn setBackgroundImage:[UIImage imageWithContentsOfFile:path1] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtnAction:) forControlEvents:UIControlEventTouchUpInside];

    self.cancelBtn  = cancelBtn;
    [self.view addSubview:self.cancelBtn];

    
    UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commitBtn.imageView.frame = commitBtn.frame;
    commitBtn.imageView.layer.cornerRadius = 4;
    commitBtn.imageView.layer.masksToBounds = YES;
    //    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:path]];
    [commitBtn setBackgroundImage:[UIImage imageWithContentsOfFile:path] forState:UIControlStateHighlighted];
    [commitBtn setBackgroundImage:[UIImage imageWithContentsOfFile:path1] forState:UIControlStateNormal];

    [commitBtn setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
//    [commitBtn setBackgroundColor:[UIColor lightGrayColor]];
    [commitBtn addTarget:self action:@selector(addBtnAction:) forControlEvents:UIControlEventTouchUpInside];

    self.commitBtn  = commitBtn;
    [self.view addSubview:self.commitBtn];
    
    
    [self.firstNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(70);
        make.left.equalTo(self.view).offset(50);
        make.right.equalTo(self.view).offset(-50);
        make.height.mas_equalTo(50);
    }];
    
    [self.lastNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstNameTF.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset(50);
        make.right.equalTo(self.view).offset(-50);
        make.height.mas_equalTo(50);
    }];
    
    [self.emailTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lastNameTF.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset(50);
        make.right.equalTo(self.view).offset(-50);
        make.height.mas_equalTo(50);
    }];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-10);
        make.height.width.mas_equalTo(50);
    }];
    
    [self.commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.emailTF.mas_bottom).offset(50);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(200);

    }];
    
}

#pragma mark =============== uitextFiled Delegate ==============
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([textField isEqual:_firstNameTF]) {
        self.firstName = _firstNameTF.text;
    }
    
    if ([textField isEqual:_lastNameTF]) {
        self.lastName = _lastNameTF.text;
    }
    
    if ([textField isEqual:_emailTF]) {
        self.email = _emailTF.text;
    }
    
    if (self.firstName.length != 0 && self.lastName.length != 0) {
        self.commitBtn.enabled = YES;
    }else {
        self.commitBtn.enabled = NO;
    }
    
}


- (void)cancelBtnAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(WJWAddPlayerPopVC:didCancelAction:)]) {
        [self.delegate WJWAddPlayerPopVC:self didCancelAction:nil];
    }
}

- (void)addBtnAction:(id)sender {
    
    PlayerModel *model = [[PlayerModel alloc] init];
    model.firstName = self.firstName;
    model.lastName = self.lastName;
    model.email = self.email;
    model.createTime = [NSDate date];
    model.updateTime = [NSDate date];
    model.status = 0;
    
    BOOL flag = NO;
    flag = [self.dbManager addNewPlayer:model];
    if (flag) {
         DDLogDebug(@"insert success!");
        if ([self.delegate respondsToSelector:@selector(WJWAddPlayerPopVC:didAddAction:)]) {
            [self.delegate WJWAddPlayerPopVC:self didAddAction:nil];
        }
    }else {
        DDLogDebug(@"insert failure!");
    }
    
}

- (CGSize)preferredContentSize {
    if (self.presentingViewController && self.view != nil) {
        CGSize size = CGSizeMake(kScreenW, kScreenH - 200);
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
