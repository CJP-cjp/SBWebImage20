
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
    //NSMutableDictionary *_OPCache;
    NSCache *_OPCache;
    //图片缓存
    //NSMutableDictionary *_imagesCache;
    NSCache *_imagesCache;
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
        //_OPCache = [[NSMutableDictionary alloc]init];
        _OPCache = [[NSCache alloc]init];
        //实例化图片缓存池
        //_imagesCache = [[NSMutableDictionary alloc]init];
        //UIImageView *imgView = [[UIImageView alloc]init];
         _imagesCache = [[NSCache alloc]init];
        //注册通知
        //object:nil ：可以接受任何对象的发送的UIApplicationDidReceiveMemoryWaringNOtification‘通知
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(clearCache) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return self;
}
//清理内存的主方法
-(void)clearCache
{
    [_imagesCache removeAllObjects];
    [_OPCache removeAllObjects];
    [_queue cancelAllOperations];
}
//这个通知注册单利里面，只有当应用程序退出了这个方法才会调用
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
//单例下载图片的主方法
-(void)downloadWithURLString:(NSString *)URLString finishedBlock:(void (^)(UIImage *))finishedBlock
{
    //判断有没有图片的缓存
    if ([self checkCacheWithURLString:URLString]) {
        //从内存中取出图片，回调到控制器
        if (finishedBlock) {
            finishedBlock([_imagesCache objectForKey:URLString]);
        }
        return;
    }
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
        //实现内存缓存
        [_imagesCache setObject:image forKey:URLString];
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
//单例管理取消操作的主方法
-(void)cancelWithLastURLString :(NSString*)lastURLString
{
    //取出上一次的下载操作
    DownloadOperation *lastOp = [_OPCache objectForKey:lastURLString];
    if (lastOp != nil) {
        //调用取消方法：只是在改变操作的状态
        //如果要真的取消操作，需要到操作内部去判断操作的状态
        [lastOp cancel];
        //把下载操作从下载操作缓存池中移除
        [_OPCache removeObjectForKey:lastURLString];
    }
}
//判断是否有缓存：零碎的垃圾代码抽取成一个完整的方法
-(BOOL )checkCacheWithURLString:(NSString*)URLString
{
    //先判断内存缓存
    if ([_imagesCache objectForKey:URLString]!=nil) {
        NSLog(@"从内存中加载。。。");
        return YES;
    }
    //取出沙盒里面的图片，再判断沙盒缓存
    UIImage *cacheImage = [UIImage imageWithContentsOfFile:[URLString appendCachesPath] ];
    if (cacheImage ) {
        NSLog(@"从沙盒中加载。。。");
        //在内存缓存中再保存一份
        [_imagesCache setObject:cacheImage forKey:URLString];
        return YES;
    }
    return NO;
}
@end
