//
//  ViewController.m
//  高仿SDWebImage
//
//  Created by mac on 16/8/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import "DownloadOperation.h"
#import "DownloaderManager.h"
#import "AFNetworking.h"
#import "AppsModel.h"
@interface ViewController ()
@property(weak,nonatomic)IBOutlet UIImageView *iconImageView;
@end

@implementation ViewController
{
//    //全局队列
//    NSOperationQueue *_queue;
    //设置数据源组
    NSArray *_appList;
//    //操作缓存池
//    NSMutableDictionary *_OPCache;
    //保存上一次的下载地址
    NSString *_lastURLString;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    //实例化队列
//    _queue = [[NSOperationQueue alloc]init];
//    //实例化操作缓存池
//    _OPCache = [[NSMutableDictionary alloc]init];
    //
    [self loadJsonData];
    // Do any additional setup after loading the view, typically from a nib
}
//测试框架是否有效
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //获取随机数
    int random = arc4random_uniform((u_int32_t)_appList.count);
    //随机取出模型
    AppsModel *model = _appList[random];
//    //从随机模型里面，取出图片，去下载
//    if (![model.icon isEqualToString:_lastURLString]&&_lastURLString != nil) {
//        //取出上一次的下载操作
//        DownloadOperation *lastOp = [_OPCache objectForKey:_lastURLString];
//        //调用取消方法：只是在改变操作的状态
//        //如果要真的取消操作，需要到操作内部去判断操作的状态
//        [lastOp cancel];
//        
    
        
//    }
    _lastURLString = model.icon;
    //单利接管下载操作
    [[DownloaderManager sharedManager]downloadWithURLString:model.icon finishedBlock:^(UIImage *image) {
        //赋值操作（主线程）
        self.iconImageView.image = image;
    }];
//    //创建操作的同时传入图片地址和下载完成的回调
//    DownloadOperation *op = [DownloadOperation downloadWithURLString:model.icon finshedBlock:^(UIImage *image) {
//        //赋值操作（主线程）
//        //NSLog(@" %@ %@",image,[NSThread currentThread]);
//        self.iconImageView.image = image;
//        //把下载操作从下载操作缓存池移除？
//        [_OPCache removeObjectForKey:model.icon];
//    }];
//    //把操作添加到操作缓存池
//    [_OPCache setObject:op forKey:model.icon];
//    //把自定义的操作添加到队列
//    [_queue addOperation:op];
}
//这个'loadJsonData‘方法执行完了之后，我们再去点击屏幕
//loadJsonData 是辅助我们开发框架，是测试框架的数据来源
-(void)loadJsonData
{
    //1.创建网络请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //json数据的地址
    NSString *URLString = @"https://raw.githubusercontent.com/zhangxiaochuZXC/ServerFile20/master/apps.json";
    //2.网络请求管理者发送GET请求，获取json数据
    //默认是异步执行的，回调默认是主线程???
    [manager GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSArray* _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        //定义临时的可变的数组
        NSMutableArray *tmpM = [[NSMutableArray alloc]initWithCapacity:responseObject.count];
        //下一步：用字典数组responseObject，实现字典转模型
        [responseObject enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //obj :就是数组里面的元素（字典）
            AppsModel *model = [AppsModel appWithDict:obj];
            //把模型数据对象添加到可变数组
            [tmpM addObject:model];
        }];
        //给数据源数组赋值
        _appList = tmpM.copy;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
-(void)demo2
{
//    //实例化队列
//    _queue = [[NSOperationQueue alloc]init];
//    //创建操作的同时传入图片地址和下载完成的回调
//    DownloadOperation *op = [DownloadOperation downloadWithURLString:@"http://img2.3lian.com/2014/c7/12/d/77.jpg" finshedBlock:^(UIImage *image) {
//        //赋值操作（主线程）
//        NSLog(@" %@ %@",image,[NSThread currentThread]);
//    }];
//    
//    //把自定义的操作添加到队列
//    [_queue addOperation:op];
//    //下一步：指定自定义执行的任务
}
//-(void)demo
//{
//    //实例化自定义操作
//    DownloadOperation *op = [[DownloadOperation alloc]init];
//    //自定义操作内部传入图片地址
//    op.URLString =@"http://img2.3lian.com/2014/c7/12/d/77.jpg" ;
//    //传入代码块到自定义操作
//    [op setFinishedBlock:^(UIImage *image) {
//        //赋值操作（主线程）
//        NSLog(@" %@ %@",image,[NSThread currentThread]);
//    }];
//    //把自定义的操作添加到队列
//    [_queue addOperation:op];
//
//
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
