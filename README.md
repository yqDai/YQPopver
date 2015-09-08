# YQPopver
* 使用CoreAnimation制作的分享平台的各种特效
## 如何使用YQPopver
* 手动导入：
  * 将`YQPopver`文件夹中的所有文件拽入项目中
  * `import "YQPopver.h"`
  <br>
 \ /*<br>
\ * 按照指定动画显示<br>
\ */<br>
\- (void)showWithAnimationWithAnimationType:(YQPopverAnimationType)animationType;<br>
<br>
\/*<br>
\ * 按照指定动画隐藏<br>
\ */<br>
- (void)hideWithAnimationWithAnimationType:(YQPopverAnimationType)animationType;<br>
<br>
\/*<br>
\ * 设置指定位置的图片，如果不设置则按默认的显示<br>
\ */<br>
\- (void)setImage:(UIImage *)image withIndex:(NSInteger)index;<br>
<br>
\/*<br>
\ * 设置指定位置的文字，如果不设置则按默认的显示<br>
\ */<br>
\- (void)setTitle:(NSString *)title withIndex:(NSInteger)index;<br>
<br>
\/*<br>
\ * 设置指定位置的文字颜色，如果不设置则按默认的显示<br>
\ */<br>
\- (void)setTitleColor:(UIColor *)color withIndex:(NSInteger)index;<br>
<br>
\/*<br>
\ * 设置点击指定位置触发的事件<br>
\ */<br>
\- (void)addTarget:(id)target action:(SEL)action withIndex:(NSInteger)index;<br>
<br>
\/*<br>
\ * 背景View，可在背景view上添加自定义控件<br>
\ */<br>
@property (nonatomic,strong) UIView *backgroundView;<br>
<br>
\/*<br>
\ * 点击取消时popView隐藏的动画类型，如果不设置默认为YQPopverAnimationTypeNone<br>
\ */<br>
@property (nonatomic,assign) YQPopverAnimationType cancelAnimationType;<br><br><br>
![](https://github.com/yqDai/YQPopver/raw/master/YQPopver.gif)
