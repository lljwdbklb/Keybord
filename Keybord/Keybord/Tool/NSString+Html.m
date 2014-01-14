//
//  NSString+Html.m
//  JunLottery
//
//  Created by Jun on 13-12-26.
//  Copyright (c) 2013年 Jun. All rights reserved.
//

#import "NSString+Html.h"

@implementation NSString (Html)

- (BOOL)isHttpPath {
    if ([self.lowercaseString rangeOfString:@"http://"].length
        || [self.lowercaseString rangeOfString:@"https://"].length
        ) {
        return YES;
    }
    return NO;
}

- (NSString *)stringByAppendingURLParam:(NSDictionary *)param {
    
    __block NSMutableString * paramStr = [NSMutableString stringWithString:@"?"];
    [param enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSString * keyValue = [NSString stringWithFormat:@"%@=%@&",key,obj];
        [paramStr appendString:keyValue];
    }];
    [paramStr deleteCharactersInRange:NSMakeRange(paramStr.length - 1, 1)];
    
    return [self stringByAppendingString:paramStr];
}

- (NSDictionary *)stringByReplacingURLParam {
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    
    NSRange range = [self rangeOfString:@"?"];
    
    if (range.length > 0 && range.length + range.location != self.length) {
        NSString * paramStr = [self substringFromIndex:range.length + range.location];
        
        //    NSLog(@"%@",paramStr);
        NSArray * keyVulues = [paramStr componentsSeparatedByString:@"&"];
        
        //    NSLog(@"%@",keyVulues);
        
        [keyVulues enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSArray * keyVulue = [obj componentsSeparatedByString:@"="];
            [param setObject:keyVulue[1] forKey:keyVulue[0]];
        }];
    }

    return param;
}

@end
