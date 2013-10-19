//
//  TWTile.h
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

#import <Foundation/Foundation.h>

typedef enum: uint8_t{
	TWMazeDirectionUp,
	TWMazeDirectionDown,
	TWMazeDirectionLeft,
	TWMazeDirectionRight,
	TWMazeDirectionUnknown
	
} TWMazeDirection;

@interface TWTile : NSObject

@property(nonatomic, readonly)CGPoint position;//position in grid.
@property(nonatomic)BOOL visited;//has this tile been visited? not really used in the end.
@property(nonatomic)NSMutableArray *walls;//walls array hold neighbors. A tile in here means there is a wall between it and self
@property(nonatomic)CGSize size;//size of tile. (Not used but you could)

-(id)initWithPosition:(CGPoint)position;

+(TWMazeDirection)mazeDirectionFromTilePosition:(CGPoint)one toPosition:(CGPoint)two;

@end
