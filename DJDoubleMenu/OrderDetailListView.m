//
//  OrderDetailListView.m
//  DJDoubleMenu
//
//  Created by ldnjun on 16/6/10.
//  Copyright © 2016年 ldnjun. All rights reserved.
//

#import "OrderDetailListView.h"

@implementation OrderDetailListView


- (instancetype)initWithFrame:(CGRect)frame withObjects:(NSMutableArray *)objects{
    if(self = [super initWithFrame:frame]){
        self.objects = [NSMutableArray arrayWithArray:objects];
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        _listTableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _listTableView.bounces = NO;
        _listTableView.showsHorizontalScrollIndicator = NO;
        _listTableView.showsVerticalScrollIndicator = NO;
        _listTableView.backgroundColor = [UIColor clearColor];
        [self addSubview:_listTableView];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
