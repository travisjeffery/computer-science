//
//  KDLeaf.m
//  TRVSComputerScience
//
//  Created by Travis Jeffery on 1/18/14.
//
//

#import "KDLeaf.h"

@implementation KDLeaf

- (instancetype)initWithPoint:(NSArray *)point {
  self = [self init];
  
  if (self) {
    self.point = point;
  }
  
  return self;
}

- (NSString *)description {
  return [NSString stringWithFormat:@"<%@:%p> %@", self.class, self, self.point];
}

@end
