//
//  WJWEquipMenuPopVC.h
//  FMDBDemo
//
//  Created by jiangwei.wang on 2018/8/8.
//  Copyright © 2018年 jiangwei.wang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WJWEquipMenuPopVC;
@protocol WJWEquipMenuPopVCDelegate <NSObject>
- (void)menuPopVC:(WJWEquipMenuPopVC *)menPopVC didSelectMenuItmeAtIndex:(NSInteger)menuIndex;
@end

@interface WJWEquipMenuPopVC : UIViewController
@property (nonatomic, weak) id <WJWEquipMenuPopVCDelegate> delegate;
@end
