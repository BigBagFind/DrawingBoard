//
//  MainBoard.h
//  DrawingBoard
//
//  Created by 吴玉铁 on 15/8/18.
//  Copyright (c) 2015年 铁哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainBoard : UIView
@property (nonatomic,strong) UIColor *color;
@property (nonatomic,assign) CGFloat lineWidth;
@property (nonatomic,assign) CGMutablePathRef path;
@property (nonatomic,strong) NSMutableArray *pathes;
@property (nonatomic,strong) UIColor *bGColor;
@property (nonatomic,strong) NSMutableArray *deletePathes;
- (void)undo;
- (void)goForward;
- (void)clear;




@end
