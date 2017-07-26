//
//  SYBrowerImageView.h
//  SYPhotoBrower
//
//  Created by 宋成博 on 17/7/25.
//  Copyright © 2017年 宋成博. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYBrowerImageView : UIImageView

/** 进度条 */
@property(nonatomic,assign)CGFloat progress;
/** 记录是否缩放 */
@property(nonatomic,assign,readonly)BOOL isScaled;
/** 记录是否已经加载图片 */
@property(nonatomic,assign)BOOL hasLoadImage;
/**
 *  清除缩放
 */
-(void)clearScale;
/**
 *  设置图片和占位图
 */
-(void)setImageWithUrl:(NSURL *)url PlaceholderImage:(UIImage *)placeholerImage;
/**
 *  双击缩放比例
 */
-(void)doubleTapToZommWithScale:(CGFloat)scale;
@end














