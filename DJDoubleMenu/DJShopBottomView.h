//
//  DJShopBottomView.h
//  DJDoubleMenu
//
//  Created by ldnjun on 16/6/8.
//  Copyright © 2016年 ldnjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DJShopShowView.h"
#import "OrderDetailListView.h"
typedef void (^shopCarClickBlock)(void);
@interface DJShopBottomView : UIView

@property (nonatomic,strong)UIView *parentView;
@property (nonatomic,strong)UIImageView *shopCarImageView;
@property (nonatomic,strong)UILabel *moneyLabel;
@property (nonatomic,strong)UIButton *selectBtn;

@property (nonatomic,assign)NSInteger shopCarMoney;
@property (nonatomic,assign)NSInteger leftMoney;

@property (nonatomic,assign)double inTotal;
- (instancetype) initWithFrame:(CGRect)frame inView:(UIView *)parentView;

@property (nonatomic,copy)shopCarClickBlock block;


@property (nonatomic,strong)DJShopShowView *showView;

@property (nonatomic,strong)OrderDetailListView *detailListView;

@property (nonatomic,assign)BOOL is_open;
- (void)dismissAnimated:(BOOL)animated;

-(void)updateFrame:(UIView *)view;
@end
