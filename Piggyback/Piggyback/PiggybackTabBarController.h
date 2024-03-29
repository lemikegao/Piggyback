//
//  PiggybackTabBarController.h
//  Piggybackv2
//
//  Created by Michael Gao on 6/21/12.
//  Copyright (c) 2012 Calimucho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"
#import "SetAmbassadorsNavigationController.h"

@interface PiggybackTabBarController : UITabBarController <FBRequestDelegate>

@property int currentFbAPICall;
@property (nonatomic, strong) SetAmbassadorsNavigationController* setAmbassadorsNavigationController;

@end
