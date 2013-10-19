//
//  TWMazeGenerator.m
//  TWMazeGenerator
//
//  Created by Thomas Wilson on 19/10/2013.
//  Copyright (c) 2013 Thomas Wilson.
//
/*
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */
#import "TWMazeGenerator.h"
#import "TWMaze.h"
#import "TWTile.h"
#import "TWDepthFirstPathFinder.h"

@interface TWMazeGenerator ()
@property(nonatomic, strong)TWTile *currentTile;
@property(nonatomic)CGSize mazeSize;
@property(nonatomic)CGSize mapSize;
@property (nonatomic, strong)TWMaze *currentMaze;
@end


@implementation TWMazeGenerator

/*
	Sizes are the height and width given in TWTiles
	
	i.e. a width and height of 15
		 is a 15x15 grid of tiles.
 */


-(id)initWithPathFinder:(id<TWPathFinder>)pathFinder{
	self = [super init];
	if (self) {
		_pathFinder = pathFinder;
	}
	return self;
}

+(TWMaze*)generateMazeOfSize:(CGSize)size{
	TWMazeGenerator *generator = [[TWMazeGenerator alloc]init];
	
	return [generator generateMazeOfSize:size];
}

-(TWMaze*)generateMazeOfSize:(CGSize)size{
	if (CGSizeEqualToSize(_mapSize, CGSizeZero)) {
			//ensures all tiles lie inside the
			//map tiles so walls could be placed around the edge
		_mapSize = CGSizeMake((size.width*2)+1, (size.height*2)+1);
	}
		//maze size (in tiles)
	_mazeSize = size;
		//init maze (4x4 strongly connected graph of TWTiles)
	_currentMaze = [[TWMaze alloc]initWithSize:_mazeSize];
	
		//if no pathfinder has been given create a default one
	if (!_pathFinder) {
		_pathFinder = [[TWDepthFirstPathFinder alloc]initWithMaze:_currentMaze];
	}
	
	
	return _currentMaze;
}

+(TWMaze *)generateMazeForMapSize:(CGSize)size{
	TWMazeGenerator *generator = [[TWMazeGenerator alloc]init];
	return [generator generateMazeOfSize:size];
}

-(TWMaze*)generateMazeForMapSize:(CGSize)size{
	NSLog(@"Generate map");
	_mapSize = size;
	
		//ensures all tiles lie inside the
		//map tiles so walls can be placed around the edge
	_mazeSize = CGSizeMake((size.width-1)/2, (size.height-1)/2);
	
	return [self generateMazeOfSize:_mazeSize];
}



-(CGSize)mapSize{
	return _mapSize;
}
-(CGSize)mazeSize{
	return _mazeSize;
}

@end
