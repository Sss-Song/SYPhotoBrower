//
//  SYPhotoListCell.m
//  SYPhotoBrower
//
//  Created by 宋成博 on 17/7/24.
//  Copyright © 2017年 宋成博. All rights reserved.
//

#import "SYPhotoListCell.h"

@implementation SYPhotoListCell


-(instancetype)initWithFrame:(CGRect)frame{

    if (self=[super initWithFrame:frame]) {
        
        [self createUI];
    }
    return self;
}

-(void)createUI{

    UIImageView *img =[[UIImageView alloc]init];
    img.frame = self.bounds;
    img.backgroundColor =[UIColor cyanColor];
    [self.contentView addSubview:img];
    self.img = img;
}

@end
