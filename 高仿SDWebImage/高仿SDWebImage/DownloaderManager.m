
//
//  DownloaderManager.m
//  高仿SDWebImage
//
//  Created by mac on 16/8/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "DownloaderManager.h"
@interface DownloaderManager()
@end
@implementation DownloaderManager
{
    //全局队列
    NSOperationQueue *_queue;
    //操作缓存池
    NSMutableDictionary *_OPCache;
}

+(instancetype)sharedManager{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });
    return instance;
}
-(instancetype)init
{
    if (self  = [super init]) {
        //实例化队列
        _queue = [[NSOperationQueue alloc]init];
        //实例化操作缓存池
        _OPCache = [[NSMutableDictionary alloc]init];
    }
    return self;
}
//单例下载图片的主方法
-(void)downloadWithURLString:(NSString *)URLString finishedBlock:(void (^)(UIImage *))finishedBlock
{
    //判断操作缓存池里面有没有要下载的操作，如果有，就直接返回，不再建立重复的下载操作
    if ([_OPCache objectForKey:URLString]!= nil) {
        return;
    }
    //finishedBlock :控制器传入的代码块
    //等待OP图片下载完成之后再去回调
    void(^MfinishedBlock)(UIImage*) = ^(UIImage *image){
        //image:是OP下载完成，回掉到单例的
        //把op下载完成的图片回调到VC
        if (finishedBlock !=nil) {
            finishedBlock(image);
        }
        //把下载操作从下载操作缓存池移除？
        [_OPCache removeObjectForKey:URLString];
    };
    //创建操作的同时传入图片地址和下载完成的回调
    DownloadOperation *op = [DownloadOperation downloadWithURLString:URLString finshedBlock:MfinishedBlock];
    //把操作添加到操作缓存池
    [_OPCache setObject:op forKey:URLString];
    //把自定义操作添加到队列
    [_queue addOperation:op];
    
}
@end
