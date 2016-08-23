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
    //自定义操作内部传入图片地址
    op.URLString =@"http://img2.3lian.com/2014/c7/12/d/77.jpg" ;
    //传入代码块到自定义操作
    [op setFinishedBlock:^(UIImage *image) {
        //赋值操作（主线程）
        NSLog(@" %@ %@",image,[NSThread currentThread]);
    }];
    
    
    //把自定义的操作添加到队列
    [_queue addOperation:op];
    //下一步：指定自定义执行的任务
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
