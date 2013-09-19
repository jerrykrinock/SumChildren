//
//  Parent.h
//  Children
//
//  Created by Lionel Fouillen on 17/09/13.
//  Copyright (c) 2013 ITygrys Sp. z o.o. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Parent : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * parentSum;
@property (nonatomic, retain) NSSet *myChildren;
@end

@interface Parent (CoreDataGeneratedAccessors)

- (void)addMyChildrenObject:(NSManagedObject *)value;
- (void)removeMyChildrenObject:(NSManagedObject *)value;
- (void)addMyChildren:(NSSet *)values;
- (void)removeMyChildren:(NSSet *)values;

@end
