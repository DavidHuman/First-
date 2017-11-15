//
//  QLTabBarButton.m
//  QiongLiao
//
//  Created by 格式化油条 on 15/9/1.
//  Copyright (c) 2015年 XQBoy. All rights reserved.
//

#import "QLTabBarButton.h"
#import "UIView+GJRedDot.h"

#define kTabBarBurron_Image_Ratio 0.6

@implementation QLTabBarButton

#pragma mark - 给按钮内部的控件设置属性

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor darkTextColor] forState:UIControlStateSelected];
        [self.titleLabel setFont:[UIFont systemFontOfSize:11]];
        
        // 设置红点偏移量
        CGPoint offset = self.badgeOffset;
        offset.x -= 21;
        offset.y += 4;
        self.badgeOffset = offset;
    }
    return self;
}

#pragma mark - 在此方法内部重新设置按钮内部的imageView和label的frame
- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGRect imageFrame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) * kTabBarBurron_Image_Ratio);
    self.imageView.frame = imageFrame;
    CGRect titleLabelFrame = CGRectMake(0, CGRectGetMaxY(self.imageView.frame), CGRectGetWidth(self.frame),CGRectGetHeight(self.frame) * (1 - kTabBarBurron_Image_Ratio));
    
    self.titleLabel.frame = titleLabelFrame;
}

#pragma mark - 重写set方法，在方法内部监听item值的改变，并根据item的值来为按钮的属性赋值
- (void)setItem:(UITabBarItem *)item {
    _item = item;
    // KVO 监听值的改变
    [item addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:NSKeyValueObservingOptionNew context:nil];
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
}

#pragma mark - 移除KVO监听
- (void)dealloc {
    [self.item removeObserver:self forKeyPath:@"title"];
    [self.item removeObserver:self forKeyPath:@"image"];
    [self.item removeObserver:self forKeyPath:@"selectedImage"];
}

#pragma mark - 当监听的值发生改变的时候就会调用这个方法。在这个方法内部重新给按钮的属性赋值
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    [self setTitle:self.item.title forState:UIControlStateNormal];
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
}

#pragma mark - 取消按钮的高亮状态


- (void)setHighlighted:(BOOL)highlighted {
    
    
}


@end
