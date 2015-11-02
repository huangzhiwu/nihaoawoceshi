//
//  ViewController.m
//  BaseProject
//
//  Created by jiyingxin on 15/10/22.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "ViewController.h"
#import "ScrollDisplayViewController.h"
#import "LastNewsViewController.h"
@interface ViewController ()<SrcrollDisyplayViewControllerDelegate>
//--------------------------------------------------------  导航栏的
//创建一个滚动的视图用于头部的按钮的的滚动
@property(nonatomic,strong)UIScrollView *scrollview;
//创建一个可变的数组，放头部的按钮
@property(nonatomic,strong)NSMutableArray *buttonArr;
//按钮的滚动视图下面的那根线
@property(nonatomic,strong)UIView *lineview;
//用于保存当前选中的按钮
@property(nonatomic,strong)UIButton* currentButton;
//-------------------------------------------------------------表头的
//广告的部分的滚动
@property(nonatomic,strong)ScrollDisplayViewController *sdvc;

@end
//这个地方就是显示如何的显示和storyBorad的布局的方面一个结合
/*
 首先根据要显示的效果图，创建对应的的类型的视图
 1，创建需要显示的对应的饿视图
 
 
 */

@implementation ViewController

//在导航栏想使用一组按钮来实现点击了哪里就显示那个对应的界面

//使用懒加载初始化button数组（对应的选择的栏）
-(NSMutableArray *)buttonArr
{
    if (!_buttonArr) {
        _buttonArr =[NSMutableArray new];
    }
    return _buttonArr;
}
//使用懒加载初始化下面的view，对应的显示一个线，当点击了那个按钮它就移动到那
//个的下面，对应的按钮颜色也变为它的颜色，使用的我们自己创建的一个视图的pagectrolde 控制器,按钮是有的是滚动视图的方式
-(UIView *)lineview
{
    if (!_lineview) {
        _lineview =[UIView new];
        _lineview.backgroundColor = kRGBColor(56, 106, 198);
        
    }
    return _lineview;
}
//创建的属性里面的滚动是视图的方法，懒加载
-(UIScrollView *)scrollview
{
    if (!_scrollview) {
        _scrollview =[UIScrollView new];//cjian
        //创建一个数组，里面对应的是等下要创建的的按钮的名字，注意的是这些名子的排序要和创建的枚举的是对应页的类型位置要一样的
        //这样才能实现点击了你那一也就显示那一页的内容
        NSArray *arr=@[@"技术",@"游记",@"导购",@"评测",@"文化",@"最新",@"改装",@"行情",@"用车",@"新闻"];
        UIView *lastVeiw =nil;//指向最新添加的按钮//创建一view ,等闲把按钮放入view中 按钮的容器的
        for (int i = 0; i < arr.count; i ++) {//通过for循环创建按钮的，上面有几个按牛的的名字就创建几个按钮
            UIButton *btn =[UIButton buttonWithType:0];//对应按钮的类型
            [btn setTitle:arr[i] forState:0];//对应按钮的名字，就是上面的那些
            [btn setTitleColor:kRGBColor(89, 89, 89) forState:UIControlStateNormal];//对应的按钮的正常状态下显示到颜色（这里使用的宏函数）
            [btn setTitleColor:self.lineview.backgroundColor forState:UIControlStateSelected];//按钮子啊选择的状态的下的颜色和
            //下面设置的显得颜色一样
            //为了让开始的时候就显示的一页是显示状态，考虑等于0的情况
            if (i == 0) {
                _currentButton =btn;
                btn.selected =YES;
            }
            //写点击按钮的饿方法，这里使用的也是一个第三方库 ，block语句里面先点击要执行的方法
            [btn bk_addEventHandler:^(UIButton* sender) {
                //先判断的点击的按钮是否为当前的饿存的按钮，如果不是进入
                if (_currentButton !=sender) {
                    //将当前的按钮牛的选状态取消
                    _currentButton.selected =NO;
                    //将点击的按钮点两
                    sender.selected = YES;
                    //把点击的按钮给了当前的按钮
                    _currentButton =sender;
                  //对按钮下面的先进行布局remark的刷新改变的布局
                    [self.lineview mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.width.mas_equalTo(40);//设置的和按钮一样大
                        make.height.mas_equalTo(2);//高度小一些，看起来像一根线
                        make.centerX.mas_equalTo(sender);//中心的位置的x轴和和当前点击的按钮的位置一样，这样3就保证的等下点击的时候可以跟移动
                        make.top.mas_equalTo(sender.mas_bottom).mas_equalTo(8);//顶部的位置设置为距离按钮的位置为8
                    }];
                    //因为有小圆点的跟随的移动的这是要找到小圆的对应的位置上
                    _sdvc.currentPage =[_buttonArr indexOfObject:sender];
                }
            } forControlEvents:UIControlEventTouchUpInside];
            //把按钮加到滚动视图上面
            [_scrollview addSubview:btn];
              //对这个按钮的位置进行排布固定的布局
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(45, 24));///大小的
                make.centerY.mas_equalTo(_scrollview);//中的心y轴和滚动的一样
                if (lastVeiw) {
                    //判断view是否为空，不为空则执行下面的的布局
                    make.left.mas_equalTo(lastVeiw.mas_right).mas_equalTo(10);
                    //按钮的左边距离为10
                }
                else
                {
                    //为空的化就直接距离为 10
                    make.left.mas_equalTo(10);
                }
            }];
            //把按钮放到视图上
            lastVeiw =btn;
            //同是把按钮加入数组里面
            [self.buttonArr addObject:btn];
        }
        //lastview 肯定的最后的一个按钮，最后一个按钮的x轴 ，肯定是固定的，当我们的设置的按钮的右边缘距离父视图的contenview的右边缘距离10像素
        //那么滚动视图的内容区域就会被锁定了
        //动态的设置lastde 布局
        [lastVeiw mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_scrollview.mas_right).mas_equalTo(-10);
            //它的右边距离滚动是视图的右边为10 就是最右边加10
            
        }];
        //滚动是的用户交互的关闭
        _scrollview.showsHorizontalScrollIndicator =NO;
        //将下面的线也加入滚动视图
        [_scrollview addSubview:self.lineview];
        //设置滚动视图的约束
        [self.lineview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(2);
            UIButton *btn = _buttonArr[0];
            make.centerX.mas_equalTo(btn);
            make.top.mas_equalTo(btn.mas_bottom).mas_equalTo(8);
        }];
    }
    return _scrollview;
    

}
-(void)viewWillAppear:(BOOL)animated
{
 //即将显示的的时候有滚动视图在
    [super viewWillAppear:animated];
    self.scrollview.hidden =NO;
}
-(void)viewWillDisappear:(BOOL)animated
{
    //即将消失的时候隐藏，主要是点击计入了详细也的时候
    [super viewWillDisappear:animated];
    self.scrollview.hidden =YES;
    
}
//广告的的协议的方法的实现
-(void)scollDisplayViewController:(ScrollDisplayViewController *)scrollDisyplayViewController cureentIndex:(NSInteger)index
{
    //当先正在的按钮的的位置
    //设置为飞选择的状态
    _currentButton.selected = NO;
    //对应的广告中的数组的按钮的的第几个个给了当前的按钮
    _currentButton = _buttonArr[index];
    //但设置为选择状态
    _currentButton.selected =YES;
    //对线的刷新
    [self.lineview mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(2);
        make.centerX.mas_equalTo(_currentButton);
        make.top.mas_equalTo(_currentButton.mas_bottom).mas_equalTo(8);
    }];
    
}


-(LastNewsViewController *)lastestVCWithType:(NewsListType)type
{//调转到对应 的视图上，这是做的一个模板，加上表头，在设置先有就显示
    LastNewsViewController *vc= [kStoryboard(@"Main")instantiateViewControllerWithIdentifier:@"LastNewsViewController"];
    vc.type =type;//把带的类型给了这个视图，对应的显示视图，把所有的视图都放到一个数组中
    return vc;
}
//滚动样式的懒加载
-(ScrollDisplayViewController *)sdvc
{
    if (!_sdvc) {
        NSArray *vcs=@ [[self lastestVCWithType:NewsListTypejishu],
                        [self lastestVCWithType:NewsListTypeyouji],
                        [self lastestVCWithType:NewsListTypedaogou],
                        [self lastestVCWithType:NewsListTypepingce],
                        [self lastestVCWithType:NewsListTypewenhua],
                        [self lastestVCWithType:NewsListTypezuixin],
                        [self lastestVCWithType:NewsListTypegaizhuang],
                        [self lastestVCWithType:NewsListTypehangqing],
                        [self lastestVCWithType:NewsListTypeyongce],
                        [self lastestVCWithType:NewsListTypexinwen],
                      ];
        //设置初始状态的样式
        _sdvc= [[ScrollDisplayViewController alloc]initWithControllers:vcs];
        _sdvc.autoCycle =NO;
        _sdvc.showPageControl =NO;
        _sdvc.delegate =self;
    }

    return _sdvc;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置滚动视图的防止它释放了加入self中
    [self addChildViewController:self.sdvc];
    [self.view addSubview:self.sdvc.view];
    //设置约束
    [self.sdvc.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);//满铺
    }];
    [self.navigationController.navigationBar addSubview:self.scrollview];//加入导航栏
    [self.scrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    
    
    
}


@end
