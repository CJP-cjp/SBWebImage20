//
//  NSString+path.m
//  01-列表异步下载网络图片
//
//  Created by HM on 16/8/20.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "NSString+path.h"
#import "NSString+Hash.h"

@implementation NSString (path)

// 沙盒缓存路径和快递地址是一样的

- (NSString *)appendCachesPath
{
    // 获取沙盒路径
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    
    // 获取文件名 : http://p16.qhimg.com/dr/48_48_/t0125e8d438ae9d2fbb.png
    // self : 这个方法的调用者
    // lastPathComponent : 截取网络地址最后一个`/`后面的内容(就是图片名)
//    NSString *name = [self lastPathComponent];
    
    // 需要把图片整个地址进行MD5编码,生成的32位的字符串作为图片缓存的名字
    NSString *name = [self md5String];
    
    // 路径拼接文件名
    // stringByAppendingPathComponent : 会自动添加`/`
    NSString *filePath = [path stringByAppendingPathComponent:name];
    
    NSLog(@"MD5编码之后的沙盒缓存路径 %@",filePath);
    
    return filePath;
}

@end
