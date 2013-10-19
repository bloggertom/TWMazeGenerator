//
//  TWMaze.m
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

#import "TWMaze.h"
#import "TWTile.h"

@implementation TWMaze

-(id)initWithSize:(CGSize)size{
	self = [super init];
	if(self){
			//Are we sitting comfortably? good, then let us begin.
		_size = size;
		_mazeTiles = [[NSMutableArray alloc]initWithCapacity:size.width*size.height];
		_path = [[NSMutableArray alloc]initWithCapacity:size.width*size.height];
			//init maze tiles/graph
		[self createMazeTiles];
	}
	return self;
}

-(void)createMazeTiles{
		//love thy neighbor
	TWTile *neighbor;
	NSLog(@"Creating Maze Tiles");
		//for every row
	for (int y=0; y<_size.height; y++) {
			//and every tile in that row
		for (int x=0; x<_size.width; x++) {
				//create a tile
			TWTile *current = [[TWTile alloc]initWithPosition:CGPointMake(x, y)];
				//if y is zero we're at the bottom and there is no neighbor below to get
			if (y != 0) {
					//otherwise get thy neighbor
				neighbor = [_mazeTiles objectAtIndex:((y-1)*_size.width)+x];
				if (!neighbor) {
					NSLog(@"nilling");
				}
					//create strong connection. giggadi.
				[current.walls replaceObjectAtIndex:TWMazeDirectionDown withObject:neighbor];
				[neighbor.walls replaceObjectAtIndex:TWMazeDirectionUp withObject:current];
				
			}
				//if x is zero we're on the right edge and there is no neighbor to the left.
			if (x != 0){
					//else get the neighbor
				neighbor = [_mazeTiles lastObject];
				if (!neighbor) {
					NSLog(@"nilling");
				}
					//create strong connection. goo.
				[current.walls replaceObjectAtIndex:TWMazeDirectionLeft withObject:neighbor];
				[neighbor.walls replaceObjectAtIndex:TWMazeDirectionRight withObject:current];
			}
				//add tile to maze/graph
			[_mazeTiles addObject:current];
		}
	}
	NSLog(@"Maze Tiles Created");
	
}


@end
