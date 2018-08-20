//
//  Singleton.h
//  FMDBDemo
//
//  Created by jiangwei.wang on 2018/8/20.
//  Copyright © 2018年 jiangwei.wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Singleton : NSObject
@property (nonatomic, copy) NSString *className;
+ (Singleton *)shareInstance;
@end
