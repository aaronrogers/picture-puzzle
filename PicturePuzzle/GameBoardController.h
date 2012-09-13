//
//  ViewController.h
//  PicturePuzzle
//
//  Created by Aaron Rogers on 9/11/12.
//  Copyright (c) 2012 Rocketmade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameTile.h"
#import "DrawView.h"

@interface GameBoardController : UIViewController <GameTileDelegate>
@property (weak, nonatomic) IBOutlet UIView *tileContainer;
@property (weak, nonatomic) IBOutlet DrawView *drawView;

// Private
@property (nonatomic, readonly) UIImage *gameImage;
@property (nonatomic, readonly) CGRect gameImageBounds;
@property (nonatomic, strong) NSMutableArray *tiles;
@property (nonatomic, strong) NSMutableSet *selectedTiles;

- (void)initializeTiles;
- (void)calculateGameImageBounds;
- (void)addGameTileForColumn:(NSUInteger)column row:(NSUInteger)row;
- (void)clearSelection;
- (void)randomizeBoard;
- (void)swapSelectedTilePositions;

@end
