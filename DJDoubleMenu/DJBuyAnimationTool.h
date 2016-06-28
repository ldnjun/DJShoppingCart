//
//  DJBuyAnimationTool.h
//  DJSelectDemo
//
//  Created by ldnjun on 16/6/16.
//  Copyright © 2016年 ldnjun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol BuyAnimationDelegate <NSObject>
- (void)animationDidFinish;
@end
@interface DJBuyAnimationTool : NSObject
@property (nonatomic,strong)UIView *showView;
+ (DJBuyAnimationTool *)animation;
- (void)throwObject:(UIView *)clickView from:(CGPoint)start to:(CGPoint)end;



@property (nonatomic,weak)id<BuyAnimationDelegate>delegate;
@end
