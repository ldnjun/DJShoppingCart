//
//  DJBuyAnimationTool.m
//  DJSelectDemo
//
//  Created by ldnjun on 16/6/16.
//  Copyright © 2016年 ldnjun. All rights reserved.
//

#import "DJBuyAnimationTool.h"
@implementation DJBuyAnimationTool

+ (DJBuyAnimationTool *)animation{
    static DJBuyAnimationTool *animation = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        animation = [[self alloc]init];
    });
    return animation;
}
- (void)throwObject:(UIView *)clickView from:(CGPoint)start to:(CGPoint)end{
    self.showView = clickView;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(start.x, start.y)];
    [path addCurveToPoint:CGPointMake(end.x + 25, end.y + 25) controlPoint1:CGPointMake(start.x, start.y) controlPoint2:CGPointMake(start.x - 180, start.y - 200)];
    
    [self groupAnimation:path];
}

- (void)groupAnimation:(UIBezierPath *)path{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = path.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
    
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"alpha"];
    alphaAnimation.duration = 0.8f;
    alphaAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    alphaAnimation.toValue = [NSNumber numberWithFloat:0.1];
    alphaAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = @[animation,alphaAnimation];
    groups.duration = 0.5f;
    groups.removedOnCompletion = NO;
    groups.fillMode = kCAFillModeForwards;
    groups.delegate = self;
    
    [self.showView.layer addAnimation:groups forKey:nil];
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if([self.delegate respondsToSelector:@selector(animationDidFinish)]){
        [self.delegate performSelector:@selector(animationDidFinish) withObject:nil];
    }
    self.showView = nil;
}
@end
