//
//  TRVSBinaryTree.m
//  TRVSComputerScience
//
//  Created by Travis Jeffery on 1/16/14.
//
//

#import "TRVSTree.h"

@implementation TRVSNode

- (NSString *)description {
  return [NSString
      stringWithFormat:@"<%@:%p> %@", self.class, self, @(self.value)];
}

@end

@interface TRVSTree ()

@property(nonatomic, strong, readwrite) TRVSNode *rootNode;

@end

@implementation TRVSTree

- (TRVSNode *)findValue:(NSInteger)value {
  TRVSNode *currentNode = self.rootNode;

  while (currentNode.value != value) {
    if (value < currentNode.value)
      currentNode = currentNode.leftNode;
    else if (value > currentNode.value)
      currentNode = currentNode.rightNode;
    else if (currentNode == nil) {
      return nil;
    }
  }

  return currentNode;
}

- (void)addValue:(NSInteger)value {
  TRVSNode *newNode = [[TRVSNode alloc] init];
  newNode.value = value;

  if (self.rootNode == nil) {
    self.rootNode = newNode;
    return;
  }

  TRVSNode *currentNode = self.rootNode;
  TRVSNode *parentNode;

  while (YES) {
    parentNode = currentNode;
    if (value < currentNode.value) {
      currentNode = currentNode.leftNode;

      if (currentNode == nil) {
        parentNode.leftNode = newNode;
        return;
      }
    } else {
      currentNode = currentNode.rightNode;

      if (currentNode == nil) {
        parentNode.rightNode = newNode;
        return;
      }
    }
  }
}

- (NSUInteger)count {
  __block NSUInteger count = 0;

  [self inOrderTraversalUsingLocalRoot:self.rootNode nodeHandler:^(TRVSNode *_) {
    count++;
  }];

  return count;
}

- (void)inOrderTraversalUsingLocalRoot:(TRVSNode *)localRoot
                           nodeHandler:(TRVSNodeHandler)nodeHandler {
  if (localRoot == nil)
    return;

  [self inOrderTraversalUsingLocalRoot:localRoot.leftNode
                           nodeHandler:nodeHandler];
  nodeHandler(localRoot);
  [self inOrderTraversalUsingLocalRoot:localRoot.rightNode
                           nodeHandler:nodeHandler];
}

@end
