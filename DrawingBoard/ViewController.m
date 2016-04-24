//
//  ViewController.m
//  DrawingBoard
//
//  Created by 吴玉铁 on 15/8/18.
//  Copyright (c) 2015年 铁哥. All rights reserved.
//

#import "ViewController.h"
#import "MyButton.h"
#import "MainBoard.h"
#import "ToolView.h"
#import "ImageUtill.h"
@interface ViewController ()<UIAlertViewDelegate>{
    MainBoard *_mainBoard;
    UIColor *_moodColor;
    UIButton *_cutButton;
    UIView *_tempView;
    UIView *_maskView;
    UIAlertView *_savePhoto;
    UIButton *_vipButton;
    UIAlertView *_vipAlert;
    UIAlertView *_confirmAlert;
    UIAlertView *_successAlert;
    UIActivityIndicatorView *_indicator;
    UIView *_indicatorView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _mainBoard = [[MainBoard alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_mainBoard];
    _mainBoard.backgroundColor = [UIColor yellowColor];
    _moodColor = [UIColor yellowColor];
    ToolView *_toolView = [[ToolView alloc] initWithFrame:CGRectMake(0, 20,self.view.bounds.size.width,150)];
    [self.view addSubview:_toolView];
    [self _createViews];
    
    _toolView.selectColorBlock = ^(UIColor *color){
        _mainBoard.color = color;
    };
    _toolView.selectWidthBlock = ^(CGFloat lineWidth){
        _mainBoard.lineWidth =lineWidth;
    };
    _toolView.selectEraser = ^(){
        
        _mainBoard.color = _moodColor;
    };
    _toolView.selectBack = ^(){
        [_mainBoard undo];
    };
    _toolView.selectForword = ^(){
        [_mainBoard goForward];
    };
    _toolView.selectClear = ^(){
        [_mainBoard clear];
    };
}

- (void)_createViews{
    //换个心情按钮
    UIButton *mood = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width - 80, 105, 80, 60)];
    UIImage *image = [UIImage imageNamed:@"pp"];
    image = [ImageUtill waterMaskImage:image text:@"Feeling"];
    [mood setImage:image forState:UIControlStateNormal];
    [self.view addSubview:mood];
    [mood addTarget:self action:@selector(moodAction:) forControlEvents:UIControlEventTouchUpInside];
    //vip按钮
    _vipButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width - 80, 235, 80, 60)];
    [_vipButton setImage:[UIImage imageNamed:@"kingPP"] forState:UIControlStateNormal];
    [self.view addSubview:_vipButton];
    [_vipButton addTarget:self action:@selector(vipButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    //截图
    _tempView = [[UIView alloc]init];
    _tempView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    //maskView
    _maskView = [[UIView alloc]initWithFrame:self.view.bounds];
    _maskView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_maskView];
    _maskView.hidden = YES;
    //拖动
    UIPanGestureRecognizer  *panGestreRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [_maskView addGestureRecognizer:panGestreRecognizer];
    //截图剪刀按钮
    _cutButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width - 80, 170, 80, 60)];
    [_cutButton setBackgroundImage:[UIImage imageNamed:@"cutPP"] forState:UIControlStateNormal];
    [_cutButton setBackgroundImage:[UIImage imageNamed:@"cutPP_s"] forState:UIControlStateSelected];
    [_cutButton addTarget:self action:@selector(cutButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cutButton];
    //警告视图
    _savePhoto = [[UIAlertView alloc]initWithTitle:@"Photo Tip" message:@"Would you save the photo ?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    _savePhoto.tag = 101;
    [self.view addSubview:_savePhoto];
    _vipAlert = [[UIAlertView alloc]initWithTitle:@"Vip Tip"message:@"Would you want to be Vip ?" delegate:self cancelButtonTitle:@"No,I don't" otherButtonTitles:@"Yes,I do", nil];
    _vipAlert.tag = 102;
    [self.view addSubview:_vipButton];
    _confirmAlert = [[UIAlertView alloc]initWithTitle:@"Warning" message:@"It would deduct your ￥:10" delegate:self cancelButtonTitle:@"Sorry,I cann't afford" otherButtonTitles:@"Yes,pay ￥:10", nil];
    _confirmAlert.tag = 103;
    [self.view addSubview:_confirmAlert];
    _successAlert = [[UIAlertView alloc]initWithTitle:@"Success Tip" message:@"Amazing,You can use Custom colors AfterNow!" delegate:self cancelButtonTitle:@"OK,Thanks" otherButtonTitles:nil, nil];
    _successAlert.tag = 104;
    [self.view addSubview:_successAlert];
    //菊花转
    _indicatorView = [[UIView alloc]initWithFrame:CGRectMake((self.view.bounds.size.width - 40) / 2,(self.view.bounds.size.height - 40) / 2, 40, 40)];
    _indicatorView.backgroundColor = [UIColor blackColor];
     [self.view addSubview:_indicatorView];
    _indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [_indicatorView addSubview:_indicator];
    [_indicator startAnimating];
    _indicatorView.hidden = YES;
}
#pragma mark -ButtonAction
- (void)moodAction: (UIButton *)button{
   
    _moodColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:(rand() % 255) / 255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
   
    _mainBoard.backgroundColor = _moodColor;
    [_mainBoard clear];
    [self.view setNeedsDisplay];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"moodAction" object:nil];
    
}
- (void)cutButtonAction: (UIButton *)button{
    button.selected = !button.selected;
    _maskView.hidden = !_maskView.hidden;
    
}
- (void)vipButtonAction: (UIButton *)button{
    [_vipAlert show];
    
}
#pragma mark -panchAction
- (void)panAction:(UIPanGestureRecognizer *)pan{
    static CGPoint startPoint;
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        startPoint = [pan locationInView:self.view];
    }
    if (pan.state == UIGestureRecognizerStateChanged) {
        
        CGPoint point = [pan locationInView:self.view];
        float moveX = point.x - startPoint.x;
        float moveY = point.y - startPoint.y;
        CGRect frame = _tempView.frame;
        frame.size.width += moveX;
        frame.size.height += moveY;
        
        _tempView.frame = CGRectMake(startPoint.x, startPoint.y, moveX, moveY);
        
        [self.view addSubview:_tempView];
        
    }
    if (pan.state == UIGestureRecognizerStateEnded){
        [_savePhoto show];
        _tempView.hidden = YES;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 101) {
        if (buttonIndex == 1) {
            UIGraphicsBeginImageContext(self.view.bounds.size);
            CGContextRef context = UIGraphicsGetCurrentContext();
            UIRectClip(_tempView.frame);
            [self.view.layer renderInContext:context];
            UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
        }
        _tempView.frame = CGRectMake(0, 0, 0, 0);
        _tempView.hidden = NO;
        _cutButton.selected = !_cutButton.selected;
        _maskView.hidden = !_maskView.hidden;
    }else if(alertView.tag == 102){
        if (buttonIndex == 1) {
            [_confirmAlert show];
        }
    }else if(alertView.tag == 103){
        if (buttonIndex == 1) {
        _indicatorView.hidden = NO;
        [self performSelector:@selector(indicatorViewHidden) withObject:nil afterDelay:0.8];
        }
      
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    NSLog(@"保存相册照片");
    
}
- (void)indicatorViewHidden{
    [_successAlert show];
    _indicatorView.hidden = YES;
    _vipAlert = [[UIAlertView alloc]initWithTitle:@"Welcome Vip"message:@"VIP can retain 365656 days " delegate:self cancelButtonTitle:@"Thank you!" otherButtonTitles: nil];

    [[NSNotificationCenter defaultCenter]postNotificationName:@"vipColorAction" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
