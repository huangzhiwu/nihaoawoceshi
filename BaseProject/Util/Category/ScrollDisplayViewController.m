//
//  ScrollDisplayViewController.m
//  BaseProject
//
//  Created by tarena on 15/10/24.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "ScrollDisplayViewController.h"

@interface ScrollDisplayViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource>

@end

@implementation ScrollDisplayViewController
//传入的是图片的地址数组的初始化方法
-(instancetype)initWithPaths:(NSArray *)paths
{
    //路径的类型可能是NSurl Http:// ,https:// 本地路径，和未知路径
    NSMutableArray *arr = [NSMutableArray new];
    for (int i = 0; i < paths.count; i ++) {
        id path = paths[i];
        //
       //UIImageView *imageview =[UIImageView new];
        //为了监控用户的点击操作
        UIButton *button = [UIButton buttonWithType:0];
        //要根据情况来写
        if([self isURL:path])//
        {
            [button sd_setBackgroundImageWithURL:path forState:0];
           // [imageview sd_setImageWithURL:path];
        }else if([self isNetPath:path])//网络
        {
            NSURL *url = [NSURL URLWithString:path];
            [button sd_setBackgroundImageWithURL:url forState:0];
           // [imageview sd_setImageWithURL:url];
        }else if([path isKindOfClass:[NSString class]])
        {
            NSURL *url =[NSURL fileURLWithPath:path];//本地
            [button sd_setBackgroundImageWithURL:url forState:0];
           // [imageview sd_setImageWithURL:url];
        }else
        {
            [button setImage:[UIImage imageNamed:@"error@3x"] forState:0];
            //imageview.image =[UIImage imageNamed:@"error@3x"];
        
        }
        UIViewController *vc =[UIViewController new];
        vc.view = button;
        button.tag =1000 +i;
        [button bk_addEventHandler:^(UIButton *sender) {
            [self.delegate scollDisplayViewController:self didSelected:sender.tag-1000];
        } forControlEvents:UIControlEventTouchUpInside];
        [arr addObject:vc];
    }
    self= [self initWithControllers:arr];
    return self;
}
/**
 这部分是上面对传入地址类型的一个分辨......>>>>>>>>>>>>>>>start
 */
-(BOOL)isURL:(id)path
{
    return [path isKindOfClass:[NSURL class]];
}
-(BOOL)isNetPath:(id)path
{
//判断是否是网络路径http:// https://
    BOOL isStr =[path isKindOfClass:[NSString class]];
    //为了防止非string类型的调用的下面的方法崩溃
    if (!isStr) {
        return NO;
    }
    BOOL containHttp = [path rangeOfString:@"http"].location !=NSNotFound;
    BOOL contianTitle =[path rangeOfString:@"//"].location !=NSNotFound;
    return isStr && containHttp && contianTitle;//简写的时候
}
//---------------------------------------------------end
//对于传入的图片的名字的数组
-(instancetype)initWithImageName:(NSArray *)names
{
    //创建一个可变的数组用来接收
    NSMutableArray *arr =[NSMutableArray new];
    for (int i = 0; i < names.count; i ++) {
        //创建一个uiiamge
        UIImage *img =[UIImage imageNamed:names[i]];
        //UIImageView *iv =[[UIImageView alloc]initWithImage:img];//图片的显示
        //如果滚动的视图不要点进入如的的要求就使用上面的，要点击的操作的话设置为按钮
        UIButton *button =[UIButton buttonWithType:0];
        //这只button的背景图
        [button setBackgroundImage:img forState:0];
        //创建一vc
        UIViewController *vc =[UIViewController new];
        vc.view = button;//把按钮放在视图view上，这样也可以，也可以以前的add..
        //设置先按钮的特别标识，可以在等下点击的时候可以知道点击了哪一个，这样就不用在viewxib里面创建了
        button.tag =1000 +i ;
        //设置按钮的触发事件。使用的是第三方库的
        [button bk_addEventHandler:^(UIButton* sender) {
            [self.delegate scollDisplayViewController:self didSelected:sender.tag -1000];
        } forControlEvents:UIControlEventTouchUpInside];
        //再把它放入数组.一直循环下去
        [arr addObject:vc];
        
    }
    if (self =[self initWithControllers:arr]) {
    }

    
    return self;
}
//属性初始化方法的重写
-(instancetype)initWithControllers:(NSArray *)conttrollers
{
    
 if(self =[super init])
 {
    _controllers =[conttrollers copy];//复制一份出来为了防止参数的是可变的数组，这样可以保证属性不会因为可变数组在外部被修改，而导致随之也被修改
     //设置滚动视图的的一些初始状态
     _autoCycle = YES;
     _canCycle =YES;
     _showPageControl =YES;
     _duration =3;
     _pageControlOffset =0;
 }
    return self;
}


//重写属性showPagecontrol的set方法：是否显示当前页 默认是YES   ------------------------------
-(void)setShowPageControl:(BOOL)showPageControl
{
    _showPageControl =showPageControl;
    _pageControl.hidden =!showPageControl;//小圆点是否显示，默认是显示，也就是不隐藏
}
//PageControlOffset方法 ：设置页数的垂直的偏移量，整数向下移动
-(void)setPageControlOffset:(CGFloat)pageControlOffset//小圆点的位置更距离下面面的位置和
{
//更新页面的数量的控件 bottom 约束随着更新的update
    [_pageControl mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_pageControlOffset);
    }];
}
//CurrentPape的set方法 ：当前的页数
-(void)setCurrentPage:(NSInteger)currentPage
{
    _currentPage =currentPage;
    UIViewController *vc =_controllers[currentPage];
    [_pageviewcontroller setViewControllers:@[vc] direction:0 animated:YES completion:nil];
}
//重写属性Duration的set方法 ：是否设置定时滚动，默认是
-(void)setDuration:(NSTimeInterval)duration
{
    _duration =duration;
    self.autoCycle =_autoCycle;
}
//autoCycle的定时方法 是否设置循环滚动
-(void)setAutoCycle:(BOOL)autoCycle
{
    _autoCycle =autoCycle;
    [_timer invalidate];
    if(!autoCycle)
    {
        return;
    }
    //时间的设置
    _timer =[NSTimer bk_timerWithTimeInterval:_duration block:^(NSTimer *timer) {
        UIViewController *vc =_pageviewcontroller.viewControllers.firstObject;
        NSInteger index =[_controllers indexOfObject:vc];
        UIViewController *nextVC =nil;
        if (index == _controllers.count -1) {
            if (!_canCycle) {
                return ;
            }
            nextVC =_controllers.firstObject;
        }else
        {
            nextVC =_controllers[index + 1];
        }
        __block ScrollDisplayViewController *vc1 =self;
        [_pageviewcontroller setViewControllers:@[nextVC] direction:0 animated:YES completion:^(BOOL finished) {
            DDLogVerbose(@"%@",[NSThread currentThread]);
            [vc1 configPageControl];
        }];
    } repeats:YES];
}
//小圆点的设置
-(void)configPageControl{
//操作圆点位置
    NSInteger index =[_controllers indexOfObject:_pageviewcontroller.viewControllers.firstObject];
    _pageControl.currentPage =index;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  //如果控制器数组什么都没有或者为空
    if(!_controllers || _controllers.count == 0)
    {
        return;
    }
    //设置page view控制器为滚动样式，横向的
    _pageviewcontroller =[[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll|1 navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal|0 options:nil];
    //设置page视图控制器代理
    _pageviewcontroller.delegate =self;
    _pageviewcontroller.dataSource =self;
    //把page视图控制器加入到view子控制器上，在把它的view加入slef.view上
    [self addChildViewController:_pageviewcontroller];//保持它的引用，防止它释放了
    [self.view addSubview:_pageviewcontroller.view];//加入到视图
    //使用pod布局需要引入Masonsy 第三方类库设置它的约束
    [_pageviewcontroller.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);//满铺的在整个view上面
    }];
    //设置当为第一页的时候，就显示，就开始
    [_pageviewcontroller setViewControllers:@[_controllers.firstObject] direction:0 animated:YES completion:nil];
    //在创建一个小圆点的视图
    _pageControl =[UIPageControl new];
    //设置小圆点的个数等于这个数组的个数
    _pageControl.numberOfPages = _controllers.count;
    //加入视图，它是在头部设置了一个视图的显示，要先加入上去才能，设置约束
    [self.view addSubview:_pageControl];
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);//设置他的中心位置x 和视图一样，距离下面底部为0
        make.bottom.mas_equalTo(0);
    }];
    //关闭用户的交互
    _pageControl.userInteractionEnabled =NO;
    //把外面的初始化的值传入给它
    self.autoCycle =_autoCycle;//是否循环
    self.showPageControl =_showPageControl;//是否显示也
    self.pageControlOffset =_pageControlOffset;
    
}

//实现协议的方法-----------------------------------------------------
//滚动前的控制器
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger index= [_controllers indexOfObject:viewController];
    if (index == 0) {
        return _canCycle?_controllers.lastObject:nil;
    }
    return _controllers[index -1];

}
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger index =[_controllers indexOfObject:viewController];
    if (index == _controllers.count -1) {
        return _canCycle?_controllers.firstObject:nil;
    }
    return _controllers[index +1];

}

@end
