//
//  LastViewModel.m
//  BaseProject
//
//  Created by tarena on 15/10/23.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "LastViewModel.h"

@implementation LastViewModel

//网络层的方法实现

//typed的初始化方法
-(id)initWithNewsListType:(NewsListType )type
{
if(self = [super init])
{
    _type =type;
}
    return self;
}

//刷新
-(void)refreshDataComplete:(void (^)( NSError*))complete
{   _time=@"0";//开始的通过时间得到对于的的地址开始的时候就是这个地址，页数是第一页，等下更新 的时候就加1
    _page =1;
    [self getDataComplete:complete];//调用更新的公共的方法
    
}
//更多
-(void)getMoreDataComplete:(void (^)( NSError *))complete
{
    NewsResultNewslistModel *obj =self.dataArr.lastObject;//拿到这个的当前位置，也就是这个数组的最后的那根位置的对象
    _time =obj.time;//把时间的那个属性给了它
    _page += 1;//加载更多就是加1，展示更多的页
    [self getDataComplete:complete];//
 
}
//他们公有方法
-(void)getDataComplete:(void (^)(NSError *))complete
{
//对应的要刷新的界面网络解析的 对应的那一页， 时间的类型的 页数的 ，来确定的对应的数 拿到了就放在model里面，此时model是有数据的
    [NewsNetManager getNewsListType:_type lasttime:_time page:_page complete:^(NewsModel *model, NSError *error) {
        if ([_time isEqualToString:@"0"]) {
            [self.dataArr removeAllObjects];
        }
        //如果time = 0说明说有
        //把model数据的对应的等下要用的数据给了定义那个数组
            [self.dataArr addObjectsFromArray:model.result.anewslist];
        //创建一个可变的数组表头的图片的
        NSMutableArray *imgArr = [NSMutableArray new];
        //下面的是对应的标头的广告的数据图片，可以从这里取
        for (NewsResultFocusimgModel *obj in model.result.focusimg) {
            NSURL *imageurl = [NSURL URLWithString:obj.imgurl];
            [imgArr addObject:imageurl];
        }
        //把数据给了一个专门用来接收对应数据的图片上的数组
        self.headImagArr = [imgArr copy];
        complete(error);
       
        
    }];
}

// 先从网络层拿到数据，在到model层将对应的数据的给值view层对应的 ，当是他们都是在视图曾对额东西，他们的一个顺序是：首先通过控制层启动进入页面加入页面——》然后网络刷新要把数据显示出来的（就是进入viewmodel层，先通过网络的刷新操作 在VM的网络面代码获取界面的的通过一些参数获取当前对应区别界面的的参数组合成对应的网络的地址，再到网络类中找到对应的方法解析判断是属于那个类型的解析为json数据，再通过去model类中中进行对应的解析，得到对应的model的数据)--(在回到viewmodel里面，在网络代码段将数据给了事先创建的数组，)---（再到viewmodel的model断的代码段，创建在视图的层对应的需要的一些属性，和获得图片，数字的一些方法）--（通过每个方法带上一他们自己对应的行的参数等下可以在vc中对应的给他们对应的行）-（把对应的行的这些类的属性放这个书里面，使用方法的他的返回性的是个model ,把数组对应的行的model给了他）--在同点形式获取对应的值 ------》在回到控制器，在对应的地方diangviewmodel层的这个方法得到对应的值会了对显示的值 （会有些在创建的view类型 ，故事板可以找规律的进行实现）

//model层的方法实现
//先对数组懒加载
-(NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr =[NSMutableArray new];
    }
    return _dataArr;
}
//行数的初始化
-(NSInteger)rowNumber
{
    return self.dataArr.count;
}
//获取每行的数据，也是一个对应的对象的
-(NewsResultNewslistModel *)ModelForRow:(NSInteger)row
{
    return self.dataArr[row];
}
//获取图片
-(NSURL *)iconForRow:(NSInteger)row
{
    return [NSURL URLWithString:[self ModelForRow:row].smallpic];
}
//获取对应的标题
-(NSString *)titleForRow:(NSInteger)row
{
    return [self ModelForRow:row].title;
}
//获取对应的而时间
-(NSString *)timeForRow:(NSInteger)row
{
    return [self ModelForRow:row].time;
}
//对应的评论数的vlaue值并拼接字符串
-(NSString *)commentForRow:(NSInteger)row
{
    return [[self ModelForRow: row].replycount.stringValue stringByAppendingString:@"评论"];
}
//Id根据定义的id来区别选的那g,因为每页里面都有一个自己的id,可以用来切换页面
-(NSNumber *)IDForRow:(NSInteger)row
{
    return [self ModelForRow:row].ID;
}



@end
