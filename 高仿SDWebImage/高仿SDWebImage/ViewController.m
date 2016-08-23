//
//  ViewController.m
//  高仿SDWebImage
//
//  Created by mac on 16/8/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import "DownloadOperation.h"
@interface ViewController ()

@end

@implementation ViewController
{
    //全局队列
    NSOperationQueue *_queue;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _queue = [[NSOperationQueue alloc]init];
    //实例化自定义操作
    DownloadOperation *op = [[DownloadOperation alloc]init];
    //把自定义的操作添加到队列
    [_queue addOperation:op];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
