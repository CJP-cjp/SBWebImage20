//
//  NSString+SBWebCatch.h
//  高仿SDWebImage
//
//  Created by mac on 16/8/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownloaderManager.h"
@interface UIImageView (SBWebCatch)
@property(copy,nonatomic)NSString *lastURLString;
/*
 *分类下载和展示图片的主方法
 *
 *@param URLString 图片下载地址
 */
-(void)SB_setimageWithURLString:(NSString*)URLString;
@end
