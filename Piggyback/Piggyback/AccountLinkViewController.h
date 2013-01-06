//
//  AccountLinkViewController.h
//  Piggybackv2
//
//  Created by Michael Gao on 6/21/12.
//  Copyright (c) 2012 Calimucho. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountLinkViewController : UIViewController

- (IBAction)spotifyConnect:(id)sender;
- (IBAction)continueButton:(id)sender;
@property (weak, nonatomic) IBOutlet UISwitch *spotifyToggle;

@end
