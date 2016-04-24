//
//  PathModel.h
//  DrawingBoard
//
//  Created by 吴玉铁 on 15/8/18.
//  Copyright (c) 2015年 铁哥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface PathModel : NSObject

@property (nonatomic,assign) CGMutablePathRef path;
@property (nonatomic,strong) UIColor *color;
@property (nonatomic,assign) CGFloat lineWidth;

@end
