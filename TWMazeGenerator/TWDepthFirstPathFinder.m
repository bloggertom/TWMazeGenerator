//
//  TWDepthFirstPathFinder.m
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

#import "TWDepthFirstPathFinder.h"
#import "TWTile.h"
#import "TWMaze.h"

@interface NSMutableArray (Stack)

-(void)push:(id)item;
-(id)pop;
-(id)peek;
@end

@implementation NSMutableArray (Stack)

-(void)push:(id)item{
	[self addObject:item];
}
-(id)pop{
	id item = [self lastObject];
	[self removeObject:item];
	
	return item;
}
-(id)peek{
	return [self lastObject];
}
@end

@interface TWDepthFirstPathFinder ()
@property (nonatomic)CGSize mazeSize;
@property (nonatomic, strong)TWTile *currentTile;
@property (nonatomic, strong)TWMaze *currentMaze;
@end

@implementation TWDepthFirstPathFinder

-(id)initWithMazeSize:(CGSize)size{
	
	TWMaze *maze = [[TWMaze alloc]initWithSize:size];
	return [self initWithMaze:maze];
}

-(id)initWithMaze:(TWMaze*)maze{
	self = [super init];
	if (self) {
		_mazeSize = maze.size;
		_currentMaze = maze;
	}
	return self;
}

-(TWMaze*)createPath{
	NSLog(@"Creating Maz path");
		//choose a random starting possition
	NSUInteger x = arc4random_uniform(_mazeSize.width);
	NSUInteger y = arc4random_uniform(_mazeSize.height-1);
		//-1 so as to not count last row.
	y *= _mazeSize.width-1;
		//"stack" for backtracking
	NSMutableArray *stack = [[NSMutableArray alloc]init];
	
		//select current tile, set it as visited
	int visitedCount = 1;
	_currentTile = [_currentMaze.mazeTiles objectAtIndex:x+y];
	
		//keep recored of starting location for convenience.
	_currentMaze.start = _currentTile;
	
		//add current tile to path before starting
	[_currentMaze.path addObject:_currentTile];
	_currentTile.visited = YES;
	
		//while there are still tiles to be visited
	while (visitedCount < [_currentMaze.mazeTiles count]) {
		
			//get unvisited neighbors of current tile.
		NSArray *array = [_currentTile.walls filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
			if([evaluatedObject isKindOfClass:[TWTile class]]){
				TWTile *ob = (TWTile *)evaluatedObject;
				return (!ob.visited);
			}
			return NO;
		}]];
			//if there are unvisited neighbors
		if ([array count]) {
				//select a random one
			int index = arc4random_uniform((int)[array count]);
			[stack push:_currentTile];
			TWTile *temp = (TWTile*)[array objectAtIndex:index];
			
				//remove the wall between them
			[_currentTile.walls replaceObjectAtIndex:[_currentTile.walls indexOfObject:temp] withObject:@"0"];
			[temp.walls replaceObjectAtIndex:[temp.walls indexOfObject:_currentTile] withObject:@"0"];
			
				//set neighbor as current tile
			_currentTile = temp;
				//set it to visited
			_currentTile.visited = YES;
				//add it to maze path
			[_currentMaze.path addObject:_currentTile];
				//increment visited count
			visitedCount ++;
			
				//if all neighbors visited pop stack (backtrack)
		}else if([stack count]){
			TWTile *temp = [stack pop];
			_currentTile = temp;
			
				//if all else fails pick a random unvisited tile and go from there (never run).
		}else{
			NSArray *unvisited = [_currentMaze.mazeTiles filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
				if([evaluatedObject isKindOfClass:[TWTile class]]){
					TWTile *ob = (TWTile *)evaluatedObject;
					return (!ob.visited);
				}
				return NO;
			}]];
			int index = arc4random_uniform((int)[unvisited count]);
			_currentTile = [unvisited objectAtIndex:index];
			_currentTile.visited = YES;
			visitedCount ++;
			NSLog(@"random");
		}
	}
		//last tile visited in the end of the maze
	_currentMaze.finish = _currentTile;
	
	NSLog(@"Maz path created");
	
	return _currentMaze;
}


@end
