//
//  SYPhotoBrower.m
//  SYPhotoBrower
//
//  Created by 宋成博 on 17/7/25.
//  Copyright © 2017年 宋成博. All rights reserved.
//

#import "SYPhotoBrower.h"
#import "SYPhotoBrowerConfig.h"
#import "SYBrowerImageView.h"
#import "UIImageView+WebCache.h"

@interface SYPhotoBrower()<UIScrollViewDelegate>
/** 放置图片的scrollView */
@property(nonatomic,weak)UIScrollView *scrollView;
/** 是否展示第一个view */
@property(nonatomic,assign)BOOL hasShowFirstView;
/** 分页控制器 */
@property(nonatomic,weak)UIPageControl *pageControl;
/** 是否将要消失 */
@property(nonatomic,assign)BOOL willDismiss;
@end

@implementation SYPhotoBrower

#pragma mark - 供外部调用的方法
//展示图片浏览器
-(void)sy_showPhotoBrwer{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.frame = window.bounds;
    [window addSubview:self];
    
    [self createScrollView];
    
    [self createPageControl];
}


#pragma mark - main
-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = SYPhotoBrowerBackgroundColor;
    }
    return self;
}

-(void)didMoveToSuperview{
    
   
}


#pragma mark - 创建滚动图
-(void)createScrollView{
    
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.delegate = self;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.backgroundColor =[UIColor yellowColor];
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    
    NSLog(@"----%ld",self.imagesCount);
    
    for (UIView *sub in self.scrollView.subviews) {
        [sub removeFromSuperview];
    }
    
    for (int i =0; i<self.imagesCount; i++) {
        
        UIImageView *image =[[UIImageView alloc]init];
        image.backgroundColor =[UIColor redColor];
        [self.scrollView addSubview:image];
//        [self addGestureToImageView:image]; //给图片添加手势事件
        NSLog(@"创%d次",i);
    }
    
    NSLog(@">>>>>>%ld",self.scrollView.subviews.count);
    
    [self setUpImageForImageViewWithIndex:self.currentIndex];
}

//*****根据当前的索引展示图片(核心方法,滑动一张调用一次,展示当前图片)
-(void)setUpImageForImageViewWithIndex:(NSInteger)index{

    UIImageView *currentImageView = self.scrollView.subviews[index];
    
    self.currentIndex = index;
    
//    if (currentImageView.hasLoadImage==YES) return; //已经看过的图片就不用现去加载了 直接展示就好了
    
    if ([self getUrlAtIndex:index]) {  //如果拿到了图片的url 加载url
        
//        [currentImageView setImageWithUrl:[self getUrlAtIndex:index] PlaceholderImage:[self getPlaceholderImageAtIndex:index]];
        
        [currentImageView sd_setImageWithURL:[self getUrlAtIndex:index]];
        
    } else {  // 否则加载拿到的image对象
        
        currentImageView.image = [self getPlaceholderImageAtIndex:index];
    }
    
//      currentImageView.hasLoadImage = YES;
    
}




//通过代理获取列表里imageView的image
-(UIImage *)getPlaceholderImageAtIndex:(NSInteger)index{
   
    if (self.delegate&&[self.delegate respondsToSelector:@selector(photoBrower:getImageAtIndex:)]) {
        
        return [self.delegate photoBrower:self getImageAtIndex:index];
        
    }else{
        return nil;
    }
}

//通过代理获取列表里imageView的url
-(NSURL *)getUrlAtIndex:(NSInteger)index{

    if (self.delegate&&[self.delegate respondsToSelector:@selector(photoBrower:getImageViewUrlAtIndex:)]) {
     
        return [self.delegate photoBrower:self getImageViewUrlAtIndex:index];
    }else{
        return nil;
    }
}


#pragma mark - 图片添加点击手势
-(void)addGestureToImageView:(UIImageView *)imageView{
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTapClick:)];
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleClick:)];
    //这句是为了处理单击和双击的手势冲突事件 意思是单击后暂时不进行识别(稍作停顿)，直到确定不是双击事件后再识别为单击事件。
    [singleTap requireGestureRecognizerToFail:doubleTap];
    UILongPressGestureRecognizer *longTag = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longClick:)];
    [imageView addGestureRecognizer:singleTap];
    [imageView addGestureRecognizer:doubleTap];
    [imageView addGestureRecognizer:longTag];
}



-(void)createPageControl{
    
    
}


-(void)layoutSubviews{

    [super layoutSubviews];
    
    // 获取到自己的bounds
    CGRect rect = self.bounds;
    rect.size.width += 20;
    _scrollView.bounds = rect;
    _scrollView.center = self.center;
    
    CGFloat y = 0;
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    CGFloat h = [UIScreen mainScreen].bounds.size.height;
    
    // 布局ScrollView子控件的frame
    [_scrollView.subviews enumerateObjectsUsingBlock:^(UIImageView *obj, NSUInteger idx, BOOL *stop) {
        CGFloat x = 10 + idx * (20 + w);
        obj.frame = CGRectMake(x,y,w,h);
        NSLog(@"----------%@",NSStringFromCGRect(obj.frame));
    }];
    
    _scrollView.contentSize = CGSizeMake(self.scrollView.subviews.count * self.scrollView.frame.size.width, 0);
    //展示当前的图片
    _scrollView.contentOffset = CGPointMake(self.currentIndex * self.scrollView.frame.size.width, 0);
    
    NSLog(@"%ld",self.scrollView.subviews.count);
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

     NSInteger index = (scrollView.contentOffset.x + _scrollView.bounds.size.width * 0.5) / _scrollView.bounds.size.width;
    
    [self setUpImageForImageViewWithIndex:index];
}



@end







































