//
//  ViewController.m
//  PicturePuzzle
//
//  Created by Aaron Rogers on 9/11/12.
//  Copyright (c) 2012 Rocketmade. All rights reserved.
//

#import "GameBoardController.h"

#define kNumRows 3
#define kNumColums 3

@interface GameBoardController ()

- (void)moveGameTile:(GameTile *)aGameTile toFrame:(CGRect)aFrame;

@end

@implementation GameBoardController



#pragma mark - Areas to animate

- (void)moveGameTile:(GameTile *)aGameTile toFrame:(CGRect)aFrame
{
    aGameTile.frame = aFrame;
}


























































#pragma mark - Other Stuff
@synthesize gameImage = _gameImage;
@synthesize gameImageBounds = _gameImageBounds;
@synthesize tiles = _tiles;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    [self initializeTiles];
    self.selectedTiles = [NSMutableSet set];
    [self randomizeBoard];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (UIImage *)gameImage
{
    if (!_gameImage)
    {
        _gameImage = [UIImage imageNamed:@"beach.jpg"];
    }
    return _gameImage;
}

- (void)initializeTiles
{
    [self calculateGameImageBounds];
    NSUInteger numTiles = kNumColums * kNumRows;
    self.tiles = [NSMutableArray arrayWithCapacity:numTiles];

    for (NSUInteger i = 0; i < numTiles; i++)
    {
        [self addGameTileForColumn:(i % kNumColums) row:(i / kNumColums)];
    }
}

- (void)addGameTileForColumn:(NSUInteger)column row:(NSUInteger)row
{
    CGRect frame = self.view.frame;
    frame.size.width /= kNumColums;
    frame.size.height /= kNumRows;
    frame.origin.x = frame.size.width * column;
    frame.origin.y = frame.size.height * row;

    CGRect tileImageBounds = self.gameImageBounds;
    tileImageBounds.size.width /= kNumColums;
    tileImageBounds.size.height /= kNumRows;
    tileImageBounds.origin.x = (tileImageBounds.size.width * column);// + self.gameImageBounds.origin.x;
    tileImageBounds.origin.y = (tileImageBounds.size.height * row);// + self.gameImageBounds.origin.y;

    GameTile *tile = [[GameTile alloc] initWithFrame:frame gameImage:self.gameImage tileImageBounds:tileImageBounds];
    tile.delegate = self;

    [self.view addSubview:tile];
    [self.tiles addObject:tile];
}

- (void)calculateGameImageBounds
{
    CGFloat widthScale = self.gameImage.size.width / self.view.frame.size.width;
    CGFloat heightScale = self.gameImage.size.height / self.view.frame.size.height;

    CGFloat scale = widthScale < heightScale ? widthScale : heightScale;

    _gameImageBounds = CGRectMake(0, 0, self.view.frame.size.width * scale, self.view.frame.size.height * scale);

    if (_gameImageBounds.size.width > self.gameImage.size.width)
    {
        _gameImageBounds.origin.x = (_gameImageBounds.size.width - self.gameImage.size.width) / 2;
        _gameImageBounds.size.width -= 2 * _gameImageBounds.origin.x;
    }

    if (_gameImageBounds.size.height > self.gameImage.size.height)
    {
        _gameImageBounds.origin.y = (_gameImageBounds.size.height - self.gameImage.size.height) / 2;
        _gameImageBounds.size.height -= 2 * _gameImageBounds.origin.y;
    }

    //    NSLog(@"view: %@", NSStringFromCGRect(self.view.frame));
    //    NSLog(@"gameImageView: %@", NSStringFromCGSize(self.gameImage.size));
    //    NSLog(@"widthScale: %f, heightScale: %f", widthScale, heightScale);
    //    NSLog(@"imageBounds: %@", NSStringFromCGRect(_gameImageBounds));
}



- (void)clearSelection
{
    [self.selectedTiles enumerateObjectsUsingBlock:^(GameTile *gameTile, BOOL *stop) {
        gameTile.selected = NO;
    }];

    self.selectedTiles = [NSMutableSet set];
}

- (void)swapSelectedTilePositions
{
    if (self.selectedTiles.count == 2)
    {
        NSArray *tiles = [self.selectedTiles allObjects];

        GameTile *firstTile = [tiles objectAtIndex:0];
        GameTile *secondTile = [tiles lastObject];

        CGRect firstPosition = firstTile.frame;
        CGRect secondPosition = secondTile.frame;

        [self moveGameTile:secondTile toFrame:firstPosition];
        [self moveGameTile:firstTile toFrame:secondPosition];

        [self clearSelection];
    }
}

- (void)randomizeBoard
{
    NSMutableArray *positions = [NSMutableArray arrayWithCapacity:self.tiles.count];

    [self.tiles enumerateObjectsUsingBlock:^(GameTile *aGameTile, NSUInteger idx, BOOL *stop) {
        [positions addObject:[NSValue valueWithCGRect:aGameTile.frame]];
    }];

    for (NSUInteger i = positions.count; i > 1; i--)
    {
        NSUInteger j = arc4random_uniform(i);
        [positions exchangeObjectAtIndex:i - 1 withObjectAtIndex:j];
    }

    for (NSUInteger i = 0; i < self.tiles.count; i++)
    {
        GameTile *aTile = [self.tiles objectAtIndex:i];
        CGRect destination = [[positions objectAtIndex:i] CGRectValue];
        [self moveGameTile:aTile toFrame:destination];
    }
}

#pragma mark - GameTileDelegate methods

- (void)gameTileWasTapped:(GameTile *)aGameTile
{
    if ([self.selectedTiles member:aGameTile])
    {
        aGameTile.selected = NO;
        [self.selectedTiles removeObject:aGameTile];
    }
    else
    {
        if (self.selectedTiles.count >= 2)
        {
            [self clearSelection];
        }

        aGameTile.selected = YES;

        [self.selectedTiles addObject:aGameTile];
    }
    [self swapSelectedTilePositions];
}

@end
