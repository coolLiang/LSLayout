//
//  LSCircleLayout.m
//  LSLayout
//
//  Created by noci on 16/9/23.
//  Copyright © 2016年 noci. All rights reserved.
//

#import "LSCircleLayout.h"

@interface LSCircleLayout()

//存放每个cell属性数据的数组
@property(nonatomic,strong)NSMutableArray * cellAttributesArray;

@end

@implementation LSCircleLayout


-(NSMutableArray *)cellAttributesArray
{
    if (_cellAttributesArray == nil) {
        
        _cellAttributesArray = [NSMutableArray new];
    }
    return _cellAttributesArray;
}

//准备布局
-(void)prepareLayout
{
    [super prepareLayout];
    
    [self.cellAttributesArray removeAllObjects];
    
    //共有几个cell
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    for (NSInteger i = 0; i < count; i++) {
        
        NSIndexPath * indexpath = [NSIndexPath indexPathForItem:i inSection:0];
        
        UICollectionViewLayoutAttributes * attributes = [self layoutAttributesForItemAtIndexPath:indexpath];
        
        [self.cellAttributesArray addObject:attributes];
        
    }
    
}

//所有item的属性数组
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.cellAttributesArray;
}

//返回对应cell的布局属性
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //item numbers
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    //
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    //半径
    CGFloat radius = 180;
    
    //圆心的位置
    CGFloat centerX = self.collectionView.frame.size.width * 0.5;
    CGFloat centerY = self.collectionView.frame.size.height * 0.5;
    
    //
    UICollectionViewLayoutAttributes * attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    attributes.size = CGSizeMake(50, 50);
    
    if (count == 1) {
        
        attributes.center = CGPointMake(centerX, centerY);
    }
    else
    {   //每个cell的角度跟初始值的角度差
        CGFloat angle = (2 * M_PI / count) * indexPath.item;
        //计算item的坐标。
        CGFloat marginX = centerX + radius * sin(angle);
        CGFloat marginY = centerY + radius * cos(angle);
        
        attributes.center = CGPointMake(marginX, marginY);
    }
    
    return attributes;
    
}

@end
