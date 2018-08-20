//
//  DropDownBtn.h
//  FMDBDemo
//
//  Created by jiangwei.wang on 2018/8/8.
//  Copyright © 2018年 jiangwei.wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropDownBtn : UIButton

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSArray *list;

- (instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title List:(NSArray *)list;
-(void)configTableViewUI;
@end
