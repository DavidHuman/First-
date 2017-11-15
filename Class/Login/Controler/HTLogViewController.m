//
//  HTLogViewController.m
//  HTProjectManager
//
//  Created by CHT on 2017/11/15.
//  Copyright © 2017年 池海涛. All rights reserved.
//

#import "HTLogViewController.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "QLTabbarController.h"
@interface HTLogViewController ()
@property (weak, nonatomic) IBOutlet UIView *userNameView;
@property (weak, nonatomic) IBOutlet UIView *pwdView;
@property (weak, nonatomic) IBOutlet UIButton *zhuceBtn;
@property (weak, nonatomic) IBOutlet UIButton *logBtn;

@end

@implementation HTLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //隐藏导航栏
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.zhuceBtn.layer.cornerRadius = 4;
    self.zhuceBtn.layer.masksToBounds = YES;
    self.zhuceBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.zhuceBtn.layer.borderWidth = 1;
    self.logBtn.layer.cornerRadius = 4;
    self.logBtn.layer.masksToBounds = YES;
    
    [IQKeyboardManager sharedManager].enable = YES;
}

- (IBAction)clickZheCeBtn:(id)sender {
    NSLog(@"点击了注册");
    
}
- (IBAction)clickLogBtn:(id)sender {
    NSLog(@"点击了登录");
    
    
    
    QLTabbarController *tabBarVc = [[QLTabbarController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVc;
    
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
