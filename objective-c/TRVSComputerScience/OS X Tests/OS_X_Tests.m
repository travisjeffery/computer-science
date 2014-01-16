//
//  OS_X_Tests.m
//  OS X Tests
//
//  Created by Travis Jeffery on 1/16/14.
//
//

#import <XCTest/XCTest.h>
#import "TRVSTree.h"

@interface OS_X_Tests : XCTestCase

@property(nonatomic, strong) TRVSTree *tree;

@end

@implementation OS_X_Tests

- (void)setUp {
  [super setUp];

  self.tree = [[TRVSTree alloc] init];
  [self.tree addValue:4];
  [self.tree addValue:2];
  [self.tree addValue:1];
  [self.tree addValue:3];
}

- (void)tearDown {
  [super tearDown];
}

- (void)testFind {
  XCTAssert([self.tree findValue:3]);
}

- (void)testCount {
  XCTAssert(self.tree.count == 4);
}

@end
