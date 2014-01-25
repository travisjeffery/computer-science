//
//  TRVSPriorityQueue.m
//  TRVSComputerScience
//
//  Created by Travis Jeffery on 1/19/14.
//
//

#import "TRVSPriorityQueue.h"

@interface TRVSPriorityQueue ()

@property(nonatomic) CFBinaryHeapRef heap;
@property(nonatomic, copy) TRVSPriorityQueueComparator comparator;

@end

static CFComparisonResult TRVSCompare(const void *a,
                                      const void *b,
                                      void *context) {
  TRVSPriorityQueue *queue = (__bridge TRVSPriorityQueue *)context;

  return (CFComparisonResult)queue.comparator((__bridge id)(a),
                                              (__bridge id)(b));
}

static const void *TRVSPriortyQueueRetain(CFAllocatorRef allocator,
                                          const void *ptr) {
  CFRetain(ptr);

  return ptr;
}

static void TRVSPriortyQueueRelease(CFAllocatorRef allocator, const void *ptr) {
  CFRelease(ptr);
}

CFStringRef TRVSPriorityQueueCopyDescription(const void *ptr) {
  id obj = (__bridge id)ptr;

  return (__bridge_retained void *)[obj description];
}

@implementation TRVSPriorityQueue

- (void)dealloc {
  if (self.heap)
    CFRelease(self.heap);
}

- (instancetype)initWithComparator:(TRVSPriorityQueueComparator)comparator {
  self = [self init];

  if (self) {
    self.comparator = comparator;

    CFBinaryHeapCallBacks callbacks;
    callbacks.version = 0;
    callbacks.retain = TRVSPriortyQueueRetain;
    callbacks.release = TRVSPriortyQueueRelease;
    callbacks.copyDescription = TRVSPriorityQueueCopyDescription;
    callbacks.compare = TRVSCompare;

    CFBinaryHeapCompareContext context;
    context.info = (__bridge void *)(self);

    self.heap =
        CFBinaryHeapCreate(kCFAllocatorDefault, 0, &callbacks, &context);
  }

  return self;
}

- (void)enqueue:(id)object {
  CFBinaryHeapAddValue(self.heap, (__bridge const void *)(object));
}

- (id)dequeue {
  id object = CFBinaryHeapGetMinimum(self.heap);
  CFBinaryHeapRemoveMinimumValue(self.heap);

  return object;
}

- (BOOL)isEmpty {
  return CFBinaryHeapGetCount(self.heap) == 0;
}

- (NSArray *)allObjects {
  CFIndex count = CFBinaryHeapGetCount(self.heap);
  const void **values = calloc(sizeof(*values), count);

  CFBinaryHeapGetValues(self.heap, values);

  CFArrayRef array =
      CFArrayCreate(kCFAllocatorDefault, values, count, &kCFTypeArrayCallBacks);
  NSArray *objects = (__bridge NSArray *)(array);

  free(values);

  return objects;
}

@end
