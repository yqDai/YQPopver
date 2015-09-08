//
//  YQPopver.m
//  动画
//
//  Created by 代玉钦 on 15/8/4.
//  Copyright (c) 2015年 dyq. All rights reserved.
//

#import "YQPopver.h"

@interface YQPopverButton : UIButton

@end

@implementation YQPopverButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageW = self.frame.size.width;
    CGFloat imageH = imageW;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleY = self.frame.size.width + 10;
    CGFloat titleW = self.frame.size.width;
    CGFloat titleH = self.frame.size.height - titleW;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

@end

@interface YQPopver ()

@property (nonatomic,strong) NSMutableArray *popViews;
@property (nonatomic,strong) UIButton *cancel;

@end

@implementation YQPopver

static bool appear = NO;


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        if (appear == NO)
        {
            UIView *backgroundView = [[UIView alloc] init];
            backgroundView.hidden = YES;
            backgroundView.backgroundColor = [UIColor whiteColor];
            backgroundView.alpha = 1;
            self.backgroundView = backgroundView;
            [backgroundView addSubview:self];
            
            [[self topViewController].view addSubview:backgroundView];
            
            UIButton *cancel = [[UIButton alloc] init];
            [cancel setTitle:@"取消" forState:UIControlStateNormal];
            [cancel setBackgroundColor:[UIColor clearColor]];
            [cancel setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [cancel addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
            [backgroundView addSubview:cancel];
            self.cancel = cancel;
            for (int i = 0; i < 9; i ++)
            {
                YQPopverButton *popView = [[YQPopverButton alloc] init];
                [popView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"YQPopver.bundle/Card-%d",i+1]]forState:UIControlStateNormal];
                [popView setTitle:@"微信" forState:UIControlStateNormal];
                [popView setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                popView.tag = i;
                [self addSubview:popView];
                [self.popViews addObject:popView];
            }
        }
    }
    appear = YES;
     return self;
}

- (void)cancelButtonClick
{
    [self hideWithAnimationWithAnimationType:self.cancelAnimationType];
}

- (NSMutableArray *)popViews
{
    if (!_popViews)
    {
        _popViews = [NSMutableArray array];
    }
    return _popViews;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    self.backgroundView.frame = [self topViewController].view.bounds;
    
    CGFloat cancelW = self.backgroundView.frame.size.width - 2 * 20;
    CGFloat cancelH = 30;
    self.cancel.frame = CGRectMake(20, self.backgroundView.frame.size.height - 40, cancelW, cancelH);
    
    CGFloat popViewWidth = 40;
    CGFloat popViewHeight = 70 ;
    CGFloat margin = (self.frame.size.width - 3 *popViewWidth)/4;
    for (int i = 0; i < self.popViews.count; i++)
    {
        YQPopverButton *popView = self.popViews[i];
        int row = i / 3;
        int col = i % 3;
        CGFloat popViewX = margin + (popViewWidth + margin) * col;
        CGFloat popViewY = (popViewHeight + margin) * row;
        popView.frame = CGRectMake(popViewX, popViewY, popViewWidth, popViewHeight);
    }
}

- (void)showWithAnimationWithAnimationType:(YQPopverAnimationType)animationType
{
    UIViewController *topVC = [self topViewController];
    
//    [topVC.view addSubview:self.backgroundView];
    self.backgroundView.hidden = NO;
    self.frame = CGRectMake(topVC.view.frame.size.width * 0.15, topVC.view.frame.size.height * 0.25, topVC.view.frame.size.width * 0.7, topVC.view.frame.size.height * 0.5);
    NSUInteger count = self.popViews.count;
    if (animationType == YQPopverAnimationTypeLeft)
    {
        for (NSUInteger i = 0; i < count; i++)
        {
            YQPopverButton *pop = self.popViews[count - i - 1];
            CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
            anima.values = @[@(-topVC.view.frame.size.height * 0.8),@4,@0];
            anima.duration = 0.1 + 0.1 *i;
            [pop.layer addAnimation:anima forKey:nil];
        }
    }
    else if (animationType == YQPopverAnimationTypeMiddle)
    {
        for (NSInteger i = 1; i <= count - 1 ; i += 3)
        {
            int col = i % 3;
            if (col == 1)
            {
               
                    YQPopverButton *popMiddle = self.popViews[i];
                    CAKeyframeAnimation *animaMiddle = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
                    animaMiddle.values = @[@(-topVC.view.frame.size.height * 0.8),@4,@0];
                    animaMiddle.duration = (count - i - 2) * 0.2;
                    [popMiddle.layer addAnimation:animaMiddle forKey:nil];
                        
                    YQPopverButton *popLeft = self.popViews[i - 1];
                    CAKeyframeAnimation *animaLeft = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
                    animaLeft.values = @[@(-topVC.view.frame.size.height * 0.8),@4,@0];
                    animaLeft.duration = (count - i) * 0.2;
                    [popLeft.layer addAnimation:animaLeft forKey:nil];
                        
                
                    YQPopverButton *popRight = self.popViews[i + 1];
                    CAKeyframeAnimation *animaRight = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
                    animaRight.values = @[@(-topVC.view.frame.size.height * 0.8),@4,@0];
                    animaRight.duration =  (count -i - 1) * 0.2;
                    [popRight.layer addAnimation:animaRight forKey:nil];
            }
        }
    }
    else if (animationType == YQPopverAnimationTypeBalloon)
    {
        for (NSUInteger i = 0; i < count; i++)
        {
            YQPopverButton *pop = self.popViews[count - i - 1];
            CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
//            pop.transform = cgaffinetr
            anima.values = @[@0.01,@0.1,@0.3,@0.5,@0.8,@1.0,@1.3,@1.1,@1.0];
            anima.duration = 0.1 + 0.1 *i;
            [pop.layer addAnimation:anima forKey:nil];
        }

    }
}

- (void)hideWithAnimationWithAnimationType:(YQPopverAnimationType)animationType
{
    appear = NO;
    UIViewController *topVC = [self topViewController];
    NSUInteger count = self.popViews.count;
    if (animationType == YQPopverAnimationTypeLeft)
    {
        for (NSUInteger i = 0; i < count; i++)
        {
            __block YQPopverButton *pop = self.popViews[i];
            CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
            anima.values = @[@0,@(-4),@(+topVC.view.frame.size.height * 0.8)];
            CGFloat duration = 0.1 + 0.1 *i;
            anima.duration = duration;
            anima.fillMode = kCAFillModeForwards;
            anima.removedOnCompletion = NO;
            [pop.layer addAnimation:anima forKey:nil];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [pop removeFromSuperview];
                pop = nil;
                if (i == count - 1)
                {
                    [self removeFromSuperview];
                    [self.backgroundView removeFromSuperview];
                }
            });
        }
    }
    else if (animationType == YQPopverAnimationTypeMiddle)
    {
        for (NSInteger i = count - 2; i >= 0 ; i -= 3)
        {
            int col = i % 3;
            if (col == 1)
            {
                
                
               __block YQPopverButton *popMiddle = self.popViews[i];
                CAKeyframeAnimation *animaMiddle = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
                animaMiddle.values = @[@0,@(-4),@(topVC.view.frame.size.height * 0.8)];
                CGFloat durationMiddle = (count - i - 2) * 0.1;
                animaMiddle.duration = durationMiddle;
                animaMiddle.removedOnCompletion = NO;
                animaMiddle.fillMode = kCAFillModeForwards;
                [popMiddle.layer addAnimation:animaMiddle forKey:nil];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(durationMiddle * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [popMiddle removeFromSuperview];
                    popMiddle = nil;
                });
                
                
                
                __block YQPopverButton *popLeft = self.popViews[i - 1];
                CAKeyframeAnimation *animaLeft = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
                animaLeft.values = @[@0,@(-4),@(topVC.view.frame.size.height * 0.8)];
                CGFloat durationLeft = (count - i) * 0.1;
                animaLeft.duration = durationLeft;
                animaLeft.removedOnCompletion = NO;
                animaLeft.fillMode = kCAFillModeForwards;
                [popLeft.layer addAnimation:animaLeft forKey:nil];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(durationLeft * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [popLeft removeFromSuperview];
                    popLeft = nil;
                });
                
                
                 __block YQPopverButton *popRight = self.popViews[i + 1];
                CAKeyframeAnimation *animaRight = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
                animaRight.values = @[@0,@(-4),@(topVC.view.frame.size.height * 0.8)];
                CGFloat durationRight = (count -i - 1) * 0.1;
                animaRight.duration = durationRight;
                animaRight.removedOnCompletion = NO;
                animaRight.fillMode = kCAFillModeForwards;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(durationRight * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [popRight removeFromSuperview];
                    popRight = nil;
                });
                
                [popRight.layer addAnimation:animaRight forKey:nil];
                if (i == 1)
                {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(durationLeft * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self removeFromSuperview];
                        [self.backgroundView removeFromSuperview];
                    });
                }
            }
        }

    }
    else if (animationType == YQPopverAnimationTypeBalloon)
    {
        for (NSUInteger i = 0; i < count; i++)
        {
            __block YQPopverButton *pop = self.popViews[i];
            CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
            anima.values = @[@1.3,@1.1,@1.0,@0.8,@0.5,@0.3,@0.1,@0.01];
            CGFloat duration = 0.1 + 0.1 *i;
            anima.duration = duration;
            anima.fillMode = kCAFillModeForwards;
            anima.removedOnCompletion = NO;
            [pop.layer addAnimation:anima forKey:nil];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [pop removeFromSuperview];
                pop = nil;
                if (i == count - 1)
                {
                    [self removeFromSuperview];
                    [self.backgroundView removeFromSuperview];
                }
            });
        }

    }
    else if (animationType == YQPopverAnimationTypeNone)
    {
        [self removeFromSuperview];
        [self.backgroundView removeFromSuperview];
    }
    
}

- (UIViewController *)topViewController
{
    UIViewController *topVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (topVC.presentedViewController)
    {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

- (void)setImage:(UIImage *)image withIndex:(NSInteger)index
{
    if (self.popViews.count)
    {
        YQPopverButton *pop = self.popViews[index];
        [pop setImage:image forState:UIControlStateNormal];
    }
}

- (void)setTitle:(NSString *)title withIndex:(NSInteger)index
{
    
    if (self.popViews.count)
    {
        YQPopverButton *pop = self.popViews[index];
        [pop setTitle:title forState:UIControlStateNormal];
    }
}

- (void)setTitleColor:(UIColor *)color withIndex:(NSInteger)index
{
    if (self.popViews.count)
    {
        YQPopverButton *pop = self.popViews[index];
        [pop setTitleColor:color forState:UIControlStateNormal];
    }
}

- (void)addTarget:(id)target action:(SEL)action withIndex:(NSInteger)index
{
    if (self.popViews.count) {
        YQPopverButton *pop = self.popViews[index];
        [pop addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
}


@end
