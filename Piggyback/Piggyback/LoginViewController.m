//
//  LoginViewController.m
//  Piggybackv2
//
//  Created by Kimberly Hsiao on 6/25/12.
//  Copyright (c) 2012 Calimucho. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "PiggybackTabBarController.h"
#import "Constants.h"

@interface LoginViewController ()
@end

@implementation LoginViewController

#pragma mark - public helper functions

- (void)getAndStoreCurrentUserFbInformationAndUid {
    Facebook *facebook = [(AppDelegate *)[[UIApplication sharedApplication] delegate] facebook];
    
    // Uid is retrieved from request:didLoad: method (FBRequestDelegate method) -- for synchronous purposes
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    PiggybackTabBarController* rootViewController = (PiggybackTabBarController*)appDelegate.window.rootViewController;
    rootViewController.currentFbAPICall = fbAPIGraphMeFromLogin;
    [facebook requestWithGraphPath:@"me" andDelegate:rootViewController];
}

#pragma mark - IBAction definitions

- (IBAction)loginWithFacebook:(id)sender {
    NSLog(@"login with facebook button pressed");
    [[(AppDelegate *)[[UIApplication sharedApplication] delegate] facebook] authorize:nil];
}

@end
