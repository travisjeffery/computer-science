//
//  BinaryTree.m
//  ComputerScience
//
//  Created by travisjeffery on 11-05-19.
//  Copyright 2011 Travis Jeffery. All rights reserved.
//

#import "BinaryTree.h"
#import "Node.h"


@implementation BinaryTree

@synthesize root;

- (id)initWithRoot:(Node *)_root
{
    self = [super init];
    if (self) {
        self.root = _root;
    }
    
    return self;
}

- (void)add:(int)_data
{
    
    Node *node = [[Node alloc] initWithData:_data andLeft:nil andRight:nil];
    if (self.root == nil) {
        self.root = node;
    } else {
        Node *current = self.root;
        while (true) {
            if (_data < current.data) {
                if (current.left == nil) {
                    current.left = node;
                    break;
                } else {
                    current = current.left;
                } 
            } else if (_data > current.data) {
                if (current.right == nil) {
                    current.right = node;
                    break;
                } else {
                    current = current.right;
                }
            } else {
                break;
            }
        }
    }

    [node release];
}

- (BOOL)contains:(int)_data
{
    BOOL found;
    Node *current = self.root;
    
    while (!found && current != nil) {
        if (_data < current.data) {
            current = current.left;
        } else if (_data > current.data) {
            current = current.right;
        } else {
            found = YES;
        }
    }
    
    return found;
}



- (void)dealloc
{
    [root release];
    [super dealloc];
}

@end
