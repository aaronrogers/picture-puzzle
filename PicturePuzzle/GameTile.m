//
//  GameTile.m
//  PicturePuzzle
//
//  Created by Aaron Rogers on 9/11/12.
//  Copyright (c) 2012 Rocketmade. All rights reserved.
//

#import "GameTile.h"

@interface GameTile ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *selectIndicator;
@property (nonatomic, strong) UIView *tapView;

- (void)setImageViewImageFromImage:(UIImage *)image bounds:(CGRect)imageBounds;

@end

@implementation GameTile

- (void)setImageViewImageFromImage:(UIImage *)image bounds:(CGRect)imageBounds
{
    CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, imageBounds);
    UIImage *result = [UIImage imageWithCGImage:imageRef scale:image.scale orientation:image.imageOrientation];
    CGImageRelease(imageRef);

    self.imageView.image = result;
}

- (void)setSelected:(BOOL)aSelected
{
    _selected = aSelected;

    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationCurveEaseInOut animations:^{
        self.selectIndicator.alpha = _selected ? 0.2 : 0;
    } completion:nil];
}






















































#pragma mark - Other



@synthesize imageView = _imageView;
@synthesize selected = _selected;
@synthesize selectIndicator = _selectIndicator;
@synthesize tapView = _tapView;


- (id)initWithFrame:(CGRect)frame gameImage:(UIImage *)gameImage tileImageBounds:(CGRect)tileImageBounds
{
    if (self = [super initWithFrame:frame])
    {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:_imageView];

        [self setImageViewImageFromImage:gameImage bounds:tileImageBounds];

        self.selectIndicator = [[UIView alloc] initWithFrame:CGRectInset(self.imageView.frame, 2, 2)];
        self.selectIndicator.alpha = 0;
        self.selectIndicator.backgroundColor = [UIColor blueColor];
        [self addSubview:self.selectIndicator];

        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        self.tapView = [[UIView alloc] initWithFrame:self.imageView.frame];
        [self.tapView addGestureRecognizer:tapRecognizer];
        [self addSubview:self.tapView];
    }

    return self;
}

- (void)handleTap:(UITapGestureRecognizer *)aTapRecognizer
{
    [self.delegate gameTileWasTapped:self];
}

@end
