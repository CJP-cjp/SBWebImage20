//
//  AppsModel.m
//  高仿SDWebImage
//
//  Created by mac on 16/8/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "AppsModel.h"

@implementation AppsModel
+(instancetype)appWithDict :(NSDictionary *)dict
{
    //创建模型对象
    AppsModel *model = [[AppsModel alloc]init];
    //使用KVC实现字典转模型
    [model setValuesForKeysWithDictionary:dict];
    //返回模型数据
    return model;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{}
@end
