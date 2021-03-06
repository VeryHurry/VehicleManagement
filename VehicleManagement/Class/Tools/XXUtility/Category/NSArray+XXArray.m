//
//  NSArray+XXArray.m
//  BaseTest
//
//  Created by GMS_XiaoXin on 17/1/11.
//  Copyright © 2017年 GMS_001. All rights reserved.
//

#import "NSArray+XXArray.h"

@implementation NSArray (XXArray)
/**
 初始化数组
 
 @param count 数据个数
 @return 数组
 */
+ (NSMutableArray *)xx_initWithObjCount:(NSInteger)count
{
    NSMutableArray *arr = [NSMutableArray new];
    
    for (int i =0 ; i < count; i++)
    {
        [arr addObject:@""];
    }
    return arr;
}
/**
 倒序数组
 
 @return 颠倒顺序后的数组
 */
- (NSArray *)xx_reversedArr
{
   return  [[self reverseObjectEnumerator] allObjects];
}
// 合并两个数组
- (NSArray *)xx_mergingWith:(NSArray *)arr1
{
    NSMutableArray *arrAll = [NSMutableArray arrayWithArray:self];
    
    for (int i = 0; i<arr1.count; i++)
    {
        [arrAll addObject:arr1[i]];
    }
    
    return [NSArray arrayWithArray:arrAll];
}
// 数组转JSON
- (NSString *)xx_transformJson
{
    NSError *error = nil;
    //NSJSONWritingPrettyPrinted:指定生成的JSON数据应使用空格旨在使输出更加可读。如果这个选项是没有设置,最紧凑的可能生成JSON表示。
    NSData *jsonData = [NSJSONSerialization
                        dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    if ([jsonData length] > 0 && error == nil)
    {
        //NSLog(@"Successfully serialized the dictionary into data.");
        //NSData转换为String
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        //NSLog(@"JSON String = %@", jsonString);
        return jsonString;
    }
    else if ([jsonData length] == 0 &&
             error == nil)
    {
        NSLog(@"No data was returned after serialization.");
    }
    else if (error != nil)
    {
        NSLog(@"An error happened = %@", error);
    }
    return @"错误";

}
// JSON转数组
+ (NSArray *)xx_initWithJson:(NSString *)json
{
    if (json == nil) {
        return nil;
    }
    NSError *err;
    NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    
    id jsonObject = [NSJSONSerialization
                     JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments
                     error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    
    if ([jsonObject isKindOfClass:[NSArray class]])
    {
        NSArray *deserializedArray = (NSArray *)jsonObject;
        
        
        return deserializedArray;
    }
    return nil;
}
@end

#pragma mark- NSMutableArray setter
@implementation NSMutableArray (XXArray)
-(void)addObj:(id)i{
    if (i!=nil) {
        [self addObject:i];
    }
}
-(void)addString:(NSString*)i
{
    if (i!=nil) {
        [self addObject:i];
    }
}
-(void)addBool:(BOOL)i
{
    [self addObject:@(i)];
}
-(void)addInt:(int)i
{
    [self addObject:@(i)];
}
-(void)addInteger:(NSInteger)i
{
    [self addObject:@(i)];
}
-(void)addUnsignedInteger:(NSUInteger)i
{
    [self addObject:@(i)];
}
-(void)addCGFloat:(CGFloat)f
{
    [self addObject:@(f)];
}
-(void)addChar:(char)c
{
    [self addObject:@(c)];
}
-(void)addFloat:(float)i
{
    [self addObject:@(i)];
}
-(void)addPoint:(CGPoint)o
{
    [self addObject:NSStringFromCGPoint(o)];
}
-(void)addSize:(CGSize)o
{
    [self addObject:NSStringFromCGSize(o)];
}
-(void)addRect:(CGRect)o
{
    [self addObject:NSStringFromCGRect(o)];
}
@end

