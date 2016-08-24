//
//  DownloaderManager.h
//  高仿SDWebImage
//
//  Created by mac on 16/8/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownloadOperation.h"

@interface DownloaderManager : NSObject
+(instancetype)sharedManager;
//提示：将来在开发中，只要是异步操作，就要定义代码块回调
/**
 *单利管理下载的主方法
 * @param URLString 单利接收控制器传入的图片地址
 * @param finishedBlock 单利接收控制器传入的图片下载完成的回调，把图片回调到VC
 */
-(void)downloadWithURLString:(NSString *)URLString finishedBlock :(void(^)(UIImage* image))finishedBlock;
/**
 *单例管理取消操作
 *@papram lastURLString 上一次正在执行的操作对应的图片地址
 
 *
 */
-(void)cancelWithLastURLString :(NSString*)lastURLString;
@end
