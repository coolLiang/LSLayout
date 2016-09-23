//
//  LSSliderFlowLayout.m
//  LSLayout
//
//  Created by noci on 16/9/22.
//  Copyright © 2016年 noci. All rights reserved.
//

#import "LSSliderFlowLayout.h"

@implementation LSSliderFlowLayout

-(instancetype)init
{
    self = [super init];
    
    if (self) {
        
        
    }
    return self;
}

//显示范围改变时。是否进行刷新页面。
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

-(void)prepareLayout
{
    [super prepareLayout];
    
    //纵向滑动
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //设置内边距
    CGFloat inset = (self.collectionView.frame.size.width - self.itemSize.width) * 0.5;
    
    //
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
    
}

//所有元素的属性数组
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray * array = [super layoutAttributesForElementsInRect:rect];
    
    //计算中心点x的值。
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    //在原有布局的基础上。进行微调。
    for (UICollectionViewLayoutAttributes * attributes in array) {
        
        //计算cell的中心 到 视图的中点的距离。
        //ABS 求绝对值
        CGFloat centerMargin = ABS(attributes.center.x - centerX);
        
        //根据间隔计算缩放比例
        CGFloat scale = 1 - centerMargin / self.collectionView.frame.size.width;
        
        //设置缩放比例
        attributes.transform = CGAffineTransformMakeScale(scale, scale);
    }
    
    return array;
    
}

//该方法觉得了视图停止滚动后的偏移值。
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    CGRect rect;
    
    rect.origin.y = 0;
    rect.origin.x = proposedContentOffset.x;
    rect.size = self.collectionView.frame.size;
    
    //获取视图停止时 其中显示元素的属性数据
    NSArray * array = [super layoutAttributesForElementsInRect:rect];
    
    //计算视图中心点X值。
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    //计算最小的间距值。
    CGFloat minMargin = MAXFLOAT;
    
    for (UICollectionViewLayoutAttributes * attributes in array) {
        
        if (ABS(minMargin) > ABS(attributes.center.x - centerX)) {
            
            minMargin = attributes.center.x - centerX;
        }
    }
    
    proposedContentOffset.x += minMargin;
    
    return proposedContentOffset;

}

@end
