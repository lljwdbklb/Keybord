//
//  NSString+Html.h
//  JunLottery
//
//  Created by Jun on 13-12-26.
//  Copyright (c) 2013年 Jun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Html)
- (BOOL)isHttpPath;
- (NSString *)stringByAppendingURLParam:(NSDictionary *)param;
- (NSDictionary *)stringByReplacingURLParam;
@end
