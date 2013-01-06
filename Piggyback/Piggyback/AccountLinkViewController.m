//
//  AccountLinkViewController.m
//  Piggybackv2
//
//  Created by Michael Gao on 6/21/12.
//  Copyright (c) 2012 Calimucho. All rights reserved.
//

#import "AccountLinkViewController.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "SetAmbassadorsViewController.h"
#import "PiggybackTabBarController.h"

@implementation AccountLinkViewController

- (void)viewDidUnload
{
    [super viewDidUnload];
    [self setSpotifyToggle:nil];
}

- (IBAction)spotifyConnect:(id)sender {
    if ([sender isOn] == YES) {
        NSLog(@"spotify toggle on");
//        SPLoginViewController *spotifyLogin = [SPLoginViewController loginControllerForSession:[SPSession sharedSession]];
//        [self presentViewController:spotifyLogin animated:YES completion:nil];
    } else {
        NSLog(@"spotify toggle off");
//        [[SPSession sharedSession] logout:^{}];
    }
}

- (IBAction)continueButton:(id)sender {    
    // display set ambassadors view
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    PiggybackTabBarController* rootViewController = (PiggybackTabBarController*)appDelegate.window.rootViewController;
    [self presentViewController:rootViewController.setAmbassadorsNavigationController animated:YES completion:nil];
}

@end
