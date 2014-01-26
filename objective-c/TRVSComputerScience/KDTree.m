#import "KDTree.h"

@implementation KDTreeNeighbors

- (instancetype)initWithPoint:(NSArray *)point k:(NSUInteger)k {
  self = [self init];
  
  if (self) {
    self.point = point;
    self.k = k;
    self.largestDistance = 0.0f;
    self.nearestNeighbors = [[NSMutableArray alloc] init];
  }
  
  return self;
}

- (void)findLargestDistance {
  if (self.k >= self.nearestNeighbors.count) {
    self.largestDistance = [[self.nearestNeighbors lastObject][1] doubleValue];
  } else {
    self.largestDistance = [self.nearestNeighbors[self.k - 1][1] doubleValue];
  }
}

- (void)enqueuePoint:(NSArray *)point {
  CGFloat distance = [self distanceUsingPoint:point];
  
  __block BOOL foundBest = NO;
  
  [self.nearestNeighbors enumerateObjectsUsingBlock:^(NSArray *data, NSUInteger idx, BOOL *stop) {
    if (idx == self.k) {
      *stop = foundBest = YES;
      return;
    }
    
    if ([data[1] doubleValue] > distance) {
      [self.nearestNeighbors insertObject:@[point, @(distance)] atIndex:idx];
      [self findLargestDistance];
      *stop = foundBest = YES;
    }
   }];
  
  if (foundBest) return;
  
  [self.nearestNeighbors addObject:@[point, @(distance)]];
  [self findLargestDistance];
}

- (NSArray *)kNearestNeighbors {
  NSMutableArray *points = [[NSMutableArray alloc] initWithCapacity:self.k];
  
  [self.nearestNeighbors enumerateObjectsUsingBlock:^(NSArray *data, NSUInteger idx, BOOL *stop) {
    if (idx == self.k) {
      *stop = YES;
      return;
    }
    
    [points addObject:data[0]];
  }];
  
  return points;
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

- (KDNode *)initTreeWithPoints:(NSArray *)points depth:(NSUInteger)depth {
  if (points.count == 0)
    return nil;
  
  self = [self init];
  
  if (self) {
    NSUInteger axis = depth % [points[0] count];
    points = [self sortedPoints:points usingAxis:axis];
    NSUInteger medianIndex = points.count / 2;
    
    self.point = points[medianIndex];

    NSRange leftRange = NSMakeRange(0, medianIndex);
    self.leftChild = [[KDNode alloc] initTreeWithPoints:[points subarrayWithRange:leftRange] depth:depth + 1];
    
    medianIndex++;
    NSUInteger offsetLength = points.count - medianIndex;
    NSRange rightRange = NSMakeRange(medianIndex, offsetLength);
    self.rightChild = [[KDNode alloc] initTreeWithPoints:[points subarrayWithRange:rightRange] depth:depth + 1];
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

- (BOOL)isLeaf {
  return self.leftChild == nil && self.rightChild == nil;
}

- (NSString *)description {
  return [NSString stringWithFormat:@"<%@:%p> %@", self.class, self, self.point];
}

@end

@implementation KDTree

- (instancetype)initWithPoints:(NSArray *)points depth:(NSUInteger)depth {
  self = [self init];
  
  if (self) {
    self.rootNode = [[KDNode alloc] initTreeWithPoints:points depth:0];
  }
  
  return self;
}

- (NSArray *)findK:(NSUInteger)k nearestNeighborsToPoint:(NSArray *)point {
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
  
  [self findK:k nearestNeighborsToPoint:point node:nearTree depth:depth + 1 bestNeighbors:neighbors];
  
  [neighbors enqueuePoint:node.point];
  
  if (pow([node.point[axis] doubleValue] - [point[axis] doubleValue], 2.0) < neighbors.largestDistance) {
    [self findK:k nearestNeighborsToPoint:point node:farTree depth:depth + 1 bestNeighbors:neighbors];
  }
}

@end
