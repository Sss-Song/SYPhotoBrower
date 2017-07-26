//
//  ViewController.m
//  SYPhotoBrower
//
//  Created by 宋成博 on 17/7/24.
//  Copyright © 2017年 宋成博. All rights reserved.
//

#import "ViewController.h"
#import "SYPhotoListCell.h"
#import "SYPhotoBrower.h"
#import "UIImageView+WebCache.h"

static NSString *const cellID = @"cellID";
#define ScreenWidth [UIScreen mainScreen].bounds.size.width


@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,SYPhotoBrowerDelegate>

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)NSArray *dataArray;

@end

@implementation ViewController

-(NSArray *)dataArray{

    if (!_dataArray) {
        
        _dataArray = @[@"http://ww2.sinaimg.cn/mw690/e67669aagw1fbfr3ryrt2j21kw2dc4eo.jpg",
                       @"http://ww2.sinaimg.cn/mw690/e67669aagw1fbfr3ryrt2j21kw2dc4eo.jpg",
                       @"http://wx4.sinaimg.cn/mw690/63e6fd01ly1fe2iqm8d2wj20qo11cn5d.jpg",
                       @"http://ww4.sinaimg.cn/bmiddle/6a15cf5aly1fewww17l6rj20qo0yatfc.jpg",
                       @"http://wx3.sinaimg.cn/mw690/b024b1c1ly1feg7x4lu0cg20dw07te85.gif",
                       @"http://ww3.sinaimg.cn/bmiddle/c45009afgy1ff9r1z9nsgj20qo3abhcj.jpg",
                       @"http://img.juimg.com/tuku/yulantu/121114/240498-1211141R14150.jpg",
                       @"http://img2.3lian.com/2014/f2/175/d/15.jpg",
                       @"http://dynamic-image.yesky.com/600x-/uploadImages/2014/143/24/Z8L34RJTOONU.jpg"];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    
   [super viewDidLoad];
   
   [self createMain];
}

-(void)createMain{

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake((ScreenWidth - 30) / 2, 100);
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[SYPhotoListCell class] forCellWithReuseIdentifier:cellID];
    [self.view addSubview:self.collectionView];
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
   
    SYPhotoListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    [cell.img sd_setImageWithURL:self.dataArray[indexPath.row]];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    SYPhotoBrower *brower =[[SYPhotoBrower alloc]init];
    brower.delegate = self;
    brower.currentIndex = indexPath.row; //传入当前点击的图片索引
    brower.imagesCount = self.dataArray.count; //传入总的图片个数
    [brower sy_showPhotoBrwer];
}

#pragma mark - SYPhotoBrowerDelegate
-(NSURL *)photoBrower:(SYPhotoBrower *)photoBrwoer getImageViewUrlAtIndex:(NSInteger)index{
    
    return [NSURL URLWithString:self.dataArray[index]];
}

-(UIImage *)photoBrower:(SYPhotoBrower *)photoBrower getImageAtIndex:(NSInteger)index{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    SYPhotoListCell *cell = (SYPhotoListCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    return cell.img.image;
}

@end























