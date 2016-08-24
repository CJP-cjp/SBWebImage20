//
//  DownloadOperation.m
//  高仿SDWebImage
//
//  Created by mac on 16/8/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "DownloadOperation.h"
@interface DownloadOperation()
//接收控制器传入的图片的地址
@property(copy,nonatomic)NSString *URLString;
//接收控制器传入的下载完成的回调
@property(copy,nonatomic)void(^finishedBlock)(UIImage *image);
@end
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
    //不能在main方法一开始就做状态是否被取消的判断
    //因为：有可能操作已经在执行了，但是取消消息还没有发送过来
    //一般会在延迟操作的后面做判断，但是也可以在多个地方做多次判断
//    if(self.isCancelled )
//    {
//        NSLog(@"取消%@",_URLString);
//        return;
//    }
   // NSLog(@"main %@",[NSThread currentThread]);
    NSLog(@"传入 %@",self.URLString);
    //下一步是在这里面的做图片下载的事情，然后传到manager
    
       //下载图片
    NSURL *URL = [NSURL URLWithString:self.URLString];
    NSData *data = [NSData dataWithContentsOfURL:URL];
    UIImage *image = [UIImage imageWithData:data];
    //模拟延迟
    [NSThread sleepForTimeInterval:1.0];
    if(self.isCancelled )
    {
        NSLog(@"取消%@",_URLString);
        return;
    }
    // 断言 : 保证某一个条件一定满足,如果不满足就崩溃,并且自定义崩溃信息;是C语言开发者的最爱;
    // 只在开发时有效!方便多人开发的;
    NSAssert(self.finishedBlock != nil, @"下载完成的回调不能为空!");
//    if(self.finishedBlock!=nil)
//    {
        //需要在主线程，把图片对象传递到manager
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            NSLog(@"完成%@",_URLString);
            self.finishedBlock(image);
        }];
   // }
    
}
//图片的下载方法：这个方法执行完，才执行main ，先有操作，再有main
+(instancetype)downloadWithURLString:(NSString *)URLString finshedBlock:(void(^)(UIImage*image))finishedBlock
{
    //创建自定义操作
    DownloadOperation *op = [[DownloadOperation alloc]init];
    //记录外界传入的图片和下载完成的回调
    op.URLString = URLString;
    op.finishedBlock =finishedBlock;
    return op;
    
}
@end
