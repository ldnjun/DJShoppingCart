//
//  ViewController.m
//  DJDoubleMenu
//
//  Created by ldnjun on 16/6/8.
//  Copyright © 2016年 ldnjun. All rights reserved.
//

#import "ViewController.h"
#import "DJShopBottomView.h"
#import "DJShopShowView.h"
#import "GoodsCategory.h"
#import "MJExtension.h"
#import "GoodsModel.h"
#import "DJGoodsCell.h"
#import "DetailListCell.h"
#import "DJBuyAnimationTool.h"
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
static NSString *leftTableViewIndentifier = @"leftTableViewIndentifier";
static NSString *rightTableViewIndentifier = @"rightTableViewIndentifier";
static NSString *headerTableViewIndentifier = @"headerTableViewIndentifier";
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,MenuItemCellDelegate,DetailListCellDelegate,BuyAnimationDelegate>
@property (nonatomic,strong)UITableView *leftTabelView;
@property (nonatomic,strong)UITableView *rightTabelView;
@property (nonatomic,strong)NSArray *rightHeaderTitles;
@property (nonatomic,strong)DJShopBottomView *shopBottomView;

@property (nonatomic, strong) UIImageView   *redView;   //抛物线红点
@end

@implementation ViewController{
    BOOL _isR;
    NSArray *_dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"DJDoubleMenu";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    [self createTableView];
    [self shopBottomView];
    [self createData];
    _isR = YES;
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)createData{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"goods" ofType:@"json"];
    NSError *error = nil;
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    _dataArray = [GoodsCategory objectArrayWithKeyValuesArray:arr];
    
}
- (void)createTableView{
    [self.leftTabelView registerClass:[UITableViewCell class] forCellReuseIdentifier:leftTableViewIndentifier];
    [self.rightTabelView registerNib:[UINib nibWithNibName:@"DJGoodsCell" bundle:nil] forCellReuseIdentifier:rightTableViewIndentifier];

    //[self.rightTabelView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:headerTableViewIndentifier];
    
}


#pragma mark -MenuItemCellDelegate

- (void)menuItemCellDidClickMinusButton:(DJGoodsCell *)itemCell{
    _totalPrice = _totalPrice - itemCell.goods.goodsSalePrice;
    _shopBottomView.inTotal = _totalPrice;
    if(itemCell.goods.orderCount == 0){
        [self.orderArray removeObject:itemCell.goods];
    }
    [_shopBottomView.detailListView.listTableView reloadData];
    _shopBottomView.detailListView.objects = _orderArray;
}

- (void)menuItemCellDidClickPlusButton:(DJGoodsCell *)itemCell{
    _totalPrice = _totalPrice + itemCell.goods.goodsSalePrice;
    _shopBottomView.inTotal = _totalPrice;
    CGRect parentRectA = [itemCell convertRect:itemCell.plusBtn.frame toView:self.view];
    CGRect parentRectB = [_shopBottomView convertRect:_shopBottomView.shopCarImageView.frame toView:self.view];
    
    [self.view addSubview:self.redView];
    [[DJBuyAnimationTool animation]throwObject:self.redView from:parentRectA.origin to:parentRectB.origin];
    [DJBuyAnimationTool animation].delegate = self;
    if([self.orderArray containsObject:itemCell.goods]){
        [_shopBottomView.detailListView.listTableView reloadData];
    }else{
        [self.orderArray addObject:itemCell.goods];
        [_shopBottomView.detailListView.listTableView reloadData];
    }
    _shopBottomView.detailListView.objects = _orderArray;
}

- (UITableView *)leftTabelView{
    if(!_leftTabelView){
        _leftTabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kWidth * 0.3, kHeight - 64 - 50) style:UITableViewStylePlain];
        _leftTabelView.delegate = self;
        _leftTabelView.dataSource = self;
        [self.view addSubview:_leftTabelView];
    }
    return _leftTabelView;
}

- (UITableView *)rightTabelView{
    if(!_rightTabelView){
        _rightTabelView = [[UITableView alloc]initWithFrame:CGRectMake(kWidth * 0.3 , 0,kWidth - kWidth * 0.3, kHeight - 50 - 64)];
        _rightTabelView.delegate = self;
        _rightTabelView.dataSource = self;
        [self.view addSubview:_rightTabelView];
    }
    return _rightTabelView;
}
- (DJShopBottomView *)shopBottomView{
    if(!_shopBottomView){
        _shopBottomView = [[DJShopBottomView alloc]initWithFrame:CGRectMake(0, kHeight - 50 - 64, kWidth, 50) inView:self.view];
        _shopBottomView.detailListView.listTableView.delegate = self;
        _shopBottomView.detailListView.listTableView.dataSource = self;
        [_shopBottomView.detailListView.listTableView registerNib:[UINib nibWithNibName:@"DetailListCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        [self.view addSubview:_shopBottomView];
    }
    return _shopBottomView;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(tableView == self.rightTabelView){
        return _dataArray.count;
    }else if (tableView == self.leftTabelView){
        return 1;
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(tableView == self.rightTabelView){
        return 40;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(tableView == self.rightTabelView){
        return  CGFLOAT_MIN;
    }
    return 0;
}



- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    GoodsCategory *item = [_dataArray objectAtIndex:section];
    
    return item.goodsCategoryDesc;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    GoodsCategory *item = [_dataArray objectAtIndex:section];
    if(tableView == self.leftTabelView){
        return [_dataArray count];
    }else if (tableView == self.rightTabelView){
        return item.goodsArray.count;
    }else{
        return self.orderArray .count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == self.leftTabelView){
        return 70;
    }else if (tableView == self.rightTabelView){
        return 80;
    }else{
        return 50;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == self.leftTabelView){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:leftTableViewIndentifier];
        GoodsCategory *goods = _dataArray[indexPath.row];
        cell.textLabel.text = goods.goodsCategoryName;
        return cell;
    }else if (tableView == self.rightTabelView){
        GoodsCategory *goodC = _dataArray[indexPath.section];
        DJGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:rightTableViewIndentifier];
        cell.delegate = self;
        GoodsModel *goods = goodC.goodsArray[indexPath.row];
        cell.goods = goods;
        return cell;
    }else{
        DetailListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.delegate = self;
        GoodsModel *goods = [_orderArray objectAtIndex:indexPath.row];
        cell.goods = goods;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == self.leftTabelView){
        _isR = NO;
        [self.leftTabelView  selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionMiddle];
        [self.rightTabelView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:indexPath.row] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }else{
        [self.rightTabelView deselectRowAtIndexPath:indexPath animated:NO];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    if(_isR){
        NSInteger topCellSection = [[[tableView indexPathsForVisibleRows] firstObject] section];
        
        if (tableView == self.rightTabelView) {
            [self.leftTabelView selectRowAtIndexPath:[NSIndexPath indexPathForItem:topCellSection inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        }
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(nonnull UIView *)view forSection:(NSInteger)section{
    if(_isR){
        NSInteger topCellSection = [[[tableView indexPathsForVisibleRows] firstObject] section];
        NSLog(@"cell == %ld",topCellSection);
        if (tableView == self.rightTabelView) {
            [self.leftTabelView selectRowAtIndexPath:[NSIndexPath indexPathForItem:topCellSection inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        }
    }
}
#pragma mark - buyAnimationDelegate
- (void)animationDidFinish{
    [self.redView removeFromSuperview];
}
- (NSArray *)rightHeaderTitles{
    if(!_rightHeaderTitles){
        _rightHeaderTitles = [NSArray array];
    }
    return _rightHeaderTitles;
}

- (NSMutableArray *)orderArray{
    if(!_orderArray){
        _orderArray = [NSMutableArray array];
    }
    return _orderArray;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    _isR = YES;
}



#pragma mark - DetailListCellDelegate
- (void)orderDetailCellPlusButtonClicked:(DetailListCell *)cell {
    NSLog(@"订单 + 按钮点击: %@ %@ %i", cell.goods.goodsID, cell.goods.goodsName, cell.goods.goodsStock);
    // 计算总价
    _totalPrice = _totalPrice + cell.goods.goodsSalePrice;
    // 设置总价
    _shopBottomView.inTotal = _totalPrice;
//    ++self.totalOrders;
//    _shopCartView.badgeValue = self.totalOrders;
    
    _shopBottomView.detailListView.objects = _orderArray;
    [_shopBottomView updateFrame:_shopBottomView.detailListView];
    
    [_shopBottomView.detailListView.listTableView reloadData];
    [_rightTabelView reloadData];
}

- (void)orderDetailCellMinusButtonClicked:(DetailListCell *)cell {
    NSLog(@"订单 - 按钮点击: %@ %@ %i", cell.goods.goodsID, cell.goods.goodsName, cell.goods.goodsStock);
    // 计算总价
    _totalPrice = _totalPrice - cell.goods.goodsSalePrice;
    // 设置总价
    _shopBottomView.inTotal = _totalPrice;//    --self.totalOrders;
//    _shopCartView.badgeValue = self.totalOrders;
    
    // 将商品从购物车中移除
    if (cell.goods.orderCount == 0) {
        [self.orderArray removeObject:cell.goods];
    }
    if(_orderArray.count == 0){
        
        [_shopBottomView dismissAnimated:YES];
    }
    _shopBottomView.detailListView.objects = _orderArray;
    [_shopBottomView updateFrame:_shopBottomView.detailListView];
    [_shopBottomView.detailListView.listTableView reloadData];
    [_rightTabelView reloadData];
}

- (UIImageView *)redView {
    if (!_redView) {
        _redView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        _redView.backgroundColor = [UIColor redColor];
        //_redView.image = [UIImage imageNamed:@"adddetail"];
        _redView.layer.cornerRadius = 10;
    }
    return _redView;
}
@end
