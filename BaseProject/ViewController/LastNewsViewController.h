//
//  LastNewsViewController.h
//  BaseProject
//
//  Created by tarena on 15/10/24.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LastViewModel.h"
@interface LastNewsViewController : UIViewController
//对应的类型的显示，是什么类型所以要定义一个type属性
@property(nonatomic)NewsListType type;
@end
