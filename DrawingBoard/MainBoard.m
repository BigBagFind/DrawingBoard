//
//  MainBoard.m
//  DrawingBoard
//
//  Created by 吴玉铁 on 15/8/18.
//  Copyright (c) 2015年 铁哥. All rights reserved.
//

#import "MainBoard.h"
#import "PathModel.h"
@implementation MainBoard

- (void)undo{
    if (self.pathes.count > 0) {
        [self.deletePathes addObject:[self.pathes lastObject]];
        [self.pathes removeLastObject];
        [self setNeedsDisplay];
    }
   
    
}
- (void)goForward{
    if (self.deletePathes.count > 0) {
        [self.pathes addObject:[self.deletePathes lastObject]];
        [self.deletePathes removeLastObject];
        [self setNeedsDisplay];
    }
   
}
- (void)clear{
    [self.pathes removeAllObjects];
    [self setNeedsDisplay];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _color = [UIColor blackColor];
        _lineWidth = 5.0;
        self.backgroundColor = [UIColor whiteColor];
        _deletePathes = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    
    for (PathModel *pathModel in self.pathes) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        [pathModel.color setStroke];
        CGContextSetLineWidth(context, pathModel.lineWidth);
        CGContextSetLineJoin(context, kCGLineJoinRound);
        CGContextSetLineCap(context, kCGLineCapRound);
        CGContextAddPath(context, pathModel.path);
        CGContextDrawPath(context, kCGPathStroke);
    }
    if (self.path != nil) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        [self.color setStroke];
        CGContextSetLineWidth(context, self.lineWidth);
        CGContextSetLineJoin(context, kCGLineJoinRound);
        CGContextSetLineCap(context, kCGLineCapRound);
        CGContextAddPath(context, self.path);
        CGContextDrawPath(context, kCGPathStroke);
    }else{
        [super drawRect:rect];
    }
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint firstPoint = [touch locationInView:self];
    self.path = CGPathCreateMutable();
    CGPathMoveToPoint(self.path, NULL, firstPoint.x, firstPoint.y);
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint movePoint = [touch locationInView:self];
    CGPathAddLineToPoint(self.path, NULL, movePoint.x, movePoint.y);
    [self setNeedsDisplay];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if(self.pathes == nil){
        self.pathes = [NSMutableArray array];
    }
    PathModel *pathModel = [[PathModel alloc]init];
    pathModel.color = self.color;
    pathModel.lineWidth = self.lineWidth;
    pathModel.path = self.path;
    [self.pathes addObject:pathModel];
    CGPathRelease(self.path);
    self.path = nil;
}

@end
