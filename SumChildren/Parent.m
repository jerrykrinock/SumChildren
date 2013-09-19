//
//  Parent.m
//  Children
//
//  Created by Lionel Fouillen on 17/09/13.
//  Copyright (c) 2013 ITygrys Sp. z o.o. All rights reserved.
//

#import "Parent.h"
#import "Child.h"


@implementation Parent

@dynamic parentSum;
@dynamic myChildren;


- (void)addMyChildrenObject:(NSManagedObject *)value {
	NSSet *s = [NSSet setWithObject:value];
	[self willChangeValueForKey:@"myChildren" withSetMutation:NSKeyValueUnionSetMutation usingObjects:s];
	[[self primitiveValueForKey:@"myChildren"] addObject:value];
	[self didChangeValueForKey:@"myChildren" withSetMutation:NSKeyValueMinusSetMutation usingObjects:s];
}

- (void)removeMyChildrenObject:(NSManagedObject *)value {
	NSSet *s = [NSSet setWithObject:value];
	[self willChangeValueForKey:@"myChildren" withSetMutation:NSKeyValueMinusSetMutation usingObjects:s];
	[[self primitiveValueForKey:@"myChildren"] removeObject:value];
	[self didChangeValueForKey:@"myChildren" withSetMutation:NSKeyValueMinusSetMutation usingObjects:s];
}

- (NSDecimalNumber *)parentSum {
    return [self valueForKeyPath:@"myChildren.@sum.childThree"];
}

// code below does'nt make a difference
/*
+ (NSSet *)keyPathsForValuesAffectingParentSum {
    return [NSSet setWithObjects:@"myChildren",nil];
}
*/

// code below does'nt make a difference
/*
- (void)addMyChildrenObject:(Child *)value {
	NSSet *s = [NSSet setWithObject:value];
	[self willChangeValueForKey:@"myChildren" withSetMutation:NSKeyValueUnionSetMutation usingObjects:s];
	[[self primitiveValueForKey:@"myChildren"] addObject:value];
	[self didChangeValueForKey:@"myChildren" withSetMutation:NSKeyValueMinusSetMutation usingObjects:s];
}

- (void)removeMyChildrenObject:(Child *)value {
	NSSet *s = [NSSet setWithObject:value];
	[self willChangeValueForKey:@"myChildren" withSetMutation:NSKeyValueMinusSetMutation usingObjects:s];
	[[self primitiveValueForKey:@"myChildren"] removeObject:value];
	[self didChangeValueForKey:@"myChildren" withSetMutation:NSKeyValueMinusSetMutation usingObjects:s];
}
*/

// code below does'nt make a difference
/*
- (void)addMyChildren:(NSSet *)values {
    [self willChangeValueForKey:@"myChildren" withSetMutation:NSKeyValueUnionSetMutation usingObjects:values];
    [[self primitiveValueForKey:@"myChildren"] unionSet:values];
    [self didChangeValueForKey:@"myChildren" withSetMutation:NSKeyValueUnionSetMutation usingObjects:values];
}
 
- (void)removeMyChildren:(NSSet *)values {
    [self willChangeValueForKey:@"myChildren" withSetMutation:NSKeyValueMinusSetMutation usingObjects:values];
    [[self primitiveValueForKey:@"myChildren"] minusSet:values];
    [self didChangeValueForKey:@"myChildren" withSetMutation:NSKeyValueMinusSetMutation usingObjects:values];
}
*/


@end
