//
//  ViewController.m
//  XJScrollDemo
//
//  Created by 肖吉 on 2017/6/27.
//  Copyright © 2017年 jamace. All rights reserved.
//

#import "ViewController.h"
#import "XJHeader.h"
#import "XJScrollView.h"
#import "FirstVc.h"
#import "SecondVc.h"
#import "ThirdVc.h"
#import "ForthVc.h"
#import "FifthVc.h"
#import "SixVc.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"首页";
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    
//    XJScrollView *scrollView = [[XJScrollView alloc] initWithFrame:CGRectMake(0, XJTabbar_Height, self.view.frame.size.width, XJScrollView_Height) titleArray:@[@"新闻",@"今日头条",@"微博",@"天上人间"] delegate:self selectIndex:0];
//    [self.view addSubview:scrollView];
    
//    XJScrollView *scrollView = [[XJScrollView alloc] initWithFrame:CGRectMake(0, XJTabbar_Height, self.view.frame.size.width, XJScrollView_Height) titleArray:@[@"新闻",@"今日头条",@"微博",@"天上人间"] selectIndex:0 selectIndexBlock:^(NSUInteger selectIndex) {
//        NSLog(@"selectIndex-------%ld",selectIndex);
//    }];
//    [self.view addSubview:scrollView];
    
//    XJScrollView *scrollView = [[XJScrollView alloc] initWithFrame:CGRectMake(0, XJTabbar_Height, XJScreen_Width, XJScrollView_Height) titleArray:@[@"新闻",@"今日头条",@"微博",@"天上人间",@"新闻",@"今日头条",@"微博",@"天上人间",@"今日头条",@"微博",@"天上人间"] delegate:self selectIndex:1 padding:10];
//    scrollView.titleScale = 1.1;
//    [self.view addSubview:scrollView];
//    self.view.backgroundColor = [UIColor orangeColor];
    
    
//    XJScrollView *scrollView = [[XJScrollView alloc] initWithFrame:CGRectMake(0, XJTabbar_Height, XJScreen_Width, XJScrollView_Height) titleArray:@[@"新闻",@"今日头条",@"微博",@"天上人间",@"新闻",@"今日头条",@"微博",@"天上人间",@"今日头条",@"微博",@"天上人间"] selectIndex:1 padding:10 selectIndexBlock:^(NSUInteger selectIndex) {
//        NSLog(@"selectIndex-------%ld",selectIndex);
//    }];
//    [self.view addSubview:scrollView];
    
    FirstVc *Vc = [[FirstVc alloc] init];
    SecondVc *Vc1 = [[SecondVc alloc] init];
    ThirdVc *Vc2 = [[ThirdVc alloc] init];
    
    ForthVc *Vc3 = [[ForthVc alloc] init];
    FifthVc *Vc4 = [[FifthVc alloc] init];
    SixVc *Vc5 = [[SixVc alloc] init];
    
    NSArray *childArray = @[Vc,Vc1,Vc2,Vc3,Vc4,Vc5];
    NSArray *titleArray = @[@"新闻",@"今日头条",@"微博",@"新闻",@"今日头条",@"微博"];
    
    XJScrollView *scrollView = [[XJScrollView alloc] initWithFrame:CGRectMake(0, XJTabbar_Height, XJScreen_Width, XJScreen_Height - XJTabbar_Height) titleArray:titleArray selectIndex:1 padding:20 childViews:childArray parentViewController:self];
    [self.view addSubview:scrollView];
//    
//    XJScrollView *scrollView = [[XJScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64) titleArray:@[@"新闻",@"今日头条",@"微博",@"新闻",@"今日头条",@"微博"] selectIndex:1 childViews:childArray parentViewController:self];
//    [self.view addSubview:scrollView];
//    
}

// XJScrollViewDelegate
-(void)XJScrollViewDidSelectIndex:(NSUInteger)selectedIndex
{
    NSLog(@"selectedIndex-------%ld",selectedIndex);
    
}

@end
