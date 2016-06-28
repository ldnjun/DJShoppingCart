//
//  DJGoodsCell.m
//  DJDoubleMenu
//
//  Created by ldnjun on 16/6/9.
//  Copyright © 2016年 ldnjun. All rights reserved.
//

#import "DJGoodsCell.h"

@implementation DJGoodsCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setGoods:(GoodsModel *)goods{
    _goods = goods;
    self.icon.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",goods.goodsIcon]];
    self.nameLabel.text = goods.goodsName;
    self.originPriceLabel.text = [NSString stringWithFormat:@"原价：¥%.2f",goods.goodsOriginalPrice];
    self.priceLabel.text = [NSString stringWithFormat:@"¥%.2f",goods.goodsSalePrice];
    self.countLabel.text = [NSString stringWithFormat:@"%zd",goods.orderCount];
    if(_goods.orderCount > 0){
        [self.minusBtn setHidden:NO];
        self.countLabel.hidden = NO;
    }else{
        self.minusBtn.hidden = YES;
        self.countLabel.hidden = YES;
    }
    
    if(!_goods.goodsStock > 0){
        self.soldOutImgView.hidden = NO;
        _plusBtn.enabled = NO;
    }else{
        self.soldOutImgView.hidden = YES;
        _plusBtn.enabled = YES;
    }
}

- (IBAction)minus:(UIButton *)sender {
    _goods.orderCount --;
    _goods.goodsStock ++;
    _countLabel.text = [NSString stringWithFormat:@"%i",_goods.orderCount];
    if(_goods.orderCount == 0){
        _minusBtn.hidden = YES;
        _countLabel.hidden = YES;
    }
    if(_goods.goodsStock > 0){
        _plusBtn.enabled = YES;
        self.soldOutImgView.hidden = YES;
    }
    if([self.delegate respondsToSelector:@selector(menuItemCellDidClickMinusButton:)]){
        [self.delegate menuItemCellDidClickMinusButton:self];
    }
}
- (IBAction)plus:(UIButton *)sender {
    _goods.orderCount ++;
    _goods.goodsStock --;
    _countLabel.text = [NSString stringWithFormat:@"%i",_goods.orderCount];
    _countLabel.hidden = NO;
    _minusBtn.hidden = NO;
    if(_goods.goodsStock == 0){
        _plusBtn.enabled = NO;
        self.soldOutImgView.hidden = NO;
    }
    if([self.delegate respondsToSelector:@selector(menuItemCellDidClickPlusButton:)]){
        [self.delegate menuItemCellDidClickPlusButton:self];
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
