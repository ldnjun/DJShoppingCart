//
//  ViewController.h
//  DJDoubleMenu
//
//  Created by ldnjun on 16/6/8.
//  Copyright © 2016年 ldnjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@property (nonatomic,assign)double totalPrice;

/**
 *  订单数据
 */
@property (nonatomic,strong)NSMutableArray *orderArray;
@end

