//
//  KDTree.h
//  TRVSComputerScience
//
//  Created by Travis Jeffery on 1/18/14.
//
//

#import <Foundation/Foundation.h>
#import "KDNode.h"

@interface KDTree : NSObject

@property (nonatomic, strong) KDNode *rootNode;

- (instancetype)initWithCoordinates:(NSArray *)coordinates;
- (KDLeaf *)findNearestNeighbor:(NSArray *)coordinates;


@end
