//
//  DataBaseManager.m
//  FMDBDemo
//
//  Created by jiangwei.wang on 2018/8/6.
//  Copyright © 2018年 jiangwei.wang. All rights reserved.
//

#import "DataBaseManager.h"

@interface DataBaseManager()

@end


NSString *const foreignKeySqlON = @"PRAGMA foreign_keys = ON;";

NSString *const createPlayerTableSql = @"CREATE TABLE IF NOT EXISTS t_player (\
playerID INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,\
firstName TEXT,\
lastName TEXT,\
status INTEGER,\
email TEXT,\
createTime datetime,\
updateTime datetime\
);";


NSString *const createEquipmentSql = @"CREATE TABLE IF NOT EXISTS t_equipment (\
equipmentID INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,\
equipmentNum INTEGER,\
equipmentName TEXT DEFAULT '',\
equipmentType INTEGER,\
equipmentStatus INTEGER,\
createTime DATETIME,\
updateTime DATETIME,\
playerID INTEGER, \
CONSTRAINT playerID FOREIGN KEY(playerID) REFERENCES t_player(playerID) ON DELETE CASCADE ON UPDATE CASCADE \
);";

//FOREIGN KEY(visitor) REFERENCES t_visitor(visitorID)
//CONSTRAINT visitor FOREIGN KEY(visitor) REFERENCES t_visitor(visitorID)
// ON DELETE CASCADE ON UPDATE CASCADE




@implementation DataBaseManager
static DataBaseManager *manager = nil;

+ (DataBaseManager *)shareDBManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DataBaseManager alloc] init];
        [manager configDB];
        [manager createTable];
    });
    return manager;
}


- (void)configDB {
    NSString* docsdir = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString* dbpath = [docsdir stringByAppendingPathComponent:@"my.db"];
    DDLogDebug(@"my.db path: %@", dbpath);
    self.dbQueue = [FMDatabaseQueue databaseQueueWithPath:dbpath];
    DDLogDebug(@"my.db 创建成功");
    //启用外键支持
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        
        BOOL tResult = [db executeUpdate:foreignKeySqlON];
        if (tResult) {
            DDLogDebug(@"启用外键支持 ");
        }else{
            DDLogDebug(@"未启用外键支持 ");
        }
    }];
    
    //
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *tResult = [db executeQuery:@"PRAGMA foreign_keys"];
        while ([tResult next]) {
            int enabled = [tResult intForColumnIndex:0];
            if (enabled) {
                DDLogDebug(@"--- 已启用外键支持 ");
            }else{
                DDLogDebug(@"--- 未启用外键支持 ");
            }
        }
    }];
}


- (void)createTable {
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        
        BOOL tResult = [db executeUpdate:createPlayerTableSql];
        if (tResult) {
            DDLogDebug(@"create player table success");
        }else{
            DDLogDebug(@"create player table failuer ");
        }
    }];
    
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        
        BOOL tResult = [db executeUpdate:createEquipmentSql];
        if (tResult) {
            DDLogDebug(@"create equipment table success");
        }else{
            DDLogDebug(@"create equipment table failuer ");
        }
    }];
    
}
@end
