//
//  Child.m
//  Children
//
//  Created by Lionel Fouillen on 17/09/13.
//  Copyright (c) 2013 ITygrys Sp. z o.o. All rights reserved.
//

#import "Child.h"
#import "Parent.h"


@interface Child (CoreDataGeneratedPrimitiveAccessors)

- (void)setPrimitiveChildOne:(NSDecimalNumber*)value ;
- (void)setPrimitiveChildTwo:(NSDecimalNumber*)value ;

@end

@implementation Child

@dynamic childOne;
@dynamic childTwo;
@dynamic childThree;
@dynamic myParent;

- (void)updateValuesNote:(NSNotification*)note {
    NSDecimalNumber* childOne = [self valueForKey:@"childOne"] ;
    NSDecimalNumber* childTwo = [self valueForKey:@"childTwo"] ;
    NSDecimalNumber* oldValue = [self valueForKey:@"childThree"] ;
    NSDecimalNumber* newValue = [childOne decimalNumberByMultiplyingBy:childTwo] ;
    
    if (![newValue isEqualToNumber:oldValue]) {
        [self setValue:newValue
                forKey:@"childThree"] ;
    }

    Parent* parent = [self valueForKey:@"myParent"] ;
    [parent updateSum] ;
}


- (void)updateValues {
    /*
     The reason for the delay here is that if we invoked -updateValuesNote:
     synchronously from here, it won't work when we're invoked by
     -awakeFromInsert, because our parent is still nil at that point.
     We could improve perfomance further by instead of this, enqueing a
     notification with a lazy posting style, coalescing so that 
     -updateValuesNote: would only run once for all updates.  But since that
     takes some extra code to add and remove notification observers, and since
     we've only got two attributes being updated manually, we do it this
     cheesy way for now.  It works…
     */
    [self performSelector:@selector(updateValuesNote:)
               withObject:nil
               afterDelay:0.0] ;
}


/*
 @details  This is what we call a Custom Accessor.  It is used to add necessary
 "business logic"
 */
- (void)setChildOne:(NSDecimalNumber*)newValue  {
	[self willChangeValueForKey:@"childOne"] ;
    [self setPrimitiveChildOne:newValue] ;
    [self didChangeValueForKey:@"childOne"] ;

	// Here is the payload of this method…
    [self updateValues] ;
}

/*
 @details  This is what we call a Custom Accessor.  It is used to add necessary
 "business logic"
 */
- (void)setChildTwo:(NSDecimalNumber*)newValue  {
	[self willChangeValueForKey:@"childTwo"] ;
    [self setPrimitiveChildTwo:newValue] ;
    [self didChangeValueForKey:@"childTwo"] ;

	// Here is the payload of this method…
	[self updateValues] ;
}

/*
 This is in case a crash or power failure allows the parentSum in the
 persistent store to become unequal to the sum of its childrens' childThree
 objects.
 */
- (void)awakeFromFetch {
	[super awakeFromFetch] ;
    [self updateValues] ;
}


- (void)awakeFromInsert {
	[super awakeFromInsert] ;
    
    // A new object needs to have its childThree set, assuming that the
    // default values of childOne and childTwo are not zero
    [self updateValues] ;
}


@end
