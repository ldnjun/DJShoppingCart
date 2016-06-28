//
//  DJGoodsCell.h
//  DJDoubleMenu
//
//  Created by ldnjun on 16/6/9.
//  Copyright © 2016年 ldnjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsModel.h"
@class DJGoodsCell;
@protocol MenuItemCellDelegate <NSObject>

- (void)menuItemCellDidClickPlusButton:(DJGoodsCell *)itemCell;
- (void)menuItemCellDidClickMinusButton:(DJGoodsCell *)itemCell;
@end
@interface DJGoodsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *originPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *minusBtn;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIButton *plusBtn;
@property (weak, nonatomic) IBOutlet UIImageView *soldOutImgView;

@property (nonatomic,strong)GoodsModel *goods;

@property (nonatomic,weak)id<MenuItemCellDelegate>delegate;
@end
