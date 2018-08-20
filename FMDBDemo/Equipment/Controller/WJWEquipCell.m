//
//  WJWEquipCell.m
//  FMDBDemo
//
//  Created by jiangwei.wang on 2018/8/7.
//  Copyright © 2018年 jiangwei.wang. All rights reserved.
//

#import "WJWEquipCell.h"

@implementation WJWEquipCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"cellID";
    WJWEquipCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil){
        cell = [[WJWEquipCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    UIImageView *equipPhoto = [[UIImageView alloc] init];
    self.equipmentPhoto = equipPhoto;
    [self.contentView addSubview:self.equipmentPhoto];
    
    UILabel *equipNameLabel = [[UILabel alloc] init];
    equipNameLabel.font  = [UIFont systemFontOfSize:12];
    equipNameLabel.textAlignment = NSTextAlignmentCenter;
    self.equipNameLabel = equipNameLabel;
    [self.contentView addSubview:self.equipNameLabel];
    
    UILabel *equipTypeLabel = [[UILabel alloc] init];
    equipTypeLabel.font  = [UIFont systemFontOfSize:12];
    equipTypeLabel.textAlignment = NSTextAlignmentCenter;
    self.equipTypeLabel = equipTypeLabel;
    [self.contentView addSubview:self.equipTypeLabel];
    
    UILabel *equipNumLabel = [[UILabel alloc] init];
    equipNumLabel.font  = [UIFont systemFontOfSize:12];
    equipNumLabel.textAlignment = NSTextAlignmentCenter;
    self.equipNumLabel = equipNumLabel;
    [self.contentView addSubview:self.equipNumLabel];
    
    UILabel *equipStatusLabel = [[UILabel alloc] init];
    equipStatusLabel.font  = [UIFont systemFontOfSize:12];
    equipStatusLabel.textAlignment = NSTextAlignmentCenter;
    self.equipNameLabel = equipStatusLabel;
    [self.contentView addSubview:self.equipStatusLabel];
    
    [self.equipmentPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.left.equalTo(self.contentView).offset(10);
        make.height.width.mas_equalTo(50);
    }];
    
    [self.equipNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.left.equalTo(self.equipmentPhoto.mas_right).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.width.mas_equalTo(20);

    }];
    
    [self.equipTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.equipNameLabel.mas_bottom).offset(5);
        make.left.equalTo(self.equipmentPhoto.mas_right).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.width.mas_equalTo(20);
    }];
    
    [self.equipNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.equipmentPhoto.mas_bottom).offset(5);
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.mas_equalTo(20);
    }];
    
    [self.equipStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.equipNumLabel.mas_bottom).offset(5);
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.mas_equalTo(20);
    }];
    
    
    
    
}


- (void)setEquipModel:(EquipmentModel *)equipModel {
    self.equipModel = equipModel;
    switch (equipModel.equipmentType) {
        case EQUIP_TYPE_WEAPON:
            self.equipmentPhoto.image = [UIImage imageNamed:@"weapon"];
            self.equipNumLabel.text = [NSString stringWithFormat:@"Attack:%ld" ,equipModel.equipmentNum];

            self.equipTypeLabel.text = @"weapon";
            break;
        case EQUIP_TYPE_SHOES:
            self.equipmentPhoto.image = [UIImage imageNamed:@"shoes"];
            self.equipNumLabel.text = [NSString stringWithFormat:@"Speed:%ld" ,equipModel.equipmentNum];

            self.equipTypeLabel.text = @"shoes";
            break;
        case EQUIP_TYPE_HELMET:
            self.equipmentPhoto.image = [UIImage imageNamed:@"helmet"];
            self.equipNumLabel.text = [NSString stringWithFormat:@"Defence:%ld" ,equipModel.equipmentNum];
            self.equipTypeLabel.text = @"helmet";
            break;
            
        default:
            self.equipmentPhoto.image = [UIImage imageNamed:@"emoji"];
            self.equipTypeLabel.text = @"unkonw";
            break;
    }
    
    
    switch (equipModel.equipmentNum) {
        case EQUIP_STATUS_NORMAL:
            self.equipStatusLabel.text = @"可装备";
            break;
        case EQUIP_STATUS_IN_USE:
            self.equipStatusLabel.text = @"已装备";
            break;
            
        default:
            break;
    }
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
