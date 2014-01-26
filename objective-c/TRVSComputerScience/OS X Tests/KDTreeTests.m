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

- (void)testFoundPointsBoundByK {
  NSArray *points = [self.tree findK:2 nearestNeighborsToPoint:@[@1.1, @2.1]];
  XCTAssertEqual(2, points.count);
}

- (void)testFindingExactPoint {
  NSArray *actualPoint = [[self.tree findK:1 nearestNeighborsToPoint:@[@1.0, @2.0]] firstObject];
  NSArray *expectedPoint = @[@1.0, @2.0];
  XCTAssertEqualObjects(expectedPoint, actualPoint);
}

- (void)testFindingNearestNonExactPoint {
  NSArray *actualPoint = [[self.tree findK:1 nearestNeighborsToPoint:@[@1.1, @2.1]] firstObject];
  NSArray *expectedPoint = @[@1.0, @2.0];
  XCTAssertEqualObjects(expectedPoint, actualPoint);
}

@end
