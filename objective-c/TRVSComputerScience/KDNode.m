//
//  KDNode.m
//  TRVSComputerScience
//
//  Created by Travis Jeffery on 1/18/14.
//
//

#import "KDNode.h"
#import "KDLeaf.h"

@implementation KDNode

- (instancetype)initWithCoordinates:(NSArray *)coordinates dimension:(NSUInteger)dimension currentDimension:(NSUInteger)currentDimension {
  if (currentDimension >= dimension) {
    currentDimension = 0;
  }
  
  self.dimension = currentDimension;
  
  coordinates = [self sortCoordinates:coordinates dimension:self.dimension];

  NSUInteger midIndex = [self midIndexOfCoordinates:coordinates];
  self.splitPoint = [self medianUsingCoordinates:coordinates dimension:self.dimension];
  
  currentDimension++;
  
  if (coordinates.count > 2) {
    NSRange leftRange = NSMakeRange(0, midIndex);
    NSArray *leftCoordinates = [coordinates subarrayWithRange:leftRange];
    self.leftChild = [[KDNode alloc] initWithCoordinates:leftCoordinates dimension:self.dimension currentDimension:currentDimension];
    
    NSUInteger offsetLength = coordinates.count - midIndex;
    NSRange rightRange = NSMakeRange(midIndex, offsetLength);
    NSArray *rightCoordinates = [coordinates subarrayWithRange:rightRange];
    self.rightChild = [[KDNode alloc] initWithCoordinates:rightCoordinates dimension:self.dimension currentDimension:currentDimension];
  } else {
    if (coordinates.count == 2) {
      self.rightLeaf = [[KDLeaf alloc] initWithPoint:[self pointUsingCoordinates:[coordinates objectAtIndex:1]]];
    }

    self.leftLeaf = [[KDLeaf alloc] initWithPoint:[self pointUsingCoordinates:[coordinates objectAtIndex:0]]];
  }
  
  return self;
}
                        
- (NSArray *)pointUsingCoordinates:(NSArray *)coordinates {
  NSMutableArray *points = [[NSMutableArray alloc] init];
  NSUInteger dimension = coordinates.count;
  
  for (int i = 0; i < dimension; i++) {
    [points addObject:[coordinates objectAtIndex:i]];
  }
  
  return points;
}

- (instancetype)initWithCoordinates:(NSArray *)coordinates dimension:(NSUInteger)dimension {
  return [self initWithCoordinates:coordinates dimension:dimension currentDimension:0];
}

- (instancetype)initWithCoordinates:(NSArray *)coordinates {
  return [self initWithCoordinates:coordinates dimension:coordinates.count currentDimension:0];
}

- (NSString *)description {
  return [NSString stringWithFormat:@"<%@:%p> %@ %@", self.class, self, self.leftChild, self.rightChild];
}

#pragma mark - Private

- (NSArray *)sortCoordinates:(NSArray *)coordinates dimension:(NSUInteger)dimension {
  return [coordinates sortedArrayUsingComparator:^NSComparisonResult(NSArray *pointA, NSArray *pointB) {
    NSNumber *coordinateA = [pointA objectAtIndex:dimension];
    NSNumber *coordinateB = [pointB objectAtIndex:dimension];
    
    return [coordinateA compare:coordinateB];
  }];
}

- (CGFloat)medianUsingCoordinates:(NSArray *)coordinates dimension:(NSUInteger)dimension {
  return [[[coordinates objectAtIndex:[self midIndexOfCoordinates:coordinates]] objectAtIndex:dimension] doubleValue];
}

- (NSUInteger)midIndexOfCoordinates:(NSArray *)coordinates {
  return coordinates.count / 2;
}

@end
