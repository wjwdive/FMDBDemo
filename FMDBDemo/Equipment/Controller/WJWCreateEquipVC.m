//
//  WJWCreateEquipVC.m
//  FMDBDemo
//
//  Created by jiangwei.wang on 2018/8/8.
//  Copyright © 2018年 jiangwei.wang. All rights reserved.
//

#import "WJWCreateEquipVC.h"
#import "DropDownBtn.h"
#import "EquipmentModel.h"

@interface WJWCreateEquipVC ()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *numLabel;

@property (nonatomic, strong) DropDownBtn *typeBtn;
@property (nonatomic, strong) UITextField *nameTF;
@property (nonatomic, strong) UITextField *numTF;

@property (nonatomic, strong) UIButton *commitBtn;

@property (nonatomic, strong) EquipmentModel *equipModel;


@end


@implementation WJWCreateEquipVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
    [self configDropBtnFrame];
    [self bindAction];
}

#pragma mark =============== ui and event bind ==============

- (void)configUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *typeLabel = [[UILabel alloc] init];
    typeLabel.text = @"equipType";
    self.typeLabel = typeLabel;
    [self.view addSubview:self.typeLabel];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.text = @"equipName";
    self.nameLabel = nameLabel;
    [self.view addSubview:self.nameLabel];
    
    UILabel *numLabel = [[UILabel alloc] init];
    numLabel.text = @"equipNum";
    self.numLabel = numLabel;
    [self.view addSubview:self.numLabel];
    
    DropDownBtn *typeBtn = [[DropDownBtn alloc] initWithFrame:CGRectZero Title:@"-- equip type --" List:@[@"weapon", @"shoes", @"helmet"]];
    self.typeBtn = typeBtn;
  
    
    UITextField *nameTF = [[UITextField alloc] init];
    nameTF.layer.cornerRadius = 4;
    nameTF.layer.borderColor = [UIColor lightGrayColor].CGColor;
    nameTF.layer.masksToBounds = 1;
    self.nameTF = nameTF;
    [self.view addSubview:nameTF];
    
    UITextField *numTF = [[UITextField alloc] init];
    numTF.layer.cornerRadius = 4;
    numTF.layer.borderColor = [UIColor lightGrayColor].CGColor;
    numTF.layer.masksToBounds = 1;
    self.numTF = numTF;
    self.numTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:numTF];
    
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"btnHightlight"ofType:@"png"];
    NSString *path1 = [[NSBundle mainBundle]pathForResource:@"btnNormal"ofType:@"png"];

    UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commitBtn.imageView.frame = commitBtn.frame;
    commitBtn.imageView.layer.cornerRadius = 4;
    commitBtn.imageView.layer.masksToBounds = YES;
    [commitBtn setBackgroundImage:[UIImage imageWithContentsOfFile:path] forState:UIControlStateHighlighted];
    [commitBtn setBackgroundImage:[UIImage imageWithContentsOfFile:path1] forState:UIControlStateNormal];
    
    [commitBtn setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
    
    self.commitBtn  = commitBtn;
    [self.view addSubview:self.commitBtn];
    //最后添加 typeBtn
    [self.view addSubview:typeBtn];
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20 + 64);
        make.left.equalTo(self.view).offset(10);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(50);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.typeLabel.mas_bottom).offset(10);
        make.left.equalTo( self.view).offset(10);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(50);
    }];
    
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
        make.left.equalTo( self.view).offset(10);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(50);
    }];
    
    [self.typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.typeLabel);
        make.left.equalTo(self.typeLabel.mas_right).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.height.mas_equalTo(50);
    }];
    
    [self.nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel);
        make.left.equalTo(self.typeLabel.mas_right).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.height.mas_equalTo(50);
    }];
    
    [self.numTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.numLabel);
        make.left.equalTo(self.typeLabel.mas_right).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.height.mas_equalTo(50);
    }];
    //HEIGHT 200
    
    [self.commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_bottom).offset(-20 - 50);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(50);
    }];
    
}

- (void)configDropBtnFrame {
    [self.typeBtn configTableViewUI];
}

- (void)bindAction {
    [self.typeBtn addTarget:self action:@selector(selectEquipType:) forControlEvents:UIControlEventTouchUpInside];
    [self.commitBtn addTarget:self action:@selector(addBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.typeBtn addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
}

#pragma mark =============== custom method ==============
- (void)addBtnAction:(id)sender {
    
}

- (void)selectEquipType:(id)sender {
    [self.typeBtn becomeFirstResponder];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"title"]) {
        NSString *old = [change objectForKey:NSKeyValueChangeOldKey];
        NSString *new = [change objectForKey:NSKeyValueChangeNewKey];
        
        DDLogDebug(@"old : %@, new : %@", new, old);
        if ([new isEqualToString:@"weapon"]) {
            self.equipModel.equipmentType = 0;
        }else if([new isEqualToString:@"shoes"]){
            self.equipModel.equipmentType = 1;
        }else {
            self.equipModel.equipmentType = 2;
        }
        
    }else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark =============== uitextFiled Delegate ==============
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([textField isEqual:self.nameTF]) {
        self.equipModel.equipmentName = self.nameTF.text;
    }else if([textField isEqual:self.numLabel]) {
        self.equipModel.equipmentNum = [self.numTF.text integerValue];
    }
}




#pragma mark =============== setter getter ==============
- (EquipmentModel *)equipModel {
    if (!_equipModel) {
        _equipModel = [[EquipmentModel alloc] init];
    }
    return _equipModel;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
    [self.typeBtn removeObserver:self forKeyPath:@"title" context:nil];
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
