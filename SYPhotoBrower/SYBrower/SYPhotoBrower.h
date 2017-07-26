//
//  SYPhotoBrower.h
//  SYPhotoBrower
//
//  Created by 宋成博 on 17/7/25.
//  Copyright © 2017年 宋成博. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SYPhotoBrower;

@protocol SYPhotoBrowerDelegate <NSObject>
/** 代理方法:返回网络图片链接 */
-(NSURL *)photoBrower:(SYPhotoBrower *)photoBrwoer getImageViewUrlAtIndex:(NSInteger)index;
/** 代理方法:返回图片image对象 */
-(UIImage *)photoBrower:(SYPhotoBrower *)photoBrower getImageAtIndex:(NSInteger)index;
@end

@interface SYPhotoBrower : UIView
/** 代理 */
@property(nonatomic,weak)id<SYPhotoBrowerDelegate> delegate;
/** 图片容器视图 */
@property(nonatomic,weak)UIView *imagesContainerView;
/** 当前图片的索引 */
@property(nonatomic,assign)NSInteger currentIndex;
/** 图片的个数 */
@property(nonatomic,assign)NSInteger imagesCount;
/**
 *  弹出图片浏览器
 */
-(void)sy_showPhotoBrwer;
@end


















