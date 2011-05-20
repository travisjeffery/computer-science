//
//  BinaryTree.m
//  ComputerScience
//
//  Created by travisjeffery on 11-05-19.
//  Copyright 2011 Travis Jeffery. All rights reserved.
//

#import "BinaryTree.h"
#import "Node.h"

@interface BinaryTree(Private)
- (void)inOrder:(Node *)node;
@end

@implementation BinaryTree

@synthesize root, size;

- (id)initWithRoot:(Node *)_root
{
    self = [super init];
    if (self) {
        self.root = _root;
        self.size = 1;
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


- (void)remove:(int)_data
{
    BOOL found = NO;
    Node *parent = nil;
    Node *current = root;
    Node *replacement = nil;
    Node *replacementParent = nil;

    while (!found && current != nil) {
        if (_data < current.data) {
            parent = current;
            current = current.left;
        } else if (_data > current.data) {
            parent = current;
            current = current.right;
        } else {
            found = true;
        }
    }
    
    if (found) {
        int childCount = (current.left != nil ? 1 : 0) + (current.right != nil ? 1 : 0);
        
        if (current == self.root) {
            switch (childCount) {
                case 0:
                    self.root = nil;
                    break;
                case 1:
                    self.root = current.right == nil ? current.left : current.right;
                    break;
                case 2:
                    replacement = self.root.left;
                    
                    while (replacement.right != nil) {
                        replacementParent = replacement;
                        replacement = replacement.right;
                    }
                    
                    if (replacementParent != nil) {
                        replacementParent.right = replacement.left;
                        replacement.right = self.root.right;
                        replacement.left = self.root.left;
                    } else {
                        replacement.right = self.root.right;
                    }
                    
                    self.root = replacement;
                default:
                    break;
            }
        } else {
            switch (childCount) {
                case 0:
                    if (current.data < parent.data) {
                        parent.left = nil;
                    } else {
                        parent.right = nil;
                    }
                    break;
                case 1:
                    if (current.data < parent.data) {
                        parent.left = current.left == nil ? current.right : current.left;
                    } else {
                        parent.right = current.left == nil ? current.right : current.left;
                    }
                    break;
                case 2:
                    replacement = current.left;
                    replacementParent = current;
                    
                    while (replacementParent != nil) {
                        replacementParent = replacement;
                        replacement = replacement.right;
                    }
                    
                    replacementParent.right = replacement.left;
                    replacement.right = current.right;
                    replacement.left = current.left;
                    
                    if (current.data < parent.data) {
                        parent.left = replacement;
                    } else {
                        parent.right = replacement;
                    }
                    break;
                default:
                    break;
            }
        }
        
    }

}

- (int)size
{
    __block int length = 0;
    int(^process)(Node *);
    process = ^(Node *node) {
        return length++;
    };
    [self traverse:process];
    return length;
}

- (void)traverse:(int (^)(Node *))process
{
    // after writing this piece of code/size above I literally gave myself
    // a Neo, "Whoa/I know Kung fu," moment.
    __block void(^inOrder)(Node *);
    inOrder = ^(Node *node) {
        if (node.left != nil) {
            inOrder(node.left);
        }
        
        process(node);
        
        if (node.right != nil) {
            inOrder(node.right);
        }
    };
    
    return inOrder(self.root);
}

- (void)dealloc
{
    [root release];
    [super dealloc];
}

@end
