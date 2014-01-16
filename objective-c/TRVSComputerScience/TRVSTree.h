//
//  TRVSBinaryTree.h
//  TRVSComputerScience
//
//  Created by Travis Jeffery on 1/16/14.
//
//

#import <Foundation/Foundation.h>

@interface TRVSNode : NSObject

@property(nonatomic, strong) TRVSNode *rightNode;
@property(nonatomic, strong) TRVSNode *leftNode;
@property(nonatomic) NSInteger value;

@end

typedef void (^TRVSNodeHandler)(TRVSNode *);

@interface TRVSTree : NSObject

@property(nonatomic, strong, readonly) TRVSNode *rootNode;

- (TRVSNode *)findValue:(NSInteger)value;
- (void)addValue:(NSInteger)value;
- (void)removeValue:(NSInteger)value;
- (NSUInteger)count;
- (void)inOrderTraversalUsingLocalRoot:(TRVSNode *)localRoot
                           nodeHandler:(TRVSNodeHandler)nodeHandler;

@end
