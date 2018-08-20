//
//  WJWEquipCell.h
//  FMDBDemo
//
//  Created by jiangwei.wang on 2018/8/7.
//  Copyright © 2018年 jiangwei.wang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EquipmentModel.h"

//equipmentID INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,\
//equipmentNum INTEGER,\
//equipmentName TEXT DEFAULT '',\
//equipmentType INTEGER,\
//equipmentStatus INTEGER,\
//createTime DATETIME,\
//updateTime DATETIME,\
//playerID INTEGER, \

typedef NS_ENUM(NSInteger, EQUIP_TYPE) {
    EQUIP_TYPE_WEAPON,
    EQUIP_TYPE_SHOES,
    EQUIP_TYPE_HELMET
};

typedef NS_ENUM(NSInteger, EQUIP_STATUS) {
    EQUIP_STATUS_NORMAL,
    EQUIP_STATUS_IN_USE
};

@interface WJWEquipCell : UITableViewCell

@property (nonatomic, strong) UIImageView *equipmentPhoto;
@property (nonatomic, strong) UILabel *equipNameLabel;
@property (nonatomic, strong) UILabel *equipTypeLabel;
@property (nonatomic, strong) UILabel *equipNumLabel;
@property (nonatomic, strong) UILabel *equipStatusLabel;

@property (nonatomic, strong) EquipmentModel *equipModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (void)setEquipModel:(EquipmentModel *)equipModel;
@end
