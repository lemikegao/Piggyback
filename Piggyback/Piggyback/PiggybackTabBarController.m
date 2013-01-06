//
//  PiggybackTabBarController.m
//  Piggybackv2
//
//  Created by Michael Gao on 6/21/12.
//  Copyright (c) 2012 Calimucho. All rights reserved.
//

#import "PiggybackTabBarController.h"
#import "SetAmbassadorsViewController.h"
#import "AppDelegate.h"
#import "Constants.h"
#import "PBUser.h"
#import "PBFriend.h"

@interface PiggybackTabBarController ()
@end

@implementation PiggybackTabBarController

#pragma mark - private helper methods

- (void)storeCurrentUserFbInformation:(id)meGraphApiResult {
    // store user in defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[meGraphApiResult objectForKey:@"first_name"] forKey:@"FirstName"];
    [defaults setObject:[meGraphApiResult objectForKey:@"last_name"] forKey:@"LastName"];
    [defaults setObject:[meGraphApiResult objectForKey:@"id"] forKey:@"FBID"];
    [defaults setObject:[meGraphApiResult objectForKey:@"email"] forKey:@"Email"];
    [defaults synchronize];
    
    NSLog(@"firstname: %@", [defaults objectForKey:@"FirstName"]);

    // store new user in core data and server db if not exists yet
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"fbId = %@",[defaults objectForKey:@"FBID"]];
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"PBUser"];
    fetchRequest.predicate = predicate;
    NSManagedObjectContext *context = [(AppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext];
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    if ([fetchedObjects count] == 0) {
        // add new user
        NSManagedObject *user = [NSEntityDescription insertNewObjectForEntityForName:@"PBUser" inManagedObjectContext:context];
        [user setValue:[NSNumber numberWithLongLong:[[defaults objectForKey:@"FBID"] longLongValue]] forKey:@"fbId"];
        [user setValue:[defaults objectForKey:@"FirstName"] forKey:@"firstName"];
        [user setValue:[defaults objectForKey:@"LastName"] forKey:@"lastName"];
        [user setValue:[NSNumber numberWithInt:1] forKey:@"uid"];
        if (![context save:&error]) {
            NSLog(@"Couldn't save new user: %@", [error localizedDescription]);
        }
    } else {
        PBUser *user = [fetchedObjects objectAtIndex:0];
        [defaults setObject:user.uid forKey:@"UID"];
        [defaults synchronize];
    }
}

- (void)getFriendsOfCurrentUser {
    Facebook *facebook = [(AppDelegate*)[[UIApplication sharedApplication] delegate] facebook];
    self.currentFbAPICall = fbAPIGraphMeFriends;
    [facebook requestWithGraphPath:@"me/friends?limit=5000" andDelegate:self];
}

- (void)storeCurrentUsersFriendsInCoreData:(id)meGraphApiResult {    
    // add friends to core data if they are not in it yet - do in background thread!
//    dispatch_queue_t storeFriendsQueue = dispatch_queue_create("storeFriendsInCoreData",NULL);
//    dispatch_async(storeFriendsQueue, ^{
//        for (NSDictionary* friend in [meGraphApiResult objectForKey:@"data"]) {
//            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"fbId = %@",[NSNumber numberWithLongLong:[[friend objectForKey:@"id"] longLongValue]]];
//            NSArray *friendArray = [PBFriend objectsWithPredicate:predicate];
//            if ([friendArray count] == 0) {
//                PBFriend* newFriend = [PBFriend object];
//                newFriend.fbId = [NSNumber numberWithLongLong:[[friend objectForKey:@"id"] longLongValue]];
//                
//                // parse name into first and last
//                NSArray* nameComponents = [[friend objectForKey:@"name"] componentsSeparatedByString:@" "];
//                if ([nameComponents count] > 0) {
//                    newFriend.firstName = [nameComponents objectAtIndex:0];
//                    NSString* lastName = @"";
//                    for (int i = 1; i < [nameComponents count]; i++) {
//                        lastName = [NSString stringWithFormat:@"%@ %@",lastName, [nameComponents objectAtIndex:i]];
//                    }
//                    if ([lastName length] > 0) {
//                        lastName = [lastName substringWithRange:NSMakeRange(1,[lastName length]-1)];
//                    }
//                    newFriend.lastName = lastName;
//                }
//            }
//        }
//        [[RKObjectManager sharedManager].objectStore save:nil];
//        NSLog(@"friends are done loading");
//        dispatch_sync(dispatch_get_main_queue(), ^{
//            self.foursquareDelegate.didFacebookFriendsLoad = YES;
//            if (self.foursquareDelegate.didFacebookFriendsLoad && self.foursquareDelegate.didLoginToFoursquare && !self.foursquareDelegate.didLoadFoursquareFriends) {
//                [self.foursquareDelegate getFoursquareSelf];
//                [self.foursquareDelegate getFoursquareFriends];
//                NSLog(@"loading foursquare friends after friends are done loading");
//            }
//            [(SetAmbassadorsViewController*)self.setAmbassadorsNavigationController.topViewController reloadFriendsList];
//        });
//    });
}

#pragma mark - FBRequestDelegate methods

- (void)request:(FBRequest *)request didLoad:(id)result { 
    NSLog(@"request did load");
    switch (self.currentFbAPICall) {
        case fbAPIGraphMeFromLogin:
        {
            [self storeCurrentUserFbInformation:result];
            [self getFriendsOfCurrentUser];
            break;
        }
    
        case fbAPIGraphMeFriends: 
        {
            [self storeCurrentUsersFriendsInCoreData:result];
            break;
        }
        default: 
            break;
    }
}

- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"Error message: %@", [[error userInfo] objectForKey:@"error_msg"]);
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"FBRequestDelegate Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
}

#pragma mark - view lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.setAmbassadorsNavigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"setAmbassadorsNavigationViewController"];
}

@end
