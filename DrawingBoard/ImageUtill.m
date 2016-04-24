//
//  ImageUtill.m
//  DrawingBoard
//
//  Created by 吴玉铁 on 15/8/19.
//  Copyright (c) 2015年 铁哥. All rights reserved.
//

#import "ImageUtill.h"

@implementation ImageUtill


+ (UIImage *)waterMaskImage:(UIImage *)image text:(NSString *)text{
    UIGraphicsBeginImageContext(image.size);
    //绘制内容
    [image drawInRect:CGRectMake(0, 0, image.size.width,image.size.height)];
    CGRect frame = CGRectMake(45, 80,100,80);
    

    NSDictionary *attributes = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:28],
                                 NSForegroundColorAttributeName:[UIColor whiteColor]};
    [text drawInRect:frame withAttributes:attributes];
    
    //获取图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
