//
//  DrawView.m
//  PicturePuzzle
//
//  Created by Aaron Rogers on 9/12/12.
//  Copyright (c) 2012 Rocketmade. All rights reserved.
//

#import "DrawView.h"

@interface DrawView ()

@property (nonatomic, assign) CGPoint pointA;
@property (nonatomic, assign) CGPoint pointB;

@end

@implementation DrawView

- (void)presentLineFrom:(CGPoint)aPointA to:(CGPoint)aPointB
{
    self.pointA = aPointA;
    self.pointB = aPointB;
    [self setNeedsDisplay];

    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationCurveEaseInOut animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 delay:0.5 options:UIViewAnimationCurveEaseInOut animations:^{
            self.alpha = 0;
        } completion:nil];
    }];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];

    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetRGBStrokeColor(context, 0.5, 0, 0, 0.75);
    CGContextSetLineWidth(context, 5);
    CGContextSetLineCap(context, kCGLineCapRound);

    CGContextMoveToPoint(context, self.pointA.x, self.pointA.y);
    CGContextAddLineToPoint(context, self.pointB.x, self.pointB.y);

    CGContextStrokePath(context);
}

@end
