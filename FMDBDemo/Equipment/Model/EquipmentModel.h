//
//  EquipmentModel.h
//  FMDBDemo
//
//  Created by jiangwei.wang on 2018/8/6.
//  Copyright © 2018年 jiangwei.wang. All rights reserved.
//

#import "BaseModel.h"

//equipmentID INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,\
//equipmentNum INTEGER,\
//equipmentName TEXT DEFAULT '',\
//equipmentType INTEGER,\
//equipmentStatus INTEGER,\
//createTime DATETIME,\
//updateTime DATETIME,\
//playerID INTEGER, \

@interface EquipmentModel : BaseModel

@property (nonatomic, assign) NSInteger equipmentID;
@property (nonatomic, assign) NSInteger equipmentNum;
@property (nonatomic, copy) NSString *equipmentName;
@property (nonatomic, assign) NSInteger equipmentType;
@property (nonatomic, assign) NSInteger equipmentStatus;
@property (nonatomic, strong) NSDate *createTime;
@property (nonatomic, strong) NSDate *updateTime;
@property (nonatomic, assign) NSInteger playerID;


@end
