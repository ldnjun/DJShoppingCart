//
//  OrderDetailListView.h
//  DJDoubleMenu
//
//  Created by ldnjun on 16/6/10.
//  Copyright © 2016年 ldnjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailListView : UIView


@property (nonatomic,strong)UITableView *listTableView;

@property (nonatomic,strong)NSMutableArray *objects;

- (instancetype)initWithFrame:(CGRect)frame withObjects:(NSMutableArray *)objects;
@end
