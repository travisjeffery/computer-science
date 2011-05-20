//
//  Node.h
//  ComputerScience
//
//  Created by travisjeffery on 11-05-19.
//  Copyright 2011 Travis Jeffery. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Node : NSObject {
    
@private
    
}

- (id)initWithData:(int)_data
           andLeft:(Node *)_left
          andRight:(Node *)_right;

@property int data;
@property (retain, nonatomic) Node *left;
@property (retain, nonatomic) Node *right;

@end
