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

@end
