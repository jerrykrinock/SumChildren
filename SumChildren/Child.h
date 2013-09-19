//
//  Child.h
//  Children
//
//  Created by Lionel Fouillen on 17/09/13.
//  Copyright (c) 2013 ITygrys Sp. z o.o. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Parent;

@interface Child : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * childOne;
@property (nonatomic, retain) NSDecimalNumber * childTwo;
@property (nonatomic, retain) NSDecimalNumber * childThree;
@property (nonatomic, retain) Parent *myParent;

@end
