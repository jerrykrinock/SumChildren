//
//  SCDAppDelegate.h
//  SumChildren
//
//  Created by Jerry on 13/09/19.
//  Copyright (c) 2013 Jerry. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SCDAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (IBAction)saveAction:(id)sender;

@end
