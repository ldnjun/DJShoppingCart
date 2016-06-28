//
//  DJShopShowView.m
//  DJDoubleMenu
//
//  Created by ldnjun on 16/6/8.
//  Copyright © 2016年 ldnjun. All rights reserved.
//

#import "DJShopShowView.h"
#import "DJShopBottomView.h"
@implementation DJShopShowView

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    UIView *view = touch.view;
    if(view == self){
        [self.shopCartView dismissAnimated:YES];
    }
}
@end
