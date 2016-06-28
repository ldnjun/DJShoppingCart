//
//  NSString+Extension.h
//  WeiBo
//
//  Created by ldnjun on 15/6/28.
//  Copyright (c) 2015年 LDNJUN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (Extension)


- (CGSize)sizeWithTextFont:(UIFont *)font maxW:(CGFloat)maxW;
- (CGSize)sizeWithTextFont:(UIFont *)font;
@end
