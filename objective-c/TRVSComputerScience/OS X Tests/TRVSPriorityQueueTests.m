//
//  TRVSPriorityQueueTests.m
//  TRVSComputerScience
//
//  Created by Travis Jeffery on 1/19/14.
//
//

#import <XCTest/XCTest.h>
#import "TRVSPriorityQueue.h"

@interface TRVSPriorityQueueTests : XCTestCase

@property(nonatomic, strong) TRVSPriorityQueue *queue;

@end

@implementation TRVSPriorityQueueTests

- (void)setUp {
  [super setUp];

  self.queue = [[TRVSPriorityQueue alloc] initWithComparator:^NSComparisonResult(id a, id b) {
    return [a compare:b];
  }];

  [self.queue enqueue:@5];
  [self.queue enqueue:@3];
  [self.queue enqueue:@10];
  [self.queue enqueue:@1];
}

- (void)testQueue {
  XCTAssert([self.queue.dequeue isEqualToNumber:@1]);
}

@end
