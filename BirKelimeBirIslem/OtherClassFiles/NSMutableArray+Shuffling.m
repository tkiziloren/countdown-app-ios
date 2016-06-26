//
//  NSMutableArray+Shuffling.m
//  BirKelimeBirIslem
//
//  Created by Tevfik Kızılören on 8/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "NSMutableArray+Shuffling.h"

@implementation NSMutableArray (Shuffling)

- (void)shuffle
{
    NSUInteger count = [self count];
    for (NSUInteger i = 0; i < count; ++i) {
        int nElements = count - i;
        int n = arc4random_uniform(nElements) + i;
        [self exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
}


@end
