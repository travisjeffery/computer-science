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
  
  NSArray *coordinates = @[@[@3.4, @2.1], @[@4.2, @5.1], @[@1.0, @2.0], @[@8.0, @5.3]];
  self.tree = [[KDTree alloc] initWithCoordinates:coordinates];    
}

- (void)testFindingNearestNeighbour {
  KDLeaf *nearestLeaf = [self.tree findNearestNeighbor:@[@4.0, @5.0]];
  NSLog(@"%@", nearestLeaf);
}

@end
