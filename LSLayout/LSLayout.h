//
//  LSLayout.h
//  LSLayout
//
//  Created by noci on 16/9/22.
//  Copyright © 2016年 noci. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LSLayoutDelegate <NSObject>

//获取cell所应该有的高度。
-(CGFloat)getTheCellHeight;

@optional

@end


@interface LSLayout : UICollectionViewLayout

@property(nonatomic,weak)id delegate;

@property(nonatomic,assign)int linesNumbers;
@property(nonatomic,assign)float rowsMargin;
@property(nonatomic,assign)float linesMargin;
@property(nonatomic,assign)float contentTopAndBottomMargin;
@property(nonatomic,assign)float contentLeftAndRightMargin;

@end
