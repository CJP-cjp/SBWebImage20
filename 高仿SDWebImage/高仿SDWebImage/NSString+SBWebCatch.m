//
//  NSString+SBWebCatch.m
//  高仿SDWebImage
//
//  Created by mac on 16/8/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "NSString+SBWebCatch.h"
#import <objc/runtime.h>
@implementation UIImageView (SBWebCatch)
/*
 *参数1：要关联的对象
 *参数2：关联的key
 *参数3：关联的值（value)
  参数4：关联的值的存储策略
 *
 */
-(void)setLastURLString:(NSString *)lastURLString
{
    objc_setAssociatedObject(self, "key", lastURLString, OBJC_ASSOCIATION_COPY);
}
-(NSString*)lastURLString
{
    /*
     *参数1.要关联的对象
     *参数2：关联的key
     */
    return objc_getAssociatedObject(self, "key");
}
-(void)SB_setimageWithURLString:(NSString*)URLString
{
    
       //从随机模型里面，取出图片，去下载
        if (![URLString isEqualToString:self.lastURLString]&&  self.lastURLString!= nil) {
            
            //单例接管取消操作
            [[DownloaderManager sharedManager]cancelWithLastURLString:self.lastURLString];
            
    
        }
    self.lastURLString = URLString;
    
    //单利接管下载操作
    [[DownloaderManager sharedManager]downloadWithURLString:URLString finishedBlock:^(UIImage *image) {
        //赋值操作（主线程）
        self.image = image;
    }];

}
@end
