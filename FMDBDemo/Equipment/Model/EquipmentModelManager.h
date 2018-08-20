//
//  EquipmentModelManager.h
//  FMDBDemo
//
//  Created by jiangwei.wang on 2018/8/7.
//  Copyright © 2018年 jiangwei.wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EquipmentModel.h"

@interface EquipmentModelManager : NSObject

- (BOOL)addANewEquipment:(EquipmentModel *)equipModel;
- (BOOL)deleteEquipmentByID:(NSInteger)equipmentID;
- (NSMutableArray *)selectAllEquipmentByPlayerId:(NSInteger)playerID;

@end
