//
//  TWTile.m
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

#import "TWTile.h"

@implementation TWTile

-(id)initWithPosition:(CGPoint)position{
	self = [super init];
	if(self){
		_position = position;
		_walls = [[NSMutableArray alloc]initWithCapacity:4];
		_visited = NO;
		
			//if it's @"0" stand for no wall here...
		for (int i = 0; i<4; i++) {
			[_walls addObject:@"0"];
			
		}
	}
	return self;
}

+(TWMazeDirection)mazeDirectionFromTilePosition:(CGPoint)one toPosition:(CGPoint)two{
	CGFloat deltaX = one.x - two.x;
	CGFloat deltaY = one.y - two.y;
	
	TWMazeDirection direction = 0;
	
	if (deltaX > 0 && deltaY == 0) {
		direction = TWMazeDirectionLeft;
	}else if (deltaX < 0 && deltaY == 0) {
		direction = TWMazeDirectionRight;
	}else if (deltaY > 0 && deltaX == 0){
		direction = TWMazeDirectionDown;
	}else if (deltaY < 0 && deltaX == 0){
		direction = TWMazeDirectionUp;
	}else{
		direction = TWMazeDirectionUnknown;
	}
	return direction;
}



@end
