//
//  KDTree.h
//  TRVSComputerScience
//
//  Created by Travis Jeffery on 1/18/14.
//
//

#import <Foundation/Foundation.h>

@class KDNode;

@interface KDTree : NSObject

@property (nonatomic, strong) KDNode *rootNode;

- (instancetype)initWithPoints:(NSArray *)points depth:(NSUInteger)depth;
- (NSArray *)findK:(NSUInteger)k nearestNeighbors:(NSArray *)point;

@end

@interface KDNode : NSObject

@property (nonatomic, strong) KDNode *leftChild;
@property (nonatomic, strong) KDNode *rightChild;
@property (nonatomic, copy) NSArray *point;

- (instancetype)initWithPoint:(NSArray *)point leftChild:(KDNode *)leftChild rightChild:(KDNode *)rightChild;
- (BOOL)isLeaf;

@end

@interface KDTreeNeighbors : NSObject

@property (nonatomic, copy) NSArray *point;
@property (nonatomic) NSUInteger k;
@property (nonatomic) CGFloat largestDistance;
@property (nonatomic, strong) NSMutableArray *currentBest;

- (instancetype)initWithPoint:(NSArray *)point k:(NSUInteger)k;

@end