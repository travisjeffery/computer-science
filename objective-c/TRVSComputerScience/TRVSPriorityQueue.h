//
//  TRVSPriorityQueue.h
//  TRVSComputerScience
//
//  Created by Travis Jeffery on 1/19/14.
//
//

#import <Foundation/Foundation.h>

typedef NSComparisonResult (^TRVSPriorityQueueComparator)(id a, id b);

@interface TRVSPriorityQueue : NSObject

- (instancetype)initWithComparator:(TRVSPriorityQueueComparator)comparator;
- (BOOL)isEmpty;
- (void)enqueue:(id)object;
- (id)dequeue;

@end
