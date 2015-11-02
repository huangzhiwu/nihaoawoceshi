//
//  NewsNetManager.h
//  BaseProject
//
//  Created by tarena on 15/10/23.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseNetManager.h"
#import "NewsModel.h"//2.1 导入model的头文件，等下网络传来的数据进行解析
//因为它有很多的页面，不可能创建10几个界面来显示他们的内容，就可以使枚举来实现对于相同相面不同内容的实现,解析也是使用的同一个方法

typedef NS_ENUM(NSUInteger, NewsListType ) {
    NewsListTypezuixin,
    NewsListTypexinwen,
    NewsListTypepingce,
    NewsListTypedaogou,
    NewsListTypehangqing,
    NewsListTypeyongce,
    NewsListTypejishu,
    NewsListTypewenhua,
    NewsListTypegaizhuang,
    NewsListTypeyouji,
};


@interface NewsNetManager : BaseNetManager
//2.2通过tpye来区分请求地址 可以先各个界面观察地址的区别，因为是别人的服务器，所以要自己找，以后公司的化，服务器的人会给我们，一般是时间 页数等一些区别
//解析网络数据的方法
+(id)getNewsListType:(NewsListType)type lasttime:(NSString *)lasttime page:(NSInteger)page complete:(void(^)(NewsModel *model,NSError *error))complete;



@end
