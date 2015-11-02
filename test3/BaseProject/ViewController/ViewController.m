//
//  ViewController.m
//  BaseProject
//
//  Created by jiyingxin on 15/10/22.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "ViewController.h"
#import "ScrollDisplayViewController.h"
@interface ViewController ()<ScrollDisplayViewControllerDelegate>
@property(nonatomic,strong)ScrollDisplayViewController *sdvc;
@property(nonatomic,strong)NSArray *imgarr;//定义一个接收图片的数组
@end

@implementation ViewController
//-(NSArray *)imgarr
//{
//    if (_imgarr == nil) {
//    
//        
//        
//        
//           }
//    return _imgarr ;
//
//}

-(ScrollDisplayViewController *)sdvc
{
    if (!_sdvc) {
        _sdvc= [ScrollDisplayViewController new];
        _sdvc.autoCycle =YES;
        _sdvc.canCycle =YES;
    }
    return _sdvc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < 5; i ++) {
    NSString *imageName=[NSString stringWithFormat:@"/Users/tarena/Downloads/lan/%d.png",i+1];
    NSURL *url = [NSURL fileURLWithPath:imageName];
    [arr addObject:url];
    }
    //file:///Users/tarena/Downloads/lan/1.png"
    _imgarr =[arr copy];
    
    
    
    
    _sdvc.delegate =self;
   //之前先移除所有的child在新建
    
    
    
   [_sdvc removeFromParentViewController];
    //放入图片的数组
    _sdvc =[[ScrollDisplayViewController alloc]initWithImgPaths:_imgarr];
      NSLog(@"%@",_imgarr);
    
    [self addChildViewController:_sdvc];
    [self.view addSubview:_sdvc.view];
    _sdvc.view.backgroundColor =[UIColor orangeColor];
    [_sdvc.view mas_remakeConstraints:^(MASConstraintMaker *make) {
//       make.left.top.right.mas_equalTo(0);
//       make.bottom.mas_equalTo(self.view.mas_bottom).mas_equalTo(-50);
        make.edges.mas_equalTo(self.view);
    }];
    
}




//实现协议方法
//当前选择的
-(void)scrollDisplayViewController:(ScrollDisplayViewController *)scrollDisplayViewController didSelectedIndex:(NSInteger)index
{
    DDLogVerbose(@"%ld",index);
      NSLog(@".........");
   
    
}
//当前的位置
-(void)scrollDisplayViewController:(ScrollDisplayViewController *)scrollDisplayViewController currentIndex:(NSInteger)index
{
      NSLog(@"......22222");
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
