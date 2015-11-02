//
//  DatailViewController.m
//  BaseProject
//
//  Created by tarena on 15/10/24.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "DatailViewController.h"

@interface DatailViewController ()
@property(nonatomic,strong)NSNumber *ID;
@end

@implementation DatailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *webview =[UIWebView new];
    [self.view addSubview:webview];
    [webview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    NSString *path =[NSString stringWithFormat:@"http://cont.app.autohome.com.cn/autov5.0.0/content/news/newscontent-n%@-t0-rct1.json",_ID];
    NSURL *url =[NSURL URLWithString:path];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [webview loadRequest:request];
    
   }

-(id)initWithID:(NSNumber *)ID
{
    if (self =[super init]) {
        self.ID =ID;
    }
    return self;
}

@end
