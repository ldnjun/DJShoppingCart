//
//  NSString+Extension.m
//  WeiBo
//
//  Created by ldnjun on 15/6/28.
//  Copyright (c) 2015年 LDNJUN. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (CGSize)sizeWithTextFont:(UIFont *)font maxW:(CGFloat)maxW{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (CGSize)sizeWithTextFont:(UIFont *)font
{
    return [self sizeWithTextFont:font maxW:MAXFLOAT];
}
@end
