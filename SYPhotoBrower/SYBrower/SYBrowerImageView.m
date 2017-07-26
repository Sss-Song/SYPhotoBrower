//
//  SYBrowerImageView.m
//  SYPhotoBrower
//
//  Created by 宋成博 on 17/7/25.
//  Copyright © 2017年 宋成博. All rights reserved.
//

#import "SYBrowerImageView.h"
#import "UIImageView+WebCache.h"
@implementation SYBrowerImageView

-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}


-(void)setImageWithUrl:(NSURL *)url PlaceholderImage:(UIImage *)placeholerImage{

    [self sd_setImageWithURL:url placeholderImage:placeholerImage options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        
    }];
}

@end
