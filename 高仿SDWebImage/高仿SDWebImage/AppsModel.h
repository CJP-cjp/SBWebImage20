//
//  AppsModel.h
//  高仿SDWebImage
//
//  Created by mac on 16/8/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppsModel : NSObject
//APP名称
@property(copy,nonatomic)NSString *name;
//APP下载量
@property(copy,nonatomic)NSString *download;
//APP图标
@property(copy,nonatomic)NSString *icon;
/**
 *提供给外界快速实现字典转模型的方法
 *@param dict 外界传入的字典
 * @return 返回模型对象
 */
+(instancetype)appWithDict :(NSDictionary *)dict;

@end
