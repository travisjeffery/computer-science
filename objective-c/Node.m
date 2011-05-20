//
//  Node.m
//  ComputerScience
//
//  Created by travisjeffery on 11-05-19.
//  Copyright 2011 Travis Jeffery. All rights reserved.
//

#import "Node.h"


@implementation Node

@synthesize data, left, right;

//designated initializer
- (id)initWithData:(int)_data
           andLeft:(Node *)_left
          andRight:(Node *)_right
{
    self = [super init];
    if (self) {
        self.data = _data;
        self.left = _left;
        self.right = _right;
        
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%d", self.data];
}

- (void)dealloc
{
    [left release];
    [right release];
    [super dealloc];
}

@end
