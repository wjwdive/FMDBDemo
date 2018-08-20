//
//  PlayerModelManager.m
//  FMDBDemo
//
//  Created by jiangwei.wang on 2018/8/7.
//  Copyright © 2018年 jiangwei.wang. All rights reserved.
//

#import "PlayerModelManager.h"

#import "DataBaseManager.h"

@interface PlayerModelManager()
@property (nonatomic, strong) DataBaseManager *dbManager;
@property (nonatomic, strong) FMDatabaseQueue *dbQueue;
@end


NSString *const  selectAllPlayer = @" SELECT * FROM t_player ";
NSString *const  insertAPlayerSql = @"INSERT INTO t_player (firstName, lastName, status, email, createTime,  updateTime) VALUES (?,?,?,?,?,?)";

@implementation PlayerModelManager

- (id)init {
    self = [super init];
    if (self) {
        self.dbQueue =  [DataBaseManager shareDBManager].dbQueue;
    }
    return self;
}

- (BOOL)addNewPlayer:(PlayerModel *)playerModel {
    __block BOOL insertFlag = NO;
    NSTimeInterval createTime = [playerModel.createTime timeIntervalSince1970];
    NSTimeInterval updateTime = [playerModel.updateTime timeIntervalSince1970];

    [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        insertFlag = [db executeUpdate:insertAPlayerSql, playerModel.firstName, playerModel.lastName, @(playerModel.status), playerModel.email, @(createTime), @(updateTime)];
    }];
    
    if (insertFlag) {
        DDLogDebug(@"insert a player success");
    }else {
        DDLogDebug(@"insert a player failure");
    }
    return insertFlag;
    
}

//playerID INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,\
//firstName TEXT,\
//lastName TEXT,\
//status INTEGER,\
//email TEXT,\
//createTime datetime,\
// datetime\

- (NSMutableArray *)selectPlayersByCondition:(NSDictionary *)dict {
    __block NSMutableArray *arrayM = [NSMutableArray array];
//    NSMutableString *sql = [NSMutableString stringWithFormat:@"%@ %@",selectAllPlayer, @" where 1 = 1 "];
    [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        FMResultSet *result = [db executeQuery:selectAllPlayer withParameterDictionary:nil];
        while ([result next]) {
            PlayerModel *model  = [[PlayerModel alloc] init];
            model.firstName = [result stringForColumn:@"firstName"];
            model.lastName = [result stringForColumn:@"lastName"];
            model.status = [result intForColumn:@"status"];
            model.email = [result stringForColumn:@"email"];
            model.createTime = [result dateForColumn:@"createTime"];
            model.updateTime = [result dateForColumn:@"updateTime"];
            [arrayM addObject:model];
        }
    }];
    return arrayM;
}





@end
