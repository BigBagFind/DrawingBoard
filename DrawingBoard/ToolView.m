
//
//  ToolView.m
//  DrawingBoard
//
//  Created by 吴玉铁 on 15/8/18.
//  Copyright (c) 2015年 铁哥. All rights reserved.
//

#import "ToolView.h"

@implementation ToolView

- (instancetype) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //创建按钮的视图。
        [self _createButtonView];
        [self _createColorsView];
        [self _createLinesView];
        [self _createRGBInputText];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moodAction) name:@"moodAction" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(vipColorAction) name:@"vipColorAction" object:nil];
    }
    return self;
}
- (void)moodAction{
    if(self.selectEraser){
        self.selectEraser();
    }
}
- (void)_createButtonView{
    NSArray *titles = @[@"Color",@"Width",@"Eraser",@"Back",@"Frwrd",@"Clear"];
    _buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), 25)];
  
    [self addSubview:_buttonView];
    CGFloat width = self.bounds.size.width / titles.count;
    for (int index = 0; index < titles.count; index ++) {
        MyButton *button = [[MyButton alloc] initWithFrame:CGRectMake(index * width, 0, width, 40)];
        if (index % 2 == 0) {
            button.backgroundColor = [UIColor cyanColor];
        }else{
            button.backgroundColor = [UIColor greenColor];
        }
        [button setTitle:titles[index] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont fontWithName:@"ChalkboardSE-Bold" size:16];
        [_buttonView addSubview:button];
        button.layer.cornerRadius = 15;
        button.layer.borderWidth = 3;
        button.layer.borderColor = [UIColor whiteColor].CGColor;
        [button addTarget:self action:@selector(tapButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 100 + index;
    }
    
    
}

- (void) _createColorsView {
    _colorsView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_buttonView.frame), 375, 50)];
    _colorsView.backgroundColor = [UIColor clearColor];
    _colorsView.hidden = YES;
    [self addSubview:_colorsView];
    _colors = [[NSMutableArray alloc]initWithObjects:
               [UIColor darkGrayColor],
               [UIColor redColor],
               [UIColor greenColor],
               [UIColor blueColor],
               [UIColor yellowColor],
               [UIColor orangeColor],
               [UIColor purpleColor],
               [UIColor brownColor],
               [UIColor blackColor], nil];
    CGFloat width = (self.bounds.size.width - 5) / _colors.count;
    for (int index = 0; index < _colors.count;  index ++) {
        MyButton *color = [[MyButton alloc]initWithFrame:CGRectMake(5 + width * index, CGRectGetMaxY(_buttonView.frame),width - 5,width - 5)];
        color.backgroundColor = _colors[index];
        color.layer.cornerRadius = (width - 5) / 2 ;
        color.layer.borderColor = [UIColor whiteColor].CGColor;
        color.layer.borderWidth = 3;
        [color addTarget:self action:@selector(tapColorAction:) forControlEvents:UIControlEventTouchUpInside];
        [_colorsView addSubview:color];
        color.tag = 100 + index;
    }
}
- (void) _createLinesView {
    _linesView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_buttonView.frame) + 20, 375, 50)];
    _linesView.backgroundColor = [UIColor clearColor];
    _linesView.hidden = YES;
    [self addSubview:_linesView];
    _lineWidthArray = @[@5.0,@10.0,@15.0,@20.0,@25.0,@30.0,@40.0];
    CGFloat width = self.bounds.size.width / _lineWidthArray.count;
    for ( int index = 0; index < _lineWidthArray.count; index ++) {
        MyButton *button = [MyButton buttonWithType:UIButtonTypeCustom];
        NSString *title = [NSString stringWithFormat:@"%@点",_lineWidthArray[index]];
        [button setTitle: title forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont fontWithName:@"GillSans-Bold" size:20];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.frame = CGRectMake(index * width, 5, width - 5, 40);
        button.layer.borderColor = [UIColor whiteColor].CGColor;
        button.layer.borderWidth = 3;
        button.layer.cornerRadius = (width / 2) - 10;
        [_linesView addSubview:button];
        [button addTarget:self action:@selector(tapLineWidthAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 100 + index;
    }
    
}
- (void)tapButtonAction:(UIButton *)button{
   //NSLog(@"touch");
    MyButton *currentbutton = (MyButton *)button;
    currentbutton.selectedState = !currentbutton.selectedState;
    _selectedButton.selectedState = !_selectedButton.selectedState;
    _selectedButton = currentbutton;
    switch (button.tag - 100) {
        case 0:{
            _linesView.hidden = YES;
            _colorsView.hidden = !_colorsView.hidden;
            break;
        }
        case 1:{
            _colorsView.hidden = YES;
            _linesView.hidden = !_linesView.hidden;
            break;
        }
        case 2:{
            if(self.selectEraser){
                self.selectEraser();
            }
            break;
        }
        case 3:{
            if (self.selectBack) {
                self.selectBack();
            }
            break;
        }
        case 4:{
            if(self.selectForword){
                self.selectForword();
            }
            break;
        }
        case 5:{
            if (self.selectClear) {
                self.selectClear();
            }
            break;
        }
        default:
            break;
    }
    
    
}
- (void)tapColorAction:(UIButton *)button{
 //   NSLog(@"dd");
    MyButton *currentbutton = (MyButton *)button;
    currentbutton.selectedState = !currentbutton.selectedState;
    _selectedColorButton.selectedState = !_selectedColorButton.selectedState;
    _selectedColorButton = currentbutton;
    if (button.tag == 108) {
        _RGBtextView.hidden = !_RGBtextView.hidden;
    }
    UIColor *color = _colors[button.tag - 100];
    if (_selectColorBlock) {
        _selectColorBlock(color);
    }
    
}
- (void)tapLineWidthAction:(UIButton *)button{
    MyButton *currentbutton = (MyButton *)button;
    currentbutton.selectedState = !currentbutton.selectedState;
    _selectedWidthButton.selectedState = !_selectedWidthButton.selectedState;
    _selectedWidthButton = currentbutton;
    NSString *string = _lineWidthArray[button.tag - 100];
    if (_selectWidthBlock) {
        _selectWidthBlock([string floatValue]);
    }
    
}
- (void)vipColorAction{
    
    // NSLog(@"%@",[self viewWithTag:108]);
    MyButton *vipButton = (MyButton *)[self viewWithTag:108];
    [vipButton setTitle:@"V" forState:UIControlStateNormal];
    vipButton.titleLabel.font = [UIFont boldSystemFontOfSize:28];
    [vipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    vipButton.backgroundColor = _customColor;
    [self addSubview:_RGBtextView];
    _RGBtextView.hidden = YES;
}
- (void)_createRGBInputText{
    _RGBtextView = [[UIView alloc]initWithFrame:CGRectMake(0,95, self.bounds.size.width,40)];
    //_RGBtextView.backgroundColor = [UIColor darkGrayColor];
    NSArray *array = @[@"R:0~1",
                       @"G:0~1",
                       @"B:0~1",];
    for (NSInteger index = 0; index < 3; index ++) {
        UITextField *_text = [[UITextField alloc]initWithFrame:CGRectMake(10 + 75 * index,0, 65, 40)];
        _text.borderStyle = UITextBorderStyleRoundedRect;
        _text.placeholder = array[index];
        _text.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        _text.spellCheckingType = UITextSpellCheckingTypeNo;
        [_RGBtextView addSubview:_text];
        _text.tag = 200 + index;
    }
    UIButton *OKbutton = [[UIButton alloc]initWithFrame:CGRectMake(235, 0, 55, 40)];
    [OKbutton setTitle:@"OK" forState:UIControlStateNormal];
    OKbutton.layer.cornerRadius = 10;
    [OKbutton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    OKbutton.backgroundColor = [UIColor darkGrayColor];
    [OKbutton addTarget:self action:@selector(OKButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_RGBtextView addSubview:OKbutton];
    _RGBtextView.hidden = YES;
    
}
- (void)OKButtonAction:(UIButton *)button{
    NSMutableArray *RGB = [[NSMutableArray alloc]initWithObjects:@"0",@"0",@"0", nil];
    for (NSInteger index = 0; index < 3; index ++) {
        UITextField *text = (UITextField *)[self viewWithTag:200 + index];
        text.autocorrectionType = UITextAutocorrectionTypeNo;
        if (![text.text  isEqual: @""] && [text.text floatValue] <= 1) {
            [RGB removeObjectAtIndex:index];
            [RGB insertObject:text.text atIndex:index];
        }
    }
    _customColor = [UIColor colorWithRed:[RGB[0] floatValue] green:[RGB[1] floatValue] blue:[RGB[2] floatValue] alpha:1];
    [_colors removeLastObject];
    [_colors addObject:_customColor];
        if (_selectColorBlock) {
            _selectColorBlock(_customColor);
        }
     MyButton *vipButton = (MyButton *)[self viewWithTag:108];
     vipButton.backgroundColor = _customColor;
    UITextField *lastTextFiled = (UITextField *)[self viewWithTag:202];
    [lastTextFiled resignFirstResponder];
    
}
@end
