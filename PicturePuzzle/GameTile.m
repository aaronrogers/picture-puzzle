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


- (void)setImageViewImageFromImage:(UIImage *)image bounds:(CGRect)imageBounds;

@end

@implementation GameTile

- (void)setImageViewImageFromImage:(UIImage *)image bounds:(CGRect)imageBounds
{

}

- (void)setSelected:(BOOL)aSelected
{
    _selected = aSelected;
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
