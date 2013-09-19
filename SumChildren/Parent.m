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


- (void)updateSum {
    NSDecimalNumber* sum = [NSDecimalNumber zero] ;
    for (Child* child in [self valueForKey:@"myChildren"]) {
        sum = [sum decimalNumberByAdding:[child valueForKey:@"childThree"]] ;
    }
    
    if (![sum isEqualToNumber:[self valueForKey:@"parentSum"]]) {
        [self setValue:sum
                forKey:@"parentSum"] ;
    }
}

/*
 There are many methods available for changing to-many relationships…
 * addFooObject:
 * removeFooObject:
 * setFoo:
 * mutableSetValueForKey:@"Foo"
 and maybe more.  I forgot.  Anyhow, we need to invoke our -updateSum when
 *any* of these methods changes the value, so if we were going to do this in
 custom setters we would need to write a bunch.  Furthermore, the last method,
 mutableSetValueForKey:, is a custom-setter show-stopper because it's actually
 more of a getter.  You hand out this mutable set, and it gets changed at some
 later time, and it's really a proxy, and so it's really a mess.  Plus, just
 for curiousity I put breakpoints on all of those, deleted a child and 
 *none* of my breakpoints broke.  So Core Data may be using some other
 method which would take some research to find.
 
 The solution to this dilemna, the only reliable way to watch for changes in
 to-many relationships, is key-value observing.  That requires alot of code
 too, because we need to start observing whenever an object is inserted or
 fetched, and stop observing whenever the object becomes a fault.
 
 But once you've done it a few times, it rolls off the keys …
 */

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    [self updateSum] ;
}

- (void)startObserving {
    [self addObserver:self
           forKeyPath:@"myChildren"
              options:0
              context:NULL] ;
}

- (void)stopObserving {
    [self removeObserver:self
              forKeyPath:@"myChildren"] ;
}

- (void)awakeFromFetch {
	[super awakeFromFetch] ;
    
    [self startObserving] ;

    /*
     Actually, the following line is not for KVO.  It is to preserve
     database integrity in case a crash or power failure allows the parentSum
     in the persistent store to become unequal to the sum of its childrens'
     childThree objects.  This is one of the reason why I avoid keeping
     redundant derived properties in a database until it is shown to be
     necessary for performance.
     */
    [self updateSum] ;
}

- (void)awakeFromInsert {
    [super awakeFromInsert] ;

    [self startObserving] ;
}

- (void)didTurnIntoFault {
    [self stopObserving] ;
}

#pragma mark End of KVO Code

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
