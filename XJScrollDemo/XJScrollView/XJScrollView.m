//
//  XJScrollView.m
//  XJScrollDemo
//
//  Created by 肖吉 on 2017/6/27.
//  Copyright © 2017年 jamace. All rights reserved.
//

#import "XJScrollView.h"
#import "XJHeader.h"

@interface XJScrollView()<UIScrollViewDelegate>

@property (nonatomic ,strong) UIScrollView *scrollView;             ///<背景滚动视图
@property (nonatomic, strong) UIView *indicatorView;                ///<底部线
@property (nonatomic, strong) NSMutableArray *sizeArray;            ///<每个线条的长度
@property (nonatomic, strong) NSMutableArray *paddingArray;         ///<padding
@property (nonatomic, strong) UIButton *selectedBtn;                ///<上一个选中的btn
@property (nonatomic, strong) UIScrollView *buttomScrollView;       ///<底部滚动视图
@end
@implementation XJScrollView

//初始化带padding的delegate视图滚动
-(instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray delegate:(id)delegate selectIndex:(NSUInteger)selectIndex
{
    if (self = [super initWithFrame:frame]) {
        self.titleArray = titleArray;
        self.delegate = delegate;
        self.selectIndex = selectIndex;
        //初始化UI
        [self initView];
    }
    return self;
}
//初始化带padding的block视图滚动
-(instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray selectIndex:(NSUInteger)selectIndex selectIndexBlock:(selectIndexBlock)block
{
    if (self = [super initWithFrame:frame]) {
        self.titleArray = titleArray;
        self.block = block;
        self.selectIndex = selectIndex;
        //初始化UI
        [self initView];
    }
    return self;
}
//初始化子视图滚动
-(instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray selectIndex:(NSUInteger)selectIndex childViews:(NSArray *)childViews parentViewController:(UIViewController *)parentVc
{
    if (self = [super initWithFrame:frame]) {
        self.parentVc = parentVc;
        self.childViews = childViews;
        self.titleArray = titleArray;
        self.selectIndex = selectIndex;
        //初始化UI
        [self initView];
    }
    return self;
}
//初始化带padding的delegate视图滚动
-(instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray delegate:(id)delegate selectIndex:(NSUInteger)selectIndex padding:(CGFloat)padding
{
    if (self = [super initWithFrame:frame]) {
        self.titleArray = titleArray;
        self.delegate = delegate;
        self.selectIndex = selectIndex;
        self.padding = padding;
        //初始化UI
        [self initPaddingView];
    }
    return self;
}
//初始化带padding的block视图滚动
-(instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray selectIndex:(NSUInteger)selectIndex padding:(CGFloat)padding selectIndexBlock:(selectIndexBlock)block
{
    if (self = [super initWithFrame:frame]) {
        self.titleArray = titleArray;
        self.block = block;
        self.selectIndex = selectIndex;
        self.padding = padding;
        //初始化UI
        [self initPaddingView];
    }
    return self;
}
//初始化带padding的子视图滚动
-(instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray selectIndex:(NSUInteger)selectIndex padding:(CGFloat)padding childViews:(NSArray *)childViews parentViewController:(UIViewController *)parentVc
{
    if (self = [super initWithFrame:frame]) {
        self.parentVc = parentVc;
        self.childViews = childViews;
        self.titleArray = titleArray;
        self.selectIndex = selectIndex;
        self.padding = padding;
        //初始化UI
        [self initPaddingView];
    }
    return self;
}

//初始化normalView
-(void)initView
{
    //滑动视图
    [self addSubview:self.scrollView];
    //按钮的宽度
    CGFloat btnWidth = XJScreen_Width / self.titleArray.count;
    //布局
    for (int i = 0; i < self.titleArray.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = Btn_Tag+i;
        btn.frame = CGRectMake(btnWidth*i, 0, btnWidth, XJScrollView_Height);
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitle:self.titleArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:Default_Color forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(changeIndex:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:btn];
        
        if (i == self.selectIndex) {
            [btn setTitleColor:Selected_Color forState:UIControlStateNormal];
            self.selectedBtn = btn;
        }
        
        CGSize indicatorSize = [self currentSizeWithStr:self.titleArray[i] withFont:15 andHeight:XJScrollView_Height];
        //保存每个title的长度（线条的长度）
        [self.sizeArray addObject:[NSNumber numberWithFloat:indicatorSize.width]];
        
        CGFloat padding = (btnWidth - indicatorSize.width) / 2.0f;
        //边距
        [self.paddingArray addObject:[NSNumber numberWithFloat:btnWidth*i+padding]];
    }
    //线条视图
    [self.scrollView addSubview:self.indicatorView];
    //更新线条的位置
    [self updateIndicatorViewPosotion:self.selectedBtn];
    
    //底部滚动视图
    [self addButtomSubViews];
}
//初始化paddingView
-(void)initPaddingView
{
    //滑动视图
    [self addSubview:self.scrollView];
    CGFloat leftPadding = 0.0f;
    //布局
    for (int i = 0; i < self.titleArray.count; i++) {
        //字体的长度
        CGSize indicatorSize = [self currentSizeWithStr:self.titleArray[i] withFont:15 andHeight:XJScrollView_Height];
        //按钮的宽度
        CGFloat btnWidth = indicatorSize.width + 2*self.padding;
        leftPadding = leftPadding + btnWidth;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = Btn_Tag+i;
        btn.frame = CGRectMake(leftPadding - btnWidth, 0, btnWidth, XJScrollView_Height);
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitle:self.titleArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:Default_Color forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(changeIndex:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:btn];
        
        if (i == self.selectIndex) {
            [btn setTitleColor:Selected_Color forState:UIControlStateNormal];
            self.selectedBtn = btn;
        }
        
        //保存每个title的长度（线条的长度）
        [self.sizeArray addObject:[NSNumber numberWithFloat:indicatorSize.width]];
        
        CGFloat padding = (btnWidth - indicatorSize.width) / 2.0f;
        //边距
        [self.paddingArray addObject:[NSNumber numberWithFloat:leftPadding - btnWidth+padding]];
    }
    //线条视图
    [self.scrollView addSubview:self.indicatorView];
    self.scrollView.contentSize = CGSizeMake(leftPadding, XJScrollView_Height);
    //更新线条的位置
    [self updateIndicatorViewPosotion:self.selectedBtn];
    
    //底部滚动视图
    [self addButtomSubViews];

}
//初始化地图滚动视图
-(void)addButtomSubViews
{
    if (!self.childViews.count) {
        return;
    }
    //添加底部滚动视图
    [self addSubview:self.buttomScrollView];
    for (int i = 0; i < self.childViews.count; i++) {
        if ([self.childViews[i] isKindOfClass:[UIViewController class]]) {
            //将子控制器的view添加到bottomView上
            UIViewController *childViewController = self.childViews[i];
            [self.parentVc addChildViewController:childViewController];
            childViewController.view.frame = CGRectMake(XJScreen_Width*i, 0, XJScreen_Width, self.buttomScrollView.frame.size.height);
            //为了区分，随机给子view取色
            childViewController.view.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0f green:arc4random()%255/255.0f blue:arc4random()%255/255.0f alpha:1];
            [self.buttomScrollView addSubview:childViewController.view];
        }
    }
    //设置buttomScrollView的容量
    self.buttomScrollView.contentSize = CGSizeMake(self.frame.size.width*self.childViews.count, self.buttomScrollView.frame.size.height);

}
//改变线条的位置
-(void)updateIndicatorViewPosotion:(UIButton *)sender
{
    //线条的位置
    CGFloat currentPadding = [self.paddingArray[self.selectIndex] floatValue];
    //当前点击的btn的中心位置
    CGFloat currentCenter = currentPadding+([self.sizeArray[self.selectIndex] floatValue])/2.0f;
    //屏幕中心点
    CGFloat screenCenter = XJScreen_Width /2.0f;
    //最后几个item的判断
    CGFloat lastCenter = self.scrollView.contentSize.width - currentCenter;
    
    [UIView animateWithDuration:0.25 animations:^{
        //改变线条的位置
        self.indicatorView.frame = CGRectMake(currentPadding, XJScrollView_Height - Indicator_Height, [self.sizeArray[self.selectIndex] floatValue], Indicator_Height);
        //设置按钮的字体缩放
        self.selectedBtn.transform = CGAffineTransformMakeScale(1.0, 1.0);
        sender.transform = CGAffineTransformMakeScale(self.titleScale?self.titleScale:1.0, self.titleScale?self.titleScale:1.0);
        self.selectedBtn = sender;
        //设置底部buttomScrollView的偏移量
        if (self.childViews.count) {
            self.buttomScrollView.contentOffset = CGPointMake(XJScreen_Width*self.selectIndex, 0);
        }
        //如果scrollView的容量充不满屏幕就不做scrollView的偏移
        if (self.scrollView.contentSize.width < self.frame.size.width) {
            return;
        }
        //判断scrollView的偏移
        if (lastCenter > screenCenter) {
            if (currentCenter > screenCenter) {
                self.scrollView.contentOffset = CGPointMake(currentCenter - screenCenter, 0);
            }else{
                self.scrollView.contentOffset = CGPointMake(0, 0);
            }
        }else{
             self.scrollView.contentOffset = CGPointMake(self.scrollView.contentSize.width - 2*screenCenter, 0);
        }
    }];

}
//改变选中的下标
-(void)changeIndex:(UIButton *)btn
{
    if (self.selectIndex == btn.tag - Btn_Tag) {
        return;
    }
    //记住选中的下标
    self.selectIndex = btn.tag - Btn_Tag;
    //选中的btn颜色
    [btn setTitleColor:Selected_Color forState:UIControlStateNormal];
    //未被选中的btn颜色
    [self.selectedBtn setTitleColor:Default_Color forState:UIControlStateNormal];
    //记住上次选中的btn
    //更新线条的位置
    [self updateIndicatorViewPosotion:btn];
    
    if ([self.delegate respondsToSelector:@selector(XJScrollViewDidSelectIndex:)]) {
        //代理方法
        [self.delegate XJScrollViewDidSelectIndex:self.selectIndex];
    }else{
        //block方式
        if (self.block) {
            self.block(self.selectIndex);
        }
    }
}
///滚动视图代理
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _selectIndex =  scrollView.contentOffset.x/XJScreen_Width;
    for (UIButton *btn in self.scrollView.subviews) {
        if (btn.tag == Btn_Tag+_selectIndex) {
            [btn setTitleColor:Selected_Color forState:UIControlStateNormal];
            //未被选中的btn颜色
            [self.selectedBtn setTitleColor:Default_Color forState:UIControlStateNormal];
            [self updateIndicatorViewPosotion:btn];
        }
    }
}

//set方法设置scale
-(void)setTitleScale:(CGFloat)titleScale
{
    _titleScale = titleScale;
    [self updateIndicatorViewPosotion:self.selectedBtn];
}
//线条视图
-(UIView *)indicatorView
{
    if (!_indicatorView) {
        _indicatorView  = [[UIView alloc] init];
        _indicatorView.backgroundColor = Selected_Color;
    }
    return _indicatorView;
}
//左边距数组
-(NSMutableArray *)paddingArray
{
    if (!_paddingArray) {
        _paddingArray = [[NSMutableArray alloc] init];
    }
    return _paddingArray;
}
//线条宽度数组
-(NSMutableArray *)sizeArray
{
    if (!_sizeArray) {
        _sizeArray = [[NSMutableArray alloc] init];
    }
    return _sizeArray;
}
//头部滑动视图
-(UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, XJScreen_Width, XJScrollView_Height)];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.backgroundColor = [UIColor whiteColor];
    }
    return _scrollView;
}
//底部滑动视图
-(UIScrollView *)buttomScrollView
{
    if (!_buttomScrollView) {
        _buttomScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,XJScrollView_Height,XJScreen_Width, self.frame.size.height - XJScrollView_Height)];
        _buttomScrollView.delegate = self;
        _buttomScrollView.pagingEnabled = YES;
        _buttomScrollView.showsVerticalScrollIndicator = NO;
        _buttomScrollView.showsHorizontalScrollIndicator = NO;
        _buttomScrollView.backgroundColor = [UIColor orangeColor];
    }
    return _buttomScrollView;

}
//当前字符串的高度
-(CGSize)currentSizeWithStr:(NSString*)Str withFont:(int)font andHeight:(float)height
{
    CGSize currentSize;
    //iOS7之后有新的计算方法
    //拿到操作系统版本号
    NSString* version=[UIDevice currentDevice].systemVersion;
    if ([version floatValue]>=7.0) {
        //7以后
        //带有字体属性的字典
        NSDictionary* dic=[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font],NSFontAttributeName, nil];
        /*
         NSStringDrawingTruncatesLastVisibleLine + NSStringDrawingUsesLineFragmentOrigin 相当于字节换行方式,
         NSStringDrawingUsesFontLeading 计算字体
         */
        currentSize= [Str boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    }else
    {
        // 7以前
        //字符串根据条件计算自身size的方法  font  字体和字号  lineBreakMode  换行方式   constrainedToSize  制定计算范围(横向和纵向计算的最大值)
        currentSize= [Str sizeWithFont:[UIFont systemFontOfSize:font] constrainedToSize:CGSizeMake(MAXFLOAT, height) lineBreakMode:NSLineBreakByCharWrapping];
        
    }
    
    return currentSize;
}
@end
