//
//  AppDelegate.h
//  Piggyback
//
//  Created by Michael Gao on 1/6/13.
//  Copyright (c) 2013 Piggyback. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, FBSessionDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) Facebook *facebook;

@end
