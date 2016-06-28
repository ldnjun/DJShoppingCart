//
//  DJShopBottomView.m
//  DJDoubleMenu
//
//  Created by ldnjun on 16/6/8.
//  Copyright © 2016年 ldnjun. All rights reserved.
//

#import "DJShopBottomView.h"
#import "NSString+Extension.h"

#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@implementation DJShopBottomView{
    BOOL _isClick;
}
- (instancetype) initWithFrame:(CGRect)frame inView:(UIView *)parentView{
    if(self = [super initWithFrame:frame]){
        self.parentView = parentView;
        [self layoutUI];
    }
    return self;
}
- (void)layoutUI{
    UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(8, -5, 45, 45)];
    icon.backgroundColor = [UIColor blueColor];
    icon.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click)];
    [icon addGestureRecognizer:tap];
    [self addSubview:icon];
    self.shopCarImageView = icon;
    
    CGSize size = [@"购物车是空的" sizeWithTextFont:[UIFont systemFontOfSize:16]];
    UILabel *moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(icon.frame) + 5, (50 - size.height) / 2, 120, size.height)];
    moneyLabel.textColor = [UIColor grayColor];
    moneyLabel.text = @"购物车是空的";
    [self addSubview:moneyLabel];
    self.moneyLabel = moneyLabel;
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth - 100, 0, 100, 50)];
    [btn setBackgroundColor:[UIColor greenColor]];
    [btn setTitle:[NSString stringWithFormat:@"还差%ld元",self.leftMoney] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    self.selectBtn = btn;
    
    DJShopShowView *showView = [[DJShopShowView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 50 -64)];
    showView.shopCartView = self;
    [self.parentView addSubview:showView];
    self.showView = showView;
    self.showView.alpha = 0.0f;
    
    
    OrderDetailListView *list = [[OrderDetailListView alloc]initWithFrame:CGRectMake(0, self.parentView.bounds.size.height, self.bounds.size.width,50) withObjects:_detailListView.objects];
    self.detailListView = list;
}


- (void)setInTotal:(double)inTotal{
    _inTotal = inTotal;
    if(inTotal > 0){
        self.moneyLabel.text = [NSString stringWithFormat:@"共：¥%.2f",inTotal];
        self.moneyLabel.font = [UIFont systemFontOfSize:14];
        self.moneyLabel.textColor = [UIColor redColor];
        
        self.selectBtn.enabled = YES;
        [self.selectBtn setTitle:@"选好了" forState:UIControlStateNormal];
        [self.selectBtn setBackgroundColor:[UIColor redColor]];
        [self.shopCarImageView setUserInteractionEnabled:YES];
    }else{
        self.moneyLabel.text = @"购物车是空的";
        self.moneyLabel.font = [UIFont systemFontOfSize:14];
        self.moneyLabel.textColor = [UIColor grayColor];
        
        self.selectBtn.enabled = NO;
        [self.selectBtn setTitle:@"请选择产品" forState:UIControlStateNormal];
        [self.selectBtn setBackgroundColor:[UIColor grayColor]];
        [self.shopCarImageView setUserInteractionEnabled:NO];
    }
}

- (void)updateFrame:(UIView *)view{
    OrderDetailListView *orderListView = (OrderDetailListView *)self.detailListView;
//    if(orderListView.objects.count == 0){
//        [self dismissAnimated:YES];
//        return;
//    }
    
    float height = 0;
    height = [orderListView.objects count] * 50;
    int maxHeight = self.parentView.frame.size.height - 250;
    if (height >= maxHeight) {
        height = maxHeight;
    }
    
    //float orignY = self.detailListView.frame.origin.y;
    
    self.detailListView.frame = CGRectMake(self.detailListView.frame.origin.x, self.parentView.bounds.size.height - height - 50, self.detailListView.frame.size.width, height);
    self.detailListView.backgroundColor = [UIColor redColor];
    self.detailListView.listTableView.frame = self.detailListView.bounds;
    [self.showView addSubview:self.detailListView];
}


- (void)sure{
    NSLog(@"确定");
}
- (void)click{
    [self updateFrame:self.detailListView];
    if(self.is_open){
        [self dismissAnimated:YES];
        self.is_open = NO;
    }else{
        self.showView.alpha = 1.0;
        self.is_open = YES;
    }
}
- (void)dismissAnimated:(BOOL)animated{
    self.is_open = NO;
    self.showView.alpha = 0.0f;
}
@end
