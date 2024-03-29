//
//  SetAmbassadorsViewController.h
//  Piggybackv2
//
//  Created by Kimberly Hsiao on 7/5/12.
//  Copyright (c) 2012 Calimucho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetAmbassadorCell.h"

@interface SetAmbassadorsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, SetAmbassadorDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

- (IBAction)readyButton:(id)sender;
- (void)reloadFriendsList;

@end
