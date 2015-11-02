//
//  LastNewsViewController.m
//  BaseProject
//
//  Created by tarena on 15/10/24.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "LastNewsViewController.h"
#import "NewsCell.h"
#import "LastViewModel.h"
#import"ScrollDisplayViewController.h"
#import "DatailViewController.h"
//在写一个专门的滚动扩展类用于滚动的表头
@interface LastNewsViewController ()<SrcrollDisyplayViewControllerDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
//增加一个属性viewmodel层类型的
@property(nonatomic,strong)LastViewModel *latestVM;
//和一个滚动视图
@property(nonatomic,strong)ScrollDisplayViewController *sdVC;
@end

@implementation LastNewsViewController

//使用懒加载创建一个
-(LastViewModel *)latestVM
{
    if (!_latestVM) {
        _latestVM =[[LastViewModel alloc]initWithNewsListType:_type];
    }
    return _latestVM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    //头部刷新
    _tableview.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.latestVM refreshDataComplete:^(NSError *error) {
            //更新的数据
            [_tableview.header endRefreshing];
            [_tableview reloadData];
            if(error)
            {
                [self showErrorMsg:error.localizedDescription];
            }
            [self configTableHander];
            
        }];
    }];
    [_tableview.header beginRefreshing];
    
    _tableview.footer =[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self.latestVM getMoreDataComplete:^(NSError *error) {
            if (error ) {
                [self showErrorMsg:error.description];
            }
            [_tableview.footer endRefreshing];
            [_tableview reloadData];
        }];
    }];
}

-(void)configTableHander
{
    //如果头部的图片为0
    if (self.latestVM.headImagArr.count == 0) {
        return;//什么也不执行
    }
    UIView *headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 185)];
    [_sdVC removeFromParentViewController];
    _sdVC = [[ScrollDisplayViewController alloc]initWithPaths:self.latestVM.headImagArr];
    _sdVC.delegate =self;
    [self addChildViewController:_sdVC];
    [headerView addSubview:_sdVC.view];
    [_sdVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(headerView);
    }];
    _tableview.tableHeaderView =headerView;
}

////遵守协议
-(void)scollDisplayViewController:(ScrollDisplayViewController *)scrollDisyplayViewController didSelected:(NSInteger)index//一个是选择的行的参数，一个是它自己的
{
    //点击了第几个
    DDLogVerbose(@"%ld",index);

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  
    return self.latestVM.rowNumber;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   NewsCell *cell =[tableView dequeueReusableCellWithIdentifier:@"Cell" ];
    [cell.imageView setImageWithURL:[self.latestVM iconForRow:indexPath.row]];
    cell.title.text =[self.latestVM titleForRow:indexPath.row];
    cell.time.text = [self.latestVM timeForRow:indexPath.row];
    cell.comment.text =[self.latestVM commentForRow:indexPath.row];
    return cell;

}
//让分割先左边无缝隙
kRemoveCellSeparator
//松手后高亮的去掉
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //点击进入详细页
    DatailViewController *vc= [[DatailViewController alloc]initWithID:[self.latestVM  IDForRow:indexPath.row]];
    [self.navigationController pushViewController:vc animated:YES];


}


@end
