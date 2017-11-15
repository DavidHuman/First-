//
//  QLTabbarController.m
//  QiongLiao
//
//  Created by 格式化油条 on 15/9/1.
//  Copyright (c) 2015年 XQBoy. All rights reserved.
//

#import "QLTabbarController.h"

#import "HTMyViewController.h"

#import "HTFindViewController.h"
#import "HTHomeViewController.h"

#import "QLTabBar.h"


@interface QLTabbarController ()

/** 自定义tabBar */
@property (strong, nonatomic) QLTabBar *customTabBar;
@end

//单例化一个类
//#define SYNTHESIZE_SINGLETON_FOR_CLASS(classname) \
//\
//static classname *shared##classname = nil; \
//\
//+ (classname *)shared##classname \
//{ \
//@synchronized(self) \
//{ \
//if (shared##classname == nil) \
//{ \
//shared##classname = [[self alloc] init]; \
//} \
//} \
//\
//return shared##classname; \
//} \
//\
//+ (id)allocWithZone:(NSZone *)zone \
//{ \
//@synchronized(self) \
//{ \
//if (shared##classname == nil) \
//{ \
//shared##classname = [super allocWithZone:zone]; \
//return shared##classname; \
//} \
//} \
//\
//return nil; \
//} \
//\
//- (id)copyWithZone:(NSZone *)zone \
//{ \
//return self; \
//}


@implementation QLTabbarController


- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化子控制器
    [self setupChildViewController];
    
    [self.tabBar addSubview:self.customTabBar];
//    UIView *tabbarLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tabBar.width, 0.6)];
//    tabbarLine.backgroundColor = [UIColor ql_colorWithHex:@"d7d7d7"];
//    [self.tabBar addSubview:tabbarLine];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
//     遍历系统自带tabBar内的按钮，将其删除
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}


- (void)viewWillLayoutSubviews {
    //     遍历系统自带tabBar内的按钮，将其删除
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

#pragma mark - 懒加载自定义tabBar
- (QLTabBar *)customTabBar {

    if (!_customTabBar) {
        _customTabBar = [[QLTabBar alloc] initWithFrame:self.tabBar.bounds];
        [_customTabBar setBackgroundColor:[UIColor whiteColor]];
        
        [_customTabBar tabBarButtonClickOperation:^(NSInteger index) {
            self.selectedIndex = index;
        }];
    }
    return _customTabBar;
}


#pragma mark - 初始化子控制器
- (void)setupChildViewController {
    HTHomeViewController *homeVc  = [[HTHomeViewController alloc] init];
    [self setupAttributeOfViewController:homeVc atTitle:@"首页" atNomalImageName:@"首页-实心" atSelectedImageName:@"首页-实心"];
    
    //FPMessageiewController *messageVc   = [[FPMessageiewController alloc] init];
    //[self setupAttributeOfViewController:messageVc atTitle:@"消息" atNomalImageName:@"tab_message1" atSelectedImageName:@"tab_message2"];
    
    HTFindViewController *contactorVc = [[HTFindViewController alloc] init];
    [self setupAttributeOfViewController:contactorVc atTitle:@"发现" atNomalImageName:@"HoneSlect_icon" atSelectedImageName:@"HoneSlect_icon"];

    HTMyViewController *findVc  = [[HTMyViewController alloc] init];
    [self setupAttributeOfViewController:findVc atTitle:@"我的" atNomalImageName:@"实心" atSelectedImageName:@"实心"];
    
  
}

#pragma mark - 设置子控制器的属性
- (void)setupAttributeOfViewController:(UIViewController *)viewController
                               atTitle:(NSString *)title
                      atNomalImageName:(NSString *)nomalImageName
                   atSelectedImageName:(NSString *)selectedImageName {
    viewController.title                    = title;
    viewController.tabBarItem.image         = [UIImage imageNamed:nomalImageName];
    /** 渲染图片后再赋值 */
    viewController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    [self.customTabBar addTabBarButtonWithItem:viewController.tabBarItem];
    [self addChildViewController:[[UINavigationController alloc] initWithRootViewController:viewController]];
}


@end
