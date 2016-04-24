

//
//  MyButton.m
//  DrawingBoard
//
//  Created by 吴玉铁 on 15/8/18.
//  Copyright (c) 2015年 铁哥. All rights reserved.
//

#import "MyButton.h"

@implementation MyButton

//- (instancetype)initWithFrame:(CGRect)frame{
//    if (self = [super initWithFrame:frame]) {
//       // [self _createBorder];
//    }
//    return self;
//}

- (void) setSelectedState:(BOOL)selectedState {
    if (selectedState != _selectedState) {
        _selectedState = selectedState;
    }
    if (self.selectedState) {
        self.layer.borderColor = [UIColor redColor].CGColor;
        self.layer.borderWidth = 3;
    }else {
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.borderWidth = 3;
    }
    
}







@end
