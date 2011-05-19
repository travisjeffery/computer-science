//
//  Tests.m
//  Tests
//
//  Created by travisjeffery on 11-05-19.
//  Copyright 2011 Travis Jeffery. All rights reserved.
//

#import "Tests.h"
#import "BinaryTree.h"
#import "Node.h"


@implementation Tests

@synthesize bt;

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    Node *root = [[Node alloc] initWithData:100 andLeft:nil andRight:nil];
    bt = [[BinaryTree alloc] initWithRoot:root];
}

- (void)tearDown
{
    // Tear-down code here.
    [bt release];
    [super tearDown];
}

- (void)testContainsRoot100AndDoesntContain150
{
    STAssertEquals([bt contains:100], YES, @"bt should contain root node that has data 100", nil);
    STAssertEquals([bt contains:150], NO, @"bt should not contain a root with data 150", nil);
}

- (void)testAdd150
{
    [bt add:150];
    STAssertEquals([bt contains:150], YES, @"bt should contain a node with data 150", nil);
    STAssertEquals([bt contains:100], YES, @"bt should contain a node with data 100", nil);
}

@end
