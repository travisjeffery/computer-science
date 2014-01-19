//
//  KDNode.h
//  TRVSComputerScience
//
//  Created by Travis Jeffery on 1/18/14.
//
//

#import <Foundation/Foundation.h>

@class KDLeaf;

@interface KDNode : NSObject

@property (nonatomic) CGFloat splitPoint;
@property (nonatomic) NSUInteger dimension;
@property (nonatomic, strong) KDNode *rightChild;
@property (nonatomic, strong) KDNode *leftChild;
@property (nonatomic, strong) KDLeaf *rightLeaf;
@property (nonatomic, strong) KDLeaf *leftLeaf;

- (instancetype)initWithCoordinates:(NSArray *)coordinates dimension:(NSUInteger)dimension currentDimension:(NSUInteger)currentDimension;
- (instancetype)initWithCoordinates:(NSArray *)coordinates dimension:(NSUInteger)dimension;
- (instancetype)initWithCoordinates:(NSArray *)coordinates;

@end
