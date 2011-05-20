//
//  BinaryTree.h
//  ComputerScience
//
//  Created by travisjeffery on 11-05-19.
//  Copyright 2011 Travis Jeffery. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Node.h"

@interface BinaryTree : NSObject {
@private
    
}

@property (retain, nonatomic) Node *root;
@property (nonatomic) int size;

- (id)initWithRoot:(Node *)_root;
- (BOOL)contains:(int)_data;
- (void)add:(int)_data;
- (void)remove:(int)_data;
- (void)traverse:(int (^)(Node *))process;

@end
