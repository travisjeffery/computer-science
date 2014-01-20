#import "KDTree.h"

@implementation KDTreeNeighbors

- (instancetype)initWithPoint:(NSArray *)point k:(NSUInteger)k {
  self = [self init];
  
  if (self) {
    self.point = point;
    self.k = k;
    self.largestDistance = 0.0f;
    self.currentBest = [[NSMutableArray alloc] init];
  }
  
  return self;
}

- (void)findLargestDistance {
  if (self.k > self.currentBest.count) {
    self.largestDistance = [[self.currentBest lastObject][1] doubleValue];
  } else {
    self.largestDistance = [self.currentBest[self.k - 1][1] doubleValue];
  }
}

- (void)enqueuePoint:(NSArray *)point {
  CGFloat distance = [self distanceUsingPoint:point];
  
  [self.currentBest enumerateObjectsUsingBlock:^(NSArray *data, NSUInteger idx, BOOL *stop) {
    if (idx == self.k) {
      return;
    }
    
    if ([data[1] doubleValue] > distance) {
      [self.currentBest insertObject:@[point, @(distance)] atIndex:idx];
      [self findLargestDistance];
      return;
    }
   }];
  
  [self.currentBest addObject:@[point, @(distance)]];
  [self findLargestDistance];
}

- (NSArray *)kNearestNeighbors {
  if (self.currentBest.count == 0)
    return @[];
  
  if (self.currentBest.count < self.k)
    return self.currentBest;
  
  NSMutableArray *neighbors = [[NSMutableArray alloc] init];
  
  [self.currentBest enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    if (idx < self.currentBest.count - self.k) {
      *stop = YES;
      return;
    }
    
    [neighbors addObject:obj];
  }];
  
  return neighbors;
}

- (CGFloat)distanceUsingPoint:(NSArray *)point {
  __block CGFloat distance = 0.0f;

  [point enumerateObjectsUsingBlock:^(NSNumber *coordinate, NSUInteger idx, BOOL *stop) {
    distance += pow([coordinate doubleValue] - [self.point[idx] doubleValue], 2.0);
  }];
  
  distance = sqrt(distance);
  
  return distance;
}

@end

@implementation KDNode

- (instancetype)initWithPoint:(NSArray *)point leftChild:(KDNode *)leftChild rightChild:(KDNode *)rightChild {
  self = [self init];
  
  if (self) {
    self.point = point;
    self.leftChild = leftChild;
    self.rightChild = rightChild;
  }
  
  return self;
}

- (BOOL)isLeaf {
  return self.leftChild == nil && self.rightChild == nil;
}

- (NSString *)description {
  return [NSString stringWithFormat:@"<%@:%p> %@", self.class, self, self.point];
}

@end

@implementation KDTree

- (instancetype)initWithPoints:(NSArray *)points depth:(NSUInteger)depth {
  if (points.count == 0)
    return nil;
  
  self = [self init];
  
  if (self) {
    NSUInteger axis = depth % [points[0] count];
    points = [self sortedPoints:points usingAxis:axis];
    NSUInteger medianIndex = points.count / 2;
    self.point = points[medianIndex];
    NSRange leftRange = NSMakeRange(0, medianIndex);
    medianIndex++;
    NSUInteger offsetLength = points.count - medianIndex;
    NSRange rightRange = NSMakeRange(medianIndex, offsetLength);
    KDNode *leftChild = [[KDNode alloc] initWithPoints:[points subarrayWithRange:leftRange] depth:depth + 1];
    KDNode *rightChild = [[KDNode alloc] initWithPoints:[points subarrayWithRange:rightRange] depth:depth + 1];
    
    self.rootNode = [[KDNode alloc] initWithPoint:self.point leftChild:leftChild rightChild:rightChild];
  }
  
  return self;
}

- (NSArray *)sortedPoints:(NSArray *)points usingAxis:(NSUInteger)axis {
  return [points sortedArrayUsingComparator:^NSComparisonResult(NSArray *pointA, NSArray *pointB) {
    NSNumber *coordinateA = pointA[axis];
    NSNumber *coordinateB = pointB[axis];
    
    return [coordinateA compare:coordinateB];
  }];
}

- (NSArray *)findK:(NSUInteger)k nearestNeighbors:(NSArray *)point {
  if (self.rootNode == nil)
    return @[];
  
  KDTreeNeighbors *neighbors = [[KDTreeNeighbors alloc] initWithPoint:point k:k];
  [self findK:k nearestNeighborsToPoint:point node:self.rootNode depth:0 bestNeighbors:neighbors];

  return [neighbors kNearestNeighbors];
}

- (void)findK:(NSUInteger)k nearestNeighborsToPoint:(NSArray *)point node:(KDNode *)node depth:(NSUInteger)depth bestNeighbors:(KDTreeNeighbors *)neighbors {
  if (node == nil) {
    return;
  }
  
  if (node.isLeaf) {
    [neighbors enqueuePoint:node.point];
    return;
  }
  
  NSUInteger axis = depth % point.count;
  
  KDNode *nearTree, *farTree;
  
  if ([point[axis] doubleValue] < [node.point[axis] doubleValue]) {
    nearTree = node.leftChild;
    farTree = node.rightChild;
  } else {
    nearTree = node.rightChild;
    farTree = node.leftChild;
  }
  
  [self findK:k nearestNeighborsToPoint:node.point node:nearTree depth:depth + 1 bestNeighbors:neighbors];
  
  [neighbors enqueuePoint:node.point];
  
  if (pow([node.point[axis] doubleValue] - [point[axis] doubleValue], 2.0) < neighbors.largestDistance) {
    [self findK:k nearestNeighborsToPoint:point node:farTree depth:depth + 1 bestNeighbors:neighbors];
  }
}

@end