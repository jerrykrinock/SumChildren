//
//  Child.m
//  Children
//
//  Created by Lionel Fouillen on 17/09/13.
//  Copyright (c) 2013 ITygrys Sp. z o.o. All rights reserved.
//

#import "Child.h"
#import "Parent.h"


@implementation Child

@dynamic childOne;
@dynamic childTwo;
@dynamic childThree;
@dynamic myParent;

-(NSDecimalNumber *)childThree {
    return [[self childOne] decimalNumberByMultiplyingBy:[self childTwo]];
}

// code below has no effect
/*
+ (NSSet *)keyPathsForValuesAffectingChildThree {
    return [NSSet setWithObjects:@"childOne",@"childTwo",nil];
}
*/

@end
