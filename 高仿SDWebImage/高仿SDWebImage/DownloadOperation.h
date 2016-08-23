//
//  DownloadOperation.h
//  高仿SDWebImage
//
//  Created by mac on 16/8/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownloadOperation : NSOperation
//接收控制器传入的图片的地址
@property(copy,nonatomic)NSString *URLString;
//接收控制器传入的下载完成的回调
@property(copy,nonatomic)void(^finishedBlock)(UIImage *image);

@end
