//
//  XJScrollView.h
//  XJScrollDemo
//
//  Created by 肖吉 on 2017/6/27.
//  Copyright © 2017年 jamace. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^selectIndexBlock)(NSUInteger selectIndex);

//代理方法回调选中的下标
@protocol XJScrollViewDelegate <NSObject>
//选中了某个下标
-(void)XJScrollViewDidSelectIndex:(NSUInteger)selectedIndex;
@end
@interface XJScrollView : UIView

/**
 代理初始化方法
 @param frame frame
 @param titleArray titleArray
 @param delegate delegate
 @param selectIndex selectIndex
 @return self
 */
-(instancetype) initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray delegate:(id)delegate selectIndex:(NSUInteger)selectIndex;

/**
 block初始化方法

 @param frame frame
 @param titleArray titleArray
 @param selectIndex selectIndex
 @param block block
 @return self
 */
-(instancetype) initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray selectIndex:(NSUInteger)selectIndex selectIndexBlock:(selectIndexBlock)block;

/**
 delegate按钮的宽度由padding决定

 @param frame frame
 @param titleArray titleArray
 @param delegate delegate
 @param selectIndex selectIndex
 @param padding padding
 @return self
 */
-(instancetype) initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray delegate:(id)delegate selectIndex:(NSUInteger)selectIndex padding:(CGFloat)padding;

/**
 block按钮的宽度由padding决定

 @param frame frame
 @param titleArray titleArray
 @param selectIndex selectIndex
 @param padding padding
 @return self
 */
-(instancetype) initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray selectIndex:(NSUInteger)selectIndex  padding:(CGFloat)padding selectIndexBlock:(selectIndexBlock)block;

/**
 padding带底部滑动的视图

 @param frame frame
 @param titleArray titleArray
 @param selectIndex selectIndex
 @param padding padding
 @param childViews childViews
 @param parentVc parentVc
 @return self
 */
-(instancetype) initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray selectIndex:(NSUInteger)selectIndex padding:(CGFloat)padding childViews:(NSArray *)childViews parentViewController:(UIViewController *)parentVc;

/**
 无padding带底部滚动的视图

 @param frame frame
 @param titleArray titleArray
 @param selectIndex selectIndex
 @param childViews childViews
 @param parentVc parentVc
 @return self
 */
-(instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray selectIndex:(NSUInteger)selectIndex childViews:(NSArray *)childViews parentViewController:(UIViewController *)parentVc;

//代理
@property (nonatomic, assign) id<XJScrollViewDelegate>delegate;
//数据源
@property (nonatomic, strong) NSArray *titleArray;
//默认选中的下标
@property (nonatomic, assign) NSUInteger selectIndex;
//block方式回调选中的下标
@property (nonatomic, copy) selectIndexBlock block;
//自定义padding
@property (nonatomic, assign) CGFloat padding;
//title缩放比例
@property (nonatomic, assign) CGFloat titleScale;
//子视图array
@property (nonatomic, strong) NSArray *childViews;
//父viewController
@property (nonatomic, weak) UIViewController *parentVc;
@end
