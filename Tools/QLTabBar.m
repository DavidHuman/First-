//
//  QLTabBar.m
//  QiongLiao
//
//  Created by 格式化油条 on 15/9/1.
//  Copyright (c) 2015年 XQBoy. All rights reserved.
//

#import "QLTabBar.h"
#import "UIView+GJRedDot.h"

NSString *const QLTabBarUpdateMessageBadgeValueNotification = @"QLTabBarUpdateMessageBadgeValueNotification";
NSString *const QLTabBarUpdateContactorBadgeValueNotification = @"QLTabBarUpdateContactorBadgeValueNotification";
NSString *const QLTabBarUpdateFindBadgeValueNotification = @"QLTabBarUpdateFindBadgeValueNotification";
NSString *const QLTabBarSelectItemNotification = @"QLTabBarSelectItemNotification";

@interface QLTabBar ()
/** 存放按钮数组 */
@property (strong, nonatomic) NSMutableArray *tabBarButtons;
/** 当前选择的按钮 */
@property (strong, nonatomic) QLTabBarButton *selectedButton;
@end

@implementation QLTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
#pragma mark - 通过tag在跳转时取到tabBar
        self.tag = kTabBarTag;
        [self registNotifications];
    }
    return self;
}

- (void)registNotifications {
    __weak typeof(self) weakSelf = self;
    [[NSNotificationCenter defaultCenter] addObserverForName:QLTabBarUpdateMessageBadgeValueNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        QLTabBarButton *button = weakSelf.tabBarButtons[0];
        NSString *badgeValue = note.userInfo[@"badgeValue"];
        [button setBadgeValue:badgeValue];
    }];
    [[NSNotificationCenter defaultCenter] addObserverForName:QLTabBarUpdateContactorBadgeValueNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        QLTabBarButton *button = weakSelf.tabBarButtons[1];
        NSString *badgeValue = note.userInfo[@"badgeValue"];
        [button setBadgeValue:badgeValue];
    }];
    [[NSNotificationCenter defaultCenter] addObserverForName:QLTabBarUpdateFindBadgeValueNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        QLTabBarButton *button = weakSelf.tabBarButtons[2];
        NSString *badgeValue = note.userInfo[@"badgeValue"];
        [button setBadgeValue:badgeValue];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:QLTabBarSelectItemNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        NSInteger index = [note.userInfo[@"index"] integerValue];
        if (index < 0 || index >= self.tabBarButtons.count) return;
        QLTabBarButton *button = weakSelf.tabBarButtons[index];
        [self tabBarButtonClick:button];
    }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 懒加载

- (NSMutableArray *)tabBarButtons {
    
    if (!_tabBarButtons) {
        _tabBarButtons = @[].mutableCopy;
    }
    return _tabBarButtons;
}

#pragma mark - 根据传递过来的item创建按钮
- (void)addTabBarButtonWithItem:(UITabBarItem *)item {
    
    QLTabBarButton *button = [QLTabBarButton buttonWithType:UIButtonTypeCustom];
    
    button.item = item;
    
    [self addSubview:button];
    
    [self.tabBarButtons addObject:button];
    
    [button addTarget:self action:@selector(tabBarButtonClick:) forControlEvents:UIControlEventTouchDown];
    
    /** 默认选择第一个按钮 */
    if (self.tabBarButtons.count == 1) {
        [self tabBarButtonClick:button];
    }
}

#pragma mark - 按钮点击方法
- (void)tabBarButtonClick:(QLTabBarButton *)button {
    /** 将按钮的tag传递过去，告诉控制器切换对应的index */
    if (self.tabBarClick) {
        self.tabBarClick(button.tag - 100);
    }
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
}

#pragma mark - 设置按钮的frame
- (void)layoutSubviews {
    [super layoutSubviews];
    
//    NSLog(@"====== tabBar layoutSubviews begin ====");

    CGFloat buttonY = 6;
    CGFloat buttonWidth = CGRectGetWidth(self.frame) / ([self.subviews count] + 0.4) ;
    CGFloat buttonHeight = CGRectGetHeight(self.frame) - 6;
    
//    NSLog(@"%@",NSStringFromCGRect(self.frame));
//    NSLog(@"%.2lf === %.2lf === %.2lf",buttonY, buttonWidth, buttonHeight);
    
    for (int index = 0; index < self.tabBarButtons.count; index++) {
        QLTabBarButton *button = self.tabBarButtons[index];
        button.tag = index + 100;
        CGFloat buttonX = index * buttonWidth + 0.2 * buttonWidth;
        button.frame = CGRectMake(buttonX, buttonY, buttonWidth, buttonHeight);
//        NSLog(@"index == %zd ==== %@",button.tag,NSStringFromCGRect(button.frame));
    }
//    NSLog(@"====== tabBar layoutSubviews end ====");
}


#pragma mark - 设置block

- (void)tabBarButtonClickOperation:(QLTabBarButtonClick)block {
    if (block) {
        self.tabBarClick = block;
    }
}

@end
