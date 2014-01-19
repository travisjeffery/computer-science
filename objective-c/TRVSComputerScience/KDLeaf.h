//
//  KDLeaf.h
//  TRVSComputerScience
//
//  Created by Travis Jeffery on 1/18/14.
//
//

#import <Foundation/Foundation.h>
#import "KDNode.h"

@interface KDLeaf : NSObject

@property (nonatomic, copy) NSArray *point;

- (instancetype)initWithPoint:(NSArray *)point;

@end
