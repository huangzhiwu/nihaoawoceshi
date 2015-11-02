//
//  NewsNetManager.m
//  BaseProject
//
//  Created by tarena on 15/10/23.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "NewsNetManager.h"

@implementation NewsNetManager
//2.3
+(id)getNewsListType:(NewsListType)type lasttime:(NSString *)time page:(NSInteger)page complete:(void (^)(NewsModel *, NSError *))complete
{
//一个属性接收地址
    NSString *path = nil;
    //使用是swtich,当viewmodel里面传来的值是什么就到这里响应的找到对应的解析再到model层
    switch (type) {
    
        case NewsListTypejishu:
             path=[NSString stringWithFormat:@"http://app.api.autohome.com.cn/autov5.0.0/news/newslist-pm1-c0-nt102-p%@-s30-l%@.json", @(page), time];
            break;
        case NewsListTypeyouji:
         path=[NSString stringWithFormat:@"http://app.api.autohome.com.cn/autov5.0.0/news/newslist-pm1-c0-nt100-p%@-s30-l%@.json", @(page), time];
            break;
            
        case NewsListTypedaogou:
          path=[NSString stringWithFormat:@"http://app.api.autohome.com.cn/autov5.0.0/news/newslist-pm1-c0-nt60-p%@-s30-l%@.json", @(page), time];
            break;
            
        case NewsListTypepingce:
            path=[NSString stringWithFormat:@"http://app.api.autohome.com.cn/autov5.0.0/news/newslist-pm1-c0-nt3-p%@-s30-l%@.json", @(page), time];
            break;
            
        case NewsListTypewenhua:
            path=[NSString stringWithFormat:@"http://app.api.autohome.com.cn/autov5.0.0/news/newslist-pm1-c0-nt97-p%@-s30-l%@.json", @(page), time];
            break;
            
        case NewsListTypexinwen:
             path=[NSString stringWithFormat:@"http://app.api.autohome.com.cn/autov5.0.0/news/newslist-pm1-c0-nt1-p%@-s30-l%@.json", @(page), time];
            break;
            
        case NewsListTypeyongce:
            path=[NSString stringWithFormat:@"http://app.api.autohome.com.cn/autov5.0.0/news/newslist-pm1-c0-nt0-p%@-s30-l%@.json", @(page), time];
            break;
        case NewsListTypezuixin:
            path=[NSString stringWithFormat:@"http://app.api.autohome.com.cn/autov5.0.0/news/newslist-pm1-c0-nt82-p%@-s30-l%@.json", @(page), time];
            break;
            
        case NewsListTypehangqing:
             path=[NSString stringWithFormat:@"http://app.api.autohome.com.cn/autov5.0.0/news/newslist-pm1-c110100-nt2-p%@-s30-l%@.json", @(page), time];
            break;
            
        case NewsListTypegaizhuang:
            path=[NSString stringWithFormat:@"http://app.api.autohome.com.cn/autov5.0.0/news/newslist-pm1-c0-nt107-p%@-s30-l%@.json", @(page), time];
            break;
        default:
            break;
    }
    
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        complete([NewsModel objectWithKeyValues:responseObj],error);
    }];

}
@end
