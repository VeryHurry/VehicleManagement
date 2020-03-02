//
//  XXNetWorkMangerBase.m
//  gms
//
//  Created by GMS_001 on 17/1/4.
//  Copyright © 2017年 Gumeishu. All rights reserved.
//

#import "XXNetWorkMangerBase.h"
#import "HttpCommunicateDefine.h"

@interface XXNetWorkMangerBase ()


@end

@implementation XXNetWorkMangerBase

+(instancetype)sharedNetWorkManger
{
    static  XXNetWorkMangerBase *netWorkManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        netWorkManager = [[XXNetWorkMangerBase alloc] init];
    });
    
    return netWorkManager;
}
// json解析
- (NSDictionary *)jsonToDic:(NSData *)jsonData
{
    NSError *error = nil;
    NSData *data = jsonData;
    NSDictionary *dicData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    if (error) {
        XXLog(@"%@HTTPInstrument:json解析出现错误,数据格式出错", self);
        return @{};
    } else {
        return dicData;
    }
}

#pragma mark - 数据过滤
- (NSMutableDictionary *)dataFilter:(NSDictionary *)dic
{
    NSMutableDictionary *mDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    
    if (!kIsEmptyStr(dic[@"id"]))
    {
        [mDic setObject:dic[@"id"] forKey:@"cid"];
    }
    if (!kIsEmptyStr(dic[@"description"]))
    {
        [mDic setObject:dic[@"description"] forKey:@"description_s"];
    }
    return mDic;
}
- (NSMutableArray *)arrDataFilter:(NSArray *)arrData
{
    NSMutableArray *mArrData = [NSMutableArray new];
    
    for (NSDictionary *dic in arrData)
    {
        NSMutableDictionary *mDic = [self dataFilter:dic];
        [mArrData addObject:mDic];
    }
    
    return mArrData;
}
#pragma mark - 发起请求
- (void)getWithUrl:(NSString *)url andData:(NSDictionary *)dic andSuccessBlock:(SuccessBlock)sucBlock andFailureBlock:(FailureBlock)falBlock
{
    
    NSString *urlString = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    NSString *strUrl = kStrMerge(URL_BASE, urlString);
    [XXTollClass getWithURL:strUrl parameters:dic success:^(id success) {
        
        sucBlock(success);
    } failure:^(id failure) {
        falBlock(failure);
    }];
    
    
}

- (void)postWithUrl:(NSString *)url andArrData:(NSArray *)arr andSuccessBlock:(SuccessBlock)sucBlock andFailureBlock:(FailureBlock)falBlock
{
    
    NSString *urlString = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    NSString *strUrl = kStrMerge(URL_BASE, urlString);
    [XXTollClass postWithURL:strUrl parameters:arr progress:^(id progress) {
        
    } success:^(id success) {
        
        sucBlock(success);
    } failure:^(id failure) {
        falBlock(failure);
        
    }];
    
    
}
- (void)postWithUrl:(NSString *)url andData:(NSDictionary *)dic andSuccessBlock:(SuccessBlock)sucBlock andFailureBlock:(FailureBlock)falBlock
{
    NSString *strUrl;
    if ([url rangeOfString:@"tocs-member-app/letu"].length != 0) {
        NSString *urlString = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
        strUrl = kStrMerge(CARURL_BASE, urlString);
    }
    else
    {
        NSString *urlString = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
        strUrl = kStrMerge(URL_BASE, urlString);
    }
    
    [XXTollClass postWithURL:strUrl parameters:dic progress:^(id progress) {
        
    } success:^(id success) {
        if ([strUrl rangeOfString:@"123456"].length != 0) {
            sucBlock(success);
        }
        else
        {
            if ([success[@"status"] integerValue] == 1) {
                sucBlock(success);
            }
            else
            {
                [MBProgressHUD showError:success[@"msg"] toView:kWindow];
              
            }
        }
        
    } failure:^(id failure) {
        falBlock(failure);
        
    }];
    
}

- (void)putWithUrl:(NSString *)url andData:(NSDictionary *)dic andSuccessBlock:(SuccessBlock)sucBlock andFailureBlock:(FailureBlock)falBlock
{
    
    
    [XXTollClass putWithURL:url parameters:dic progress:^(id progress) {
        
    } success:^(id success) {
        sucBlock(success);
    } failure:^(id failure) {
        falBlock(failure);
    }];
    
    
}
- (void)deleteWithUrl:(NSString *)url andData:(NSDictionary *)dic andSuccessBlock:(SuccessBlock)sucBlock andFailureBlock:(FailureBlock)falBlock
{
    
    
    
    [XXTollClass deleteWithURL:url parameters:dic progress:^(id progress) {
        
    } success:^(id success) {
        sucBlock(success);
    } failure:^(id failure) {
        falBlock(failure);
    }];
    
    
}

- (void)postWithUrl:(NSString *)url imageData:(NSData *)imageData fileName:(NSString *)fileName parameter:(NSDictionary *)parameter andSuccessBlock:(SuccessBlock)sucBlock andFailureBlock:(FailureBlock)falBlock
{
    NSString *urlString = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    NSString *strUrl = kStrMerge(URL_BASE, urlString);
    [XXTollClass upLoadImage:imageData fileName:fileName PostWithURL:strUrl parameters:parameter progress:^(id progress) {
        
    } success:^(id success) {
        if ([success[@"success"] integerValue] == 1) {
            sucBlock(success);
        }
        else
        {
            [MBProgressHUD showError:success[@"msg"]];
        }
    } failure:^(id failure) {
        falBlock(failure);
    }];
}

- (void)postWithUrl:(NSString *)url andImageArr:(NSArray *)imageArr arameter:(NSDictionary *)parameter andSuccessBlock:(SuccessBlock)sucBlock andFailureBlock:(FailureBlock)falBlock
{
    NSString *urlString = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    NSString *strUrl = kStrMerge(CARURL_BASE, urlString);
    [XXTollClass updateFile:imageArr url:strUrl parameters:parameter success:^(id result) {
        if ([result[@"status"] integerValue] == 1) {
            sucBlock(result);
        }
        else
        {
            [MBProgressHUD showError:result[@"msg"]];
        }
    } failure:^(id failure) {
        falBlock(failure);
    }];
}

@end


