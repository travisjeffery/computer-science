//
//  TRVSPriorityQueueTests.m
//  TRVSComputerScience
//
//  Created by Travis Jeffery on 1/20/14.
//
//

#import <XCTest/XCTest.h>
#import "TRVSPriorityQueue.h"

@interface TRVSPriorityQueueTests : XCTestCase

@property (nonatomic, strong) TRVSPriorityQueue *queue;

@end

@implementation TRVSPriorityQueueTests

- (void)setUp {
  [super setUp];
  
  self.queue = [[TRVSPriorityQueue alloc] initWithComparator:^NSComparisonResult(NSNumber *a, NSNumber *b) {
    return [a compare:b];
  }];

  [@[@1, @4, @5, @6, @3, @7] enumerateObjectsUsingBlock:^(NSNumber *a, NSUInteger idx, BOOL *stop) {
    [self.queue enqueue:a];
  }];
}

- (void)testObjectsAreInOrder {
  NSArray *actualObjects = @[@1, @3, @4, @5, @6, @7];
  
  XCTAssertEqualObjects(actualObjects, [self.queue allObjects]);
}

@end
