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

@end
