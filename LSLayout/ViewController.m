//
//  ViewController.m
//  LSLayout
//
//  Created by noci on 16/9/22.
//  Copyright © 2016年 noci. All rights reserved.
//

#import "ViewController.h"

#import "LSLayout.h"

#import "LSSliderFlowLayout.h"

#import "LSCircleLayout.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,LSLayoutDelegate>

@property(nonatomic,strong)UICollectionView * lsCollectionView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LSLayout * lsLayout = [[LSLayout alloc]init];
    lsLayout.linesNumbers = 5;
    lsLayout.linesMargin = 5;
    lsLayout.rowsMargin = 5;
    lsLayout.contentTopAndBottomMargin = 5;
    lsLayout.contentLeftAndRightMargin = 0;
    lsLayout.delegate = self;
    
    
    LSSliderFlowLayout * lsSilderLayout = [[LSSliderFlowLayout alloc]init];
    lsSilderLayout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 200, 100);
    
    LSCircleLayout * lsCircleLayout = [[LSCircleLayout alloc]init];
    
    
//    self.lsCollectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:lsLayout];
    
//    self.lsCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, 150) collectionViewLayout:lsSilderLayout];
    
        self.lsCollectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:lsCircleLayout];
    
    self.lsCollectionView.delegate = self;
    self.lsCollectionView.dataSource = self;
    
    [self.lsCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.lsCollectionView];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 15;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor redColor];
    
    return cell;
}

//
-(CGFloat)getTheCellHeight
{
    return (arc4random() % 100) + 50;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
