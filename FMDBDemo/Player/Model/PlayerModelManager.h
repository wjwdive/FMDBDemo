//
//  PlayerModelManager.h
//  FMDBDemo
//
//  Created by jiangwei.wang on 2018/8/7.
//  Copyright © 2018年 jiangwei.wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlayerModel.h"

@interface PlayerModelManager : NSObject
- (BOOL)addNewPlayer:(PlayerModel *)playerModel;
- (NSMutableArray *)selectPlayersByCondition:(NSDictionary *)dict;
@end
