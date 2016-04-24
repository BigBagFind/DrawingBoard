//
//  PathModel.m
//  DrawingBoard
//
//  Created by 吴玉铁 on 15/8/18.
//  Copyright (c) 2015年 铁哥. All rights reserved.
//

#import "PathModel.h"

@implementation PathModel


- (void)dealloc{
    CGPathRelease(self.path);
}

- (void)setPath:(CGMutablePathRef)path{
 
    if (_path != path) {
        _path = path;
        CGPathRetain(path);
    }
    
    
}

@end
