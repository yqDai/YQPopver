//
//  YQPopver.h
//  动画
//
//  Created by 代玉钦 on 15/8/4.
//  Copyright (c) 2015年 dyq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    YQPopverAnimationTypeNone, // 无动画
    YQPopverAnimationTypeLeft, // 从左往右往下掉
    YQPopverAnimationTypeMiddle, // 从中间到两边往下掉
    YQPopverAnimationTypeBalloon // 慢慢变大出现，慢慢变小消失
} YQPopverAnimationType ;


@interface YQPopver : UIView

/*
 * 按照指定动画显示
 */
- (void)showWithAnimationWithAnimationType:(YQPopverAnimationType)animationType;

/*
 * 按照指定动画隐藏
 */
- (void)hideWithAnimationWithAnimationType:(YQPopverAnimationType)animationType;

/*
 * 设置指定位置的图片，如果不设置则按默认的显示
 */
- (void)setImage:(UIImage *)image withIndex:(NSInteger)index;

/*
 * 设置指定位置的文字，如果不设置则按默认的显示
 */
- (void)setTitle:(NSString *)title withIndex:(NSInteger)index;

/*
 * 设置指定位置的文字颜色，如果不设置则按默认的显示
 */
- (void)setTitleColor:(UIColor *)color withIndex:(NSInteger)index;

/*
 * 设置点击指定位置触发的事件
 */
- (void)addTarget:(id)target action:(SEL)action withIndex:(NSInteger)index;

/*
 * 背景View，可在背景view上添加自定义控件
 */
@property (nonatomic,strong) UIView *backgroundView;

/*
 * 点击取消时popView隐藏的动画类型，如果不设置默认为YQPopverAnimationTypeNone
 */
@property (nonatomic,assign) YQPopverAnimationType cancelAnimationType;

@end
