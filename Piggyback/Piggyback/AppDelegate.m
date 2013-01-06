//
//  AppDelegate.m
//  Piggyback
//
//  Created by Michael Gao on 1/6/13.
//  Copyright (c) 2013 Piggyback. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "PiggybackTabBarController.h"

@implementation AppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

// old ID? 316977565057222
#warning - change facebook app name to Piggyback (currently Ambassadors)
NSString* const FB_APP_ID = @"316977565057222";

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // set up storyboard and root view controller
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    PiggybackTabBarController *rootViewController = (PiggybackTabBarController *)self.window.rootViewController;
    
    // setting up facebook
    self.facebook = [[Facebook alloc] initWithAppId:FB_APP_ID andDelegate:self];
    
#warning - does this logic below still work?
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"]
        && [defaults objectForKey:@"FBExpirationDateKey"]) {
        self.facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
        self.facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
    }
    
    [self.window makeKeyAndVisible];
//    if (![self.facebook isSessionValid]) {
        LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"loginViewController"];
        [rootViewController presentViewController:loginViewController animated:NO completion:nil];
//    } else {
        // do nothing (default behavior is to show tab bar controller)
//    }
    
//    AccountLinkNavigationController *accountLinkNavigationController = [rootViewController.storyboard instantiateViewControllerWithIdentifier:@"accountLinkNavigationController"];
//    self.accountLinkNavigationController = accountLinkNavigationController;
//    [rootViewController presentViewController:accountLinkNavigationController animated:NO completion:nil];

    return YES;
}


#pragma mark -
#pragma mark - handling facebook and foursquare openURL redirects

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    if ([[[[url absoluteString] componentsSeparatedByString:@":"] objectAtIndex:0] isEqualToString:@"fb316977565057222"]) {
        return [self.facebook handleOpenURL:url];
    } else if ([[[[url absoluteString] componentsSeparatedByString:@":"] objectAtIndex:0] isEqualToString:@"piggyback"]) {
//        return [self.foursquare handleOpenURL:url];
    } else {
        NSLog(@"did not find a matching openURL");
    }
    
    return NO;
}

// Pre iOS 4.2 support
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [self.facebook handleOpenURL:url];
}

#pragma mark -
#pragma mark -- FBSessionDelegate methods
- (void)fbDidLogin {
    Facebook *facebook = [(AppDelegate *)[[UIApplication sharedApplication] delegate] facebook];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[facebook accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[facebook expirationDate] forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
    
    // get current user
    PiggybackTabBarController* rootViewController = (PiggybackTabBarController*)self.window.rootViewController;
    [(LoginViewController*)[rootViewController presentedViewController] getAndStoreCurrentUserFbInformationAndUid];
    
    // dismiss login view
    [rootViewController dismissViewControllerAnimated:NO completion:nil]; // dismisses loginViewController
    
    // show account link page when you log in for the first time
    AccountLinkNavigationController *accountLinkNavigationController = [rootViewController.storyboard instantiateViewControllerWithIdentifier:@"accountLinkNavigationController"];
    self.accountLinkNavigationController = accountLinkNavigationController;
    [rootViewController presentViewController:accountLinkNavigationController animated:NO completion:nil];
    
    NSLog(@"logged in");
}

- (void)fbDidNotLogin:(BOOL)cancelled {
    NSLog(@"did not log in");
}

-(void)fbDidExtendToken:(NSString *)accessToken expiresAt:(NSDate *)expiresAt {
    NSLog(@"token extended");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:accessToken forKey:@"FBAccessTokenKey"];
    [defaults setObject:expiresAt forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
}

- (void)fbDidLogout {
    // clear NSUserDefaults
    [[NSUserDefaults standardUserDefaults] setPersistentDomain:[NSDictionary dictionary] forName:[[NSBundle mainBundle] bundleIdentifier]];
    
    PiggybackTabBarController* rootViewController = (PiggybackTabBarController*)self.window.rootViewController;
    [rootViewController dismissViewControllerAnimated:NO completion:nil]; // dismisses account view controller
    
    LoginViewController *loginViewController = [rootViewController.storyboard instantiateViewControllerWithIdentifier:@"loginViewController"];
    [rootViewController presentViewController:loginViewController animated:NO completion:nil];
    
#warning - do not reset tabs
    // release existing view controllers and create new instances for next user who logs in
    //    UIViewController* listenNavigationController = [rootViewController.storyboard instantiateViewControllerWithIdentifier:@"listenNavigationController"];
    //    UIViewController* exploreNavigationController = [rootViewController.storyboard instantiateViewControllerWithIdentifier:@"exploreNavigationController"];
    //    UIViewController* watchNavigationController = [rootViewController.storyboard instantiateViewControllerWithIdentifier:@"watchNavigationController"];
    //    NSArray* newTabViewControllers = [NSArray arrayWithObjects:listenNavigationController, exploreNavigationController, watchNavigationController, nil];
    //    rootViewController.viewControllers = newTabViewControllers;
    //    rootViewController.selectedIndex = 0;
    
    NSLog(@"logged out");
}

- (void)fbSessionInvalidated {
    
}

							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Piggybackv2" withExtension:@"mom"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    NSLog(@"hi mike: %@", _managedObjectModel);
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Piggybackv2.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


@end
