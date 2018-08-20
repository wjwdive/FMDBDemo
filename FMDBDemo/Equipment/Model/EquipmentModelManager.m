//
//  EquipmentModelManager.m
//  FMDBDemo
//
//  Created by jiangwei.wang on 2018/8/7.
//  Copyright © 2018年 jiangwei.wang. All rights reserved.
//

#import "EquipmentModelManager.h"
#import "DataBaseManager.h"

@interface EquipmentModelManager()
@property (nonatomic, strong) FMDatabaseQueue *dbQueue;

@end

@implementation EquipmentModelManager

NSString *const insertAnEquipmentSql = @"INSERT INTO t_equipment (equipmentNum, equipmentName, equipmentType, equipmentStatus, createTime, updateTime, playerID) VALUES (?, ?, ?, ?, ?, ?, ?) ";

NSString *const selectAllEquipmentSql = @"SELECT * FROM t_equipment WHERE playerID = ?";

NSString *const deleteByIDSql = @"DELETE FROM t_equipment WHERE equipmentID = ? ";

- (id)init {
    self = [super init];
    if (self) {
        self.dbQueue = [DataBaseManager shareDBManager].dbQueue;
    }
    return self;
}


//equipmentID INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,\
//equipmentNum INTEGER,\
//equipmentName TEXT DEFAULT '',\
//equipmentType INTEGER,\
//equipmentStatus INTEGER,\
//createTime DATETIME,\
//updateTime DATETIME,\
//playerID INTEGER, \

- (BOOL)addANewEquipment:(EquipmentModel *)equipModel {
    
    
    __block BOOL flag = NO;
    NSTimeInterval createTime = [equipModel.createTime timeIntervalSince1970];
    NSTimeInterval updateTime = [equipModel.updateTime timeIntervalSince1970];
    
    [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        flag = [db executeUpdate:insertAnEquipmentSql, @(equipModel.equipmentNum), equipModel.equipmentName, @(equipModel.equipmentType), @(equipModel.equipmentStatus), @(createTime), @(updateTime)];
        if (flag) {
            DDLogDebug(@"insert equipment success");
        }else{
            DDLogDebug(@"insert equipment failure");
        }
    }];
    
    return flag;
    
}

- (BOOL)deleteEquipmentByID:(NSInteger)equipmentID {
    
    
    __block BOOL flag = NO;
    
    [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        flag = [db executeUpdate:deleteByIDSql, @(equipmentID)];
        if (flag) {
            DDLogDebug(@"delete  equipment :%ld success", equipmentID);
        }else{
            DDLogDebug(@"delete equipment : :%ld failure", equipmentID);
        }
    }];
    
    return flag;
    
}

- (NSMutableArray *)selectAllEquipmentByPlayerId:(NSInteger)playerID {
    
    __block NSMutableArray *arrM = [NSMutableArray array];
    [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        FMResultSet *result  = [db executeQuery:selectAllEquipmentSql,@(playerID)];
        while ([result next]) {
            EquipmentModel *model = [[EquipmentModel alloc] init];
            model.equipmentID = [result intForColumn:@"equipmentID"];
            model.equipmentName = [result stringForColumn:@"equipmentName"];
            model.equipmentNum = [result intForColumn:@"equipmentNum"];
            model.equipmentType = [result intForColumn:@"equipmentType"];
            model.equipmentStatus = [result intForColumn:@"equipmentStatus"];
            model.createTime = [result dateForColumn:@"createTime"];
            model.updateTime = [result dateForColumn:@"updateTime"];
            model.playerID = [result intForColumn:@"playerID"];
            [arrM addObject:model];
        }
    }];
    
    return arrM;
}
@end
