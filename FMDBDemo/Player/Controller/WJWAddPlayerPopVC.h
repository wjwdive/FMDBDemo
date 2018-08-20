//
//  WJWAddPlayerPopVC.h
//  FMDBDemo
//
//  Created by jiangwei.wang on 2018/8/7.
//  Copyright © 2018年 jiangwei.wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WJWAddPlayerPopVC;

@protocol WJWAddPlayerPopVCDelegate <NSObject>
- (void)WJWAddPlayerPopVC:(WJWAddPlayerPopVC *)addPlayerPopVC didCancelAction:(id)object;
- (void)WJWAddPlayerPopVC:(WJWAddPlayerPopVC *)addPlayerPopVC didAddAction:(id)object;

@end


@interface WJWAddPlayerPopVC : UIViewController
@property (nonatomic, weak) id<WJWAddPlayerPopVCDelegate> delegate;
@end
