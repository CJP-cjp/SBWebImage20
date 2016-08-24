//
//  DownloadOperation.h
//  高仿SDWebImage
//
//  Created by mac on 16/8/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+path.h"
@interface DownloadOperation : NSOperation
////接收控制器传入的图片的地址
//@property(copy,nonatomic)NSString *URLString;
////接收控制器传入的下载完成的回调
//@property(copy,nonatomic)void(^finishedBlock)(UIImage *image);
/*
 *类方法实例化自定义操作：在实例化自定义操作的同时，传入图片地址和下载完成的回调
 @param URLString 接收VC传入的图片地址
 @param finishedBlock 接收VC传入的下载完成的回调
 @return 自定义下载操作对象
 *
 */
+(instancetype)downloadWithURLString:(NSString *)URLString finshedBlock:(void(^)(UIImage*image))finishedBlock;

@end
