//
//  ScrollDisplayViewController.h
//  BaseProject
//
//  Created by tarena on 15/10/24.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
//使用网络图片的，需要引入SDWebImage,
#import <UIImageView+WebCache.h>
#import <UIButton+WebCache.h>
//定义一个协议用于实现的方法
@class ScrollDisplayViewController;
@protocol SrcrollDisyplayViewControllerDelegate <NSObject>

@optional
//当用户点击了每一项触发
-(void)scollDisplayViewController:(ScrollDisplayViewController *)scrollDisyplayViewController didSelected:(NSInteger)index;//一个是选择的行的参数，一个是它自己的
//时时回传当前的索引的值
-(void)scollDisplayViewController:(ScrollDisplayViewController *)scrollDisyplayViewController cureentIndex:(NSInteger)index;


@end


@interface ScrollDisplayViewController : UIViewController
{
//设置一个参数用于定时的
    NSTimer *_timer;
}
//....
//在定义属性，遵守协议
@property(nonatomic,strong)id<SrcrollDisyplayViewControllerDelegate>delegate;

//定义一个用于接收图片地址的数组的
@property(strong,nonatomic)NSArray *paths;
//接收图片名字的数组
@property(strong,nonatomic)NSArray *names;
//接收视图控制器的
@property(strong,nonatomic)NSArray *controllers;
//传入的形式图片地址的数组，传入图片名字的数组、、传入视图控制器
//传入图片地址数组,使用一个方法进行接收
-(instancetype)initWithPaths:(NSArray *)paths;
//传入的图片的名字的数组
-(instancetype)initWithImageName:(NSArray *)names;
//传入视图控制器
-(instancetype)initWithControllers:(NSArray *)conttrollers;

//设置下面对小圆点
//属性
//s滚动视图控制器属性
@property(nonatomic,strong)UIPageViewController* pageviewcontroller;
//圆点的
@property(nonatomic,strong)UIPageControl *pageControl;
//设置是否循环的滚动默认的为YES ，表示可以循环
@property(nonatomic)BOOL canCycle;
//设置是否定时的滚动的默认为YES，表示可以定时滚动
@property(nonatomic)BOOL autoCycle;
//滚动的时间 默认为3秒
@property(nonatomic)NSTimeInterval duration;
//是否显示当前的页数，默认为YES 显示
@property(nonatomic)BOOL showPageControl;
//当前的页数
@property(nonatomic)NSInteger currentPage;
//设置页数显示的垂直偏移量，正数表示向下移动的
@property(nonatomic)CGFloat pageControlOffset;
//显示圆点的颜色
//显示原点高亮的颜色





//在滚动栏的图片来源本地，网络：


@end
