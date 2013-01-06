//
//  AppDelegate.h
//  Piggyback
//
//  Created by Michael Gao on 1/6/13.
//  Copyright (c) 2013 Piggyback. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"
#import "AccountLinkNavigationController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, FBSessionDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) Facebook *facebook;
@property (nonatomic, strong) AccountLinkNavigationController *accountLinkNavigationController;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
