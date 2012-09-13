//
//  GameTile.h
//  PicturePuzzle
//
//  Created by Aaron Rogers on 9/11/12.
//  Copyright (c) 2012 Rocketmade. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GameTile;

@protocol GameTileDelegate <NSObject>

- (void)gameTileWasTapped:(GameTile *)aGameTile;

@end

@interface GameTile : UIView

@property (nonatomic, weak) id<GameTileDelegate> delegate;
@property (nonatomic, assign) BOOL selected;

- (id)initWithFrame:(CGRect)frame gameImage:(UIImage *)gameImage tileImageBounds:(CGRect)tileImageBounds;

@end
