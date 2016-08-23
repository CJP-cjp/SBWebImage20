//
//  DownloadOperation.m
//  高仿SDWebImage
//
//  Created by mac on 16/8/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "DownloadOperation.h"

@implementation DownloadOperation
/*1.自定义DownloadOperation的目的：下载图片
   1.1 图片的地址
   1.2 传递图片到VC
 2.重写自定义操作的入口方法
 3.任何操作在执行时都会默认的调用这个方法
 4.默认就是在子线程执行的
 5.当队列调度操作执行时，才会进进入这个main方法
 
 *
 */
-(void)main
{
    NSLog(@"main %@",[NSThread currentThread]);
    //下一步是在这里面的做图片下载的事情，然后传到VC
    //下载图片
    NSURL *URL = [NSURL URLWithString:self.URLString];
    NSData *data = [NSData dataWithContentsOfURL:URL];
    UIImage *image = [UIImage imageWithData:data];
    if(self.finishedBlock!=nil)
    {
        //需要在主线程，把图片对象传递到控制器
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            self.finishedBlock(image);
        }];
    }
    
}
@end
