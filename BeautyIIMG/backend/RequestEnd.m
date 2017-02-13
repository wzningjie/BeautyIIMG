//
//  RequestEnd.m
//  BeautyIIMG
//
//  Created by 杨朋亮 on 11/2/17.
//  Copyright © 2017年 daibou007. All rights reserved.
//

#import "RequestEnd.h"
#import "AFNetworking.h"
#import "Config.h"
#import "MJExtension.h"
#import "NSDictionary+json.h"

@implementation RequestEnd

+ (void)ajax:(id)data succ:(MIResponseCallback)succCallback fail:(MIResponseCallback) failCallback{
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [session.requestSerializer setTimeoutInterval:10];
    
    NSMutableDictionary *datas = [NSMutableDictionary dictionary];
    
    NSDictionary *dic = (NSDictionary*)data[@"parms"];
    for (NSString* key in [dic allKeys]) {
        if (![key isEqualToString:@"url"]) {
            [datas setObject:[dic objectForKey:key]forKey:key];
        }
    }
    NSMutableString *url =  [NSMutableString stringWithString:[((NSDictionary*)data) objectForKey:@"url"]];
    
    [session POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    NSLog(@"ajax post....:%@",url);
    
    if (responseObject) {
        NSString *result = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
//        NSLog(@"result:%@",result);
        
        result = [result stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
        
        NSDictionary *dic = [[NSDictionary alloc] initWithJson:result];
        NSNumber *code = dic[@"code"];
        
        //错误处理
        if (code && [code isKindOfClass:[NSNull class]]) {
            code = [NSNumber numberWithInt:0];
        }
        
        if(code && [code intValue] == 0){
            succCallback(result);
        }else{
            succCallback(result);
        }
    }
} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    failCallback(@"error");
}];
}
@end
