//
//  KDTreeTests.m
//  TRVSComputerScience
//
//  Created by Travis Jeffery on 1/18/14.
//
//

#import <XCTest/XCTest.h>
#import "KDTree.h"

@interface KDTreeTests : XCTestCase

@property (nonatomic, strong) KDTree *tree;

@end

@implementation KDTreeTests

- (void)setUp {
  [super setUp];
  
  NSArray *points = @[@[@3.4, @2.1], @[@4.2, @5.1], @[@1.0, @2.0], @[@8.0, @5.3]];
  self.tree = [[KDTree alloc] initWithPoints:points depth:0];
}

- (void)testFindingNearestNeighbour {
  NSLog(@"%@", [self.tree findK:4 nearestNeighbors:@[@3.0, @2.0]]);
}

@end
