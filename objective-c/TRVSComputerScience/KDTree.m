//
//  KDTree.m
//  TRVSComputerScience
//
//  Created by Travis Jeffery on 1/18/14.
//
//

#import "KDTree.h"
#import "KDLeaf.h"

@implementation KDTree

- (instancetype)initWithCoordinates:(NSArray *)coordinates {
  self = [self init];
  
  if (self) {
    self.rootNode = [[KDNode alloc] initWithCoordinates:coordinates];
  }

  return self;
}

- (KDLeaf *)findNearestNeighbor:(NSArray *)coordinates {
  return [self findNearestNeighbor:coordinates usingNode:self.rootNode];
}

- (KDLeaf *)findNearestNeighbor:(NSArray *)coordinates usingNode:(KDNode *)node {
  KDLeaf *closestLeaf = [self guessNearestNeighbor:coordinates usingNode:node];
  CGFloat distance = [self distanceFromCoordinates:coordinates toCoordinates:closestLeaf.point];

  return [self findNearestNeighbor:coordinates usingNode:node distance:distance closestLeaf:closestLeaf];
}

- (KDLeaf *)findNearestNeighbor:(NSArray *)coordinates usingNode:(KDNode *)node distance:(CGFloat)distance closestLeaf:(KDLeaf *)closestLeaf {
  if (node.leftLeaf) {
    CGFloat leftLeafDistance = [self distanceFromCoordinates:node.leftLeaf.point toCoordinates:coordinates];

    if (leftLeafDistance < distance) {
      closestLeaf = node.leftLeaf;
      distance = leftLeafDistance;
    } else {
      if (node.leftChild) {
        CGFloat leftExtremity = [[coordinates objectAtIndex:node.dimension] doubleValue] - distance;
        
        if (leftExtremity < node.splitPoint) {
          closestLeaf = [self findNearestNeighbor:coordinates usingNode:node.leftChild distance:distance closestLeaf:closestLeaf];
        }
      }
    }
  }
  
  if (node.rightLeaf) {
    CGFloat rightLeafDistance = [self distanceFromCoordinates:coordinates toCoordinates:node.rightLeaf.point];

    if (rightLeafDistance < distance) {
      closestLeaf = node.rightLeaf;
      distance = rightLeafDistance;
    }
  } else {
    if (node.rightChild) {
      CGFloat rightExtremity = [[coordinates objectAtIndex:node.dimension] doubleValue] + distance;
      
      if (rightExtremity > node.splitPoint) {
        closestLeaf = [self findNearestNeighbor:coordinates usingNode:node.rightChild distance:distance closestLeaf:closestLeaf];
      }
    }
  }
  
  return closestLeaf;
}

- (KDLeaf *)guessNearestNeighbor:(NSArray *)coordinates usingNode:(KDNode *)node {
  KDLeaf *closestLeaf;
  
  while (node.leftLeaf == nil) {
    if ([[coordinates objectAtIndex:node.dimension] doubleValue] < node.splitPoint) {
      node = node.leftChild;
    } else {
      node = node.rightChild;
    }
  }
  
  if ([[coordinates objectAtIndex:node.dimension] doubleValue] < node.splitPoint) {
    closestLeaf = node.leftLeaf;
  } else {
    if (node.rightLeaf) {
      closestLeaf = node.rightLeaf;
    } else {
      closestLeaf = node.leftLeaf;
    }
  }
  
  return closestLeaf;
}

- (CGFloat)distanceFromCoordinates:(NSArray *)coordinatesA toCoordinates:(NSArray *)coordinatesB {
  CGFloat distance = 0.0f;

  for (int i = 0; i < coordinatesA.count; i++) {
    distance += pow([coordinatesA[i] doubleValue] - [coordinatesB[i] doubleValue], 2);
  }
  
  distance = sqrt(distance);
  
  return distance;
}

@end
