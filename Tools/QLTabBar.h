//
//  QLTabBar.h
//  QiongLiao
//
//  Created by 格式化油条 on 15/9/1.
//  Copyright (c) 2015年 XQBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QLTabBarButton.h"

extern NSString *const QLTabBarUpdateMessageBadgeValueNotification;
extern NSString *const QLTabBarUpdateContactorBadgeValueNotification;
extern NSString *const QLTabBarUpdateFindBadgeValueNotification;
extern NSString *const QLTabBarSelectItemNotification;

#define kTabBarTag 10001

/** 点击tabBar上按钮的操作 */
typedef void(^QLTabBarButtonClick)(NSInteger index);

@interface QLTabBar : UIView

/** 点击tabBar上按钮的操作 */
@property (copy, nonatomic) QLTabBarButtonClick tabBarClick;
- (void)tabBarButtonClickOperation:(QLTabBarButtonClick)block;

/**
 *  根据传递过来的item创建按钮
 */
- (void)addTabBarButtonWithItem:(UITabBarItem *)item;

- (void)tabBarButtonClick:(QLTabBarButton *)button;

@end
