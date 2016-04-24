//
//  ToolView.h
//  DrawingBoard
//
//  Created by 吴玉铁 on 15/8/18.
//  Copyright (c) 2015年 铁哥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyButton.h"

typedef void(^SelectColorBlock)(UIColor *);
typedef void(^SelectWidthBlock)(CGFloat);
typedef void(^SelectButtonBlock)();

@interface ToolView : UIView{
    UIView *_buttonView;
    MyButton *_selectedButton;
    MyButton *_selectedColorButton;
    MyButton *_selectedWidthButton;
    UIView *_colorsView;
    UIView *_linesView;
    NSMutableArray *_colors;
    NSArray *_lineWidthArray;
    MyButton *_vipColor;
    UIView *_RGBtextView;
    UIColor *_customColor;
}
@property (nonatomic,copy) SelectColorBlock selectColorBlock;
@property (nonatomic,copy) SelectWidthBlock selectWidthBlock;
@property (nonatomic,copy) SelectButtonBlock selectEraser;
@property (nonatomic,copy) SelectButtonBlock selectBack;
@property (nonatomic,copy) SelectButtonBlock selectClear;
@property (nonatomic,copy) SelectButtonBlock selectForword;

@end
