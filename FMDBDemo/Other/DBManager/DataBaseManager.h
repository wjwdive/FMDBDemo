//
//  DataBaseManager.h
//  FMDBDemo
//
//  Created by jiangwei.wang on 2018/8/6.
//  Copyright © 2018年 jiangwei.wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataBaseManager : NSObject
@property (nonatomic, strong) FMDatabaseQueue *dbQueue;
+ (DataBaseManager *)shareDBManager;

@end
