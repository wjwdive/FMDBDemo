//
//  PlayerModel.h
//  FMDBDemo
//
//  Created by jiangwei.wang on 2018/8/6.
//  Copyright © 2018年 jiangwei.wang. All rights reserved.
//

#import "BaseModel.h"
//playerID INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,\
//firstName TEXT,\
//lastName TEXT,\
//status INTEGER,\
//email TEXT,\
//createTime datetime,\
//updateTime datetime\

@interface PlayerModel : BaseModel

@property (nonatomic, assign) NSInteger playerID;
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, strong) NSDate *createTime;
@property (nonatomic, strong) NSDate *updateTime;


@end
