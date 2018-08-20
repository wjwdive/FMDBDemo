//
//  Singleton.m
//  FMDBDemo
//
//  Created by jiangwei.wang on 2018/8/20.
//  Copyright © 2018年 jiangwei.wang. All rights reserved.
//

#import "Singleton.h"

static Singleton *shareInstance;

@implementation Singleton
+ (Singleton *)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (nil == shareInstance) {
            shareInstance = [[self alloc] init];
        }
    });
    return shareInstance;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (nil == shareInstance) {
            shareInstance = [super allocWithZone:zone];
        }
    });
    return  shareInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.className = @"Singleton";
    }
    return self;
}

- (id)copy {
    return self;
}

- (id)mutableCopy {
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"memory address : %@", self];
}


@end
