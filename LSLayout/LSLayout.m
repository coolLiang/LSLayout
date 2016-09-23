//
//  LSLayout.m
//  LSLayout
//
//  Created by noci on 16/9/22.
//  Copyright © 2016年 noci. All rights reserved.
//

#import "LSLayout.h"

static const int LSDefaultlinesNumbers = 3;

static const float LSDefaultRowsMargin = 10;

static const float LSDefaultLinesMargin = 10;

static const float LSDefaultContentTopAndBottomMargin = 10;

static const float LSDefaultContentLeftAndRightMargin = 10;



@interface LSLayout()

//每列高度数据存放
@property(nonatomic,strong)NSMutableArray * lineHeightArray;
//每个cell的数据。
@property(nonatomic,strong)NSMutableArray * cellAttributeArray;

@end

@implementation LSLayout

-(instancetype)init
{
    self = [super init];
    
    if (self) {
        
        self.linesNumbers = LSDefaultlinesNumbers;
        self.linesMargin = LSDefaultLinesMargin;
        self.rowsMargin = LSDefaultRowsMargin;
        self.contentTopAndBottomMargin = LSDefaultContentTopAndBottomMargin;
        self.contentLeftAndRightMargin = LSDefaultContentLeftAndRightMargin;
    }
    
    return self;
}

//
-(NSMutableArray *)lineHeightArray
{
    if (_lineHeightArray == nil) {
        
        _lineHeightArray = [NSMutableArray new];
        
    }
    
    return _lineHeightArray;
}

-(NSMutableArray *)cellAttributeArray
{
    if (_cellAttributeArray == nil) {
        
        _cellAttributeArray = [NSMutableArray new];
    }
    
    return _cellAttributeArray;
}


//决定视图的 contentsize,
-(CGSize)collectionViewContentSize
{
    NSNumber * max = [_lineHeightArray valueForKeyPath:@"@max.floatValue"];
    
    return CGSizeMake(0, [max floatValue] + 10);
    
}

//准备视图
-(void)prepareLayout
{
    [super prepareLayout];
    
    //重置数据
    [self.lineHeightArray removeAllObjects];
    
    //3列数据的初始高度。
    for (int i = 0;  i < self.linesNumbers; i++) {
        
        [self.lineHeightArray addObject:@(self.contentTopAndBottomMargin)];
        
    }
    
    //
    [self.cellAttributeArray removeAllObjects];
    //拿出全部的cell
    NSUInteger count = [self.collectionView numberOfItemsInSection:0];
    
    //遍历每个cell.
    for (NSUInteger i = 0; i < count; i++) {
        
        NSIndexPath * index = [NSIndexPath indexPathForItem:i inSection:0];
        
        UICollectionViewLayoutAttributes * attributes = [self layoutAttributesForItemAtIndexPath:index];
        
        [self.cellAttributeArray addObject:attributes];
        
    }
    
}
//所有cell的属性
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.cellAttributeArray;
}

//计算cell高度数据。
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //获取初始的属性。
    UICollectionViewLayoutAttributes * attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    //计算出。在x轴方向上所有的间隔。
    CGFloat xMargin = self.contentLeftAndRightMargin * 2 + (self.linesNumbers - 1) * self.linesMargin;
    
    //计算cell的宽度。
    CGFloat cellWidth = ([UIScreen mainScreen].bounds.size.width - xMargin) / self.linesNumbers;
    
    //外部计算完成后传入。
    //cell的高度。
    CGFloat cellHeight = [self.delegate getTheCellHeight];
    
    //计算出最短的那一列。
    CGFloat maxY = [self.lineHeightArray[0] doubleValue];
    NSUInteger column = 0;
    
    for (NSUInteger i = 1; i < self.lineHeightArray.count; i++) {
        
        CGFloat columnMaxY = [self.lineHeightArray[i] doubleValue];
        
        if (maxY > columnMaxY) {
            
            maxY = columnMaxY;
            column = i;
        }
    }
    
    //计算cell的x值。
    CGFloat cellX = self.contentLeftAndRightMargin + column * (cellWidth + self.linesMargin);
    
    //计算cell的y值。
    CGFloat cellY = maxY + self.rowsMargin;
    
    attributes.frame = CGRectMake(cellX, cellY, cellWidth, cellHeight);
    
    self.lineHeightArray[column] = @(CGRectGetMaxY(attributes.frame));
    
    
    return attributes;

}




@end
