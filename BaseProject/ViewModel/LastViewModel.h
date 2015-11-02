//
//  LastViewModel.h
//  BaseProject
//
//  Created by tarena on 15/10/23.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"
#import "NewsNetManager.h"
//3.viewmodel 界面上显示的
@interface LastViewModel : BaseViewModel

//主要的视图
//model
//由于是表格，肯定要行的
//属性
@property(nonatomic)NSInteger rowNumber;
//分页加载需要有可变的数组，把滚动的过了数组放入，滚动出的时候方便取出
@property(strong ,nonatomic)NSMutableArray *dataArr;
//表头的视图的也用一个数组来存放，就可以使用不可变的数组就行
@property(strong,nonatomic)NSArray *headImagArr;
//方法
//接收图片的方法，而且要带上一个参数，对应行的,接收是网上下载的一个图片地址，在加载的时候，所以是字符串类型的
-(NSURL *)iconForRow:(NSInteger)row;
//接收标题方法
-(NSString *)titleForRow:(NSInteger)row;
//时间的
-(NSString *)timeForRow:(NSInteger)row;
//评论的
-(NSString *)commentForRow:(NSInteger)row;

//最后详细也的加的
-(NSNumber *)IDForRow:(NSInteger)row;

//网络层
//解析数据是根据的是时间time 和  分页page 来确定的所以也需要这两个属性，还有type
//因为网络解析方法里面有这几个属性，这里需要有这几个属性
//页的类型
@property(nonatomic)NewsListType type;
//时间
@property(nonatomic,strong)NSString* time;
//页
@property(nonatomic)NSInteger page;
//方法
//获取类型的方法
-(id)initWithNewsListType:(NewsListType )type;
//刷新
-(void)refreshDataComplete:(void(^)( NSError *))complete;
//更多
-(void)getMoreDataComplete:(void(^)(NSError *))complete;








@end
