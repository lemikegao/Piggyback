//
//  SetAmbassadorsViewController.m
//  Piggybackv2
//
//  Created by Kimberly Hsiao on 7/5/12.
//  Copyright (c) 2012 Calimucho. All rights reserved.
//

#import "SetAmbassadorsViewController.h"
#import "Constants.h"
#import "PBFriend.h"
#import <QuartzCore/QuartzCore.h>
#import "PBUser.h"
#import "PiggybackTabBarController.h"
#import "AppDelegate.h"
//#import "HomeViewController.h"

@interface SetAmbassadorsViewController ()
@property (nonatomic, strong) NSArray* friends;
@property (nonatomic, strong) NSArray *displayFriends;
@property (nonatomic, strong) NSMutableSet *selectedMusicAmbassadorIndexes;
@end

@implementation SetAmbassadorsViewController

#pragma mark - setters and getters

- (NSArray*)friends {
    if (!_friends) {
        _friends = [[NSArray alloc] init];
    }
    return _friends;
}

- (void)setDisplayFriends:(NSArray *)displayFriends {
    _displayFriends = displayFriends;
    [self.tableView reloadData];
}

- (NSMutableSet*)selectedMusicAmbassadorIndexes {
    if (!_selectedMusicAmbassadorIndexes) {
        _selectedMusicAmbassadorIndexes = [[NSMutableSet alloc] init];
    }
    return _selectedMusicAmbassadorIndexes;
}

#pragma mark - private methods

- (void)hideKeyboard {
    [self.view endEditing:YES];
}

//- (void)addAmbassadorToDb:(NSNumber*)ambassadorUid forFollower:(NSNumber*)followerUid forType:(NSString*)type {
//    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:followerUid, @"followerUid", ambassadorUid, @"ambassadorUid", type, @"ambassadorType", nil];
//    id<RKParser> parser = [[RKParserRegistry sharedRegistry] parserForMIMEType:RKMIMETypeJSON];
//    NSError *error = nil;
//    NSString *json = [parser stringFromObject:params error:&error];
//    
//    if (!error) {
//        [[RKClient sharedClient] post:@"/addAmbassador" params:[RKRequestSerialization serializationWithData:[json dataUsingEncoding:NSUTF8StringEncoding] MIMEType:RKMIMETypeJSON] delegate:self];
//    }
//}

//- (void)removeAmbassadorFromDb:(NSNumber*)ambassadorUid forFollower:(NSNumber*)followerUid forType:(NSString*)type {
//    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:followerUid, @"followerUid", ambassadorUid, @"ambassadorUid", type, @"ambassadorType", nil];
//    id<RKParser> parser = [[RKParserRegistry sharedRegistry] parserForMIMEType:RKMIMETypeJSON];
//    NSError *error = nil;
//    NSString *json = [parser stringFromObject:params error:&error];
//    
//    if (!error) {
//        [[RKClient sharedClient] put:@"/removeAmbassador" params:[RKRequestSerialization serializationWithData:[json dataUsingEncoding:NSUTF8StringEncoding] MIMEType:RKMIMETypeJSON] delegate:self];
//    }
//}

#pragma mark - SetAmbassadorDelegate methods

- (void)setAmbassador:(PBFriend*)friend ForType:(NSString *)type {
//    // get me
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    PBUser *me = [PBUser findByPrimaryKey:[defaults objectForKey:@"UID"]];
//    NSLog(@" i am %@ ", me);
//    
//    // check if user exists already
//    NSPredicate *userPredicate = [NSPredicate predicateWithFormat:@"fbId = %@",friend.fbId];
//    PBUser *friendUser = [PBUser objectWithPredicate:userPredicate];
//    
//    // if user does not exist, add user
//    if (!friendUser) {
//        PBUser *newUser = [PBUser object];
//        newUser.fbId = [NSNumber numberWithLongLong:[friend.fbId longLongValue]];
//        newUser.email = friend.email;
//        newUser.firstName = friend.firstName;
//        newUser.lastName = friend.lastName;
//        newUser.spotifyUsername = friend.spotifyUsername;
//        newUser.youtubeUsername = friend.youtubeUsername;
//        newUser.foursquareId = friend.foursquareId;
//        newUser.isPiggybackUser = [NSNumber numberWithBool:NO];
//        
//        if ([newUser.firstName isEqualToString:@"Haines"]) {
//            newUser.youtubeUsername = @"NerdsInNewYork";
//        } else if ([newUser.firstName isEqualToString:@"Lianna"]) {
//            newUser.youtubeUsername = @"mlgao";
//        } else if ([newUser.lastName isEqualToString:@"Gao"]) {
//            newUser.youtubeUsername = @"mlgao";
//        }
//        
//        // add user and add ambassador
//        [[RKObjectManager sharedManager] postObject:newUser usingBlock:^(RKObjectLoader* loader) {
//            loader.onDidLoadObjects = ^(NSArray* objects) {
//                if ([type isEqualToString:@"music"]) {
//                    [newUser addMusicFollowersObject:me];
//                    
//                    // add ambassador to db
//                    // [[RKObjectManager sharedManager] postObject:newAmbassador delegate:self];
//                } else if ([type isEqualToString:@"places"]) {
//                    [newUser addPlacesFollowersObject:me];
//                    
//                    // add ambassador to db
//                    // [[RKObjectManager sharedManager] postObject:newAmbassador delegate:self];
//                } else if ([type isEqualToString:@"videos"]) {
//                    [newUser addVideosFollowersObject:me];
//                    
//                    // add ambassador to db
//                    // [[RKObjectManager sharedManager] postObject:newAmbassador delegate:self];
//                }
//                
//                // add ambassador to DB
//                [self addAmbassadorToDb:newUser.uid forFollower:me.uid forType:type];
//                
//                // store photo in core data
//                if (!friend.thumbnail) {
//                    NSString* thumbnailURL = [NSString stringWithFormat:@"http://graph.facebook.com/%@/picture",newUser.fbId];
//                    newUser.thumbnail = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:thumbnailURL]]];
////                    [[RKObjectManager sharedManager].objectStore save:nil];
//                } else {
//                    newUser.thumbnail = friend.thumbnail;
////                    [[RKObjectManager sharedManager].objectStore save:nil];
//                }
//                
//                // update foursquare id if they didnt have one before but have one now
//                if (!newUser.foursquareId) {
//                    if (friend.foursquareId) {
//                        newUser.foursquareId = friend.foursquareId;
//                        
//                        // update user
//                        [[RKObjectManager sharedManager] putObject:newUser usingBlock:^(RKObjectLoader* loader) {
//                            NSLog(@"user updated with foursquareId");
//                        }];
//                    }
//                }
//                
//                NSLog(@"me is %@",me);
//                NSLog(@"new user is %@",newUser);
//            };
//        }];
//    } 
//    
//    // user exists already, only update ambassador table
//    else {
//        
//        // if ambassador does not exist yet, add ambassador
//        if ([type isEqualToString:@"music"]) {
//            if (![friendUser.musicFollowers containsObject:me]) {
//                [friendUser addMusicFollowersObject:me];
//                
//                // add ambassador to db
//            }
//        } else if ([type isEqualToString:@"places"]) {
//            if (![friendUser.placesFollowers containsObject:me]) {
//                [friendUser addPlacesFollowersObject:me];
//                
//                // add ambassador to db
//            }
//        } else if ([type isEqualToString:@"videos"]) {
//            if (![friendUser.videosFollowers containsObject:me]) {
//                [friendUser addVideosFollowersObject:me];
//                
//                // add ambassador to db
//            }
//        }
//        
//        // add ambassador to DB
//        [self addAmbassadorToDb:friendUser.uid forFollower:me.uid forType:type];
//        
//        // add foursquare id if they dont have one
//        if (!friendUser.foursquareId) {
//            NSLog(@"friend user has no fs id");
//            if (friend.foursquareId) {
//                friendUser.foursquareId = friend.foursquareId;
//                NSLog(@"but friend has fs id ");
//                
//                // update user
//                [[RKObjectManager sharedManager] putObject:friendUser usingBlock:^(RKObjectLoader* loader) {
//                    NSLog(@"user updated with foursquareId");
//                }];
//            }
//        }
//            
//        NSLog(@"user is %@",friendUser);
//        NSLog(@"i am %@",me);
//    }
}

- (void)removeAmbassador:(PBFriend*)friend ForType:(NSString*)type {
//    // get me
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSPredicate *getMyUserPredicate = [NSPredicate predicateWithFormat:@"uid = %@",[defaults objectForKey:@"UID"]];
//    PBUser *me = [PBUser objectWithPredicate:getMyUserPredicate];
//    
//    // fetch user from friend
//    NSPredicate* userPredicate = [NSPredicate predicateWithFormat:@"fbId = %@",friend.fbId];
//    PBUser* removedUser = [PBUser objectWithPredicate:userPredicate];
//    
//    if (removedUser) {
//        if ([type isEqualToString:@"music"]) {
//            // remove ambassador linkage from core data
//            [me removeMusicAmbassadorsObject:removedUser];
//            
//            // remove ambassador from database
//        } else if ([type isEqualToString:@"places"]) {
//            // remove ambassador linkage from core data
//            [me removePlacesAmbassadorsObject:removedUser];
//            
//            // remove ambassador from database
//        } else if ([type isEqualToString:@"videos"]) {
//            [me removeVideosAmbassadorsObject:removedUser];
//        }
//        
//        // remove ambassador from DB
//        [self removeAmbassadorFromDb:removedUser.uid forFollower:me.uid forType:type];
//    
//        // if removed user has no other followers and is not my follower, remove user from core data
//        int count = [removedUser.musicFollowers count] + [removedUser.placesFollowers count];
//        if (count == 0 && ![removedUser.placesAmbassadors containsObject:me] && ![removedUser.musicAmbassadors containsObject:me]) {
//            RKManagedObjectStore *objectStore = [[RKObjectManager sharedManager] objectStore];
//            [[objectStore managedObjectContextForCurrentThread] deleteObject:removedUser];
//            [objectStore save:nil];
//        }
//    
//        NSLog(@"i am %@",me);
//        NSLog(@"removed user is %@",removedUser);
//    }
}

- (void)clickFollow:(PBFriend*)friend forType:(NSString*)type {
//    NSMutableSet* ambassadors = [[NSMutableSet alloc] init];
//    if ([type isEqualToString:@"music"]) {
//        ambassadors = self.selectedMusicAmbassadorIndexes;
//    } else if ([type isEqualToString:@"places"]) {
//        ambassadors = self.selectedPlacesAmbassadorIndexes;
//    } else if ([type isEqualToString:@"videos"]) {
//        ambassadors = self.selectedVideosAmbassadorIndexes;
//    }
//
//    if ([ambassadors containsObject:friend.fbId]) {
//        [ambassadors removeObject:friend.fbId];
//        [self removeAmbassador:friend ForType:type];
//        for (NSIndexPath* indexPath in [self.tableView indexPathsForVisibleRows]) {
//            if ([(SetAmbassadorCell*)[self.tableView cellForRowAtIndexPath:indexPath] friend] == friend) {
//                [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
//            }
//        }
//    } else {
//        NSLog(@"click follow ambassador fbid is %@",friend.fbId);
//        [ambassadors addObject:friend.fbId];
//        [self setAmbassador:friend ForType:type];
//        for (NSIndexPath* indexPath in [self.tableView indexPathsForVisibleRows]) {
//            if ([(SetAmbassadorCell*)[self.tableView cellForRowAtIndexPath:indexPath] friend] == friend) {
//                [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
//            }
//        }
//    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.displayFriends count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"setAmbassadorCell";
    SetAmbassadorCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.setAmbassadorDelegate = self;

    // get current friend and set cell
    PBFriend* friend = [self.displayFriends objectAtIndex:indexPath.row];
    cell.friend = friend;
    cell.name.text = [NSString stringWithFormat:@"%@ %@",friend.firstName, friend.lastName];
    
    // display music button
    if ([self.selectedMusicAmbassadorIndexes containsObject:friend.fbId]) {
        [cell.followMusic setImage:[UIImage imageNamed:@"follow-music-button-pressed"] forState:UIControlStateNormal];
    } else {
        [cell.followMusic setImage:[UIImage imageNamed:@"follow-music-button-normal"] forState:UIControlStateNormal];
    }

    return cell;
}

//- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath: (NSIndexPath *) indexPath 
//{
//    return SETAMBASSADORSROWHEIGHT;
//}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark - searchbar delegate methods
- (void)searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText {
    NSMutableArray *searchArray = [[NSMutableArray alloc] init];
    NSMutableArray *lastNameSearchArray = [[NSMutableArray alloc] init];
    BOOL alreadyAdded = NO;
    
    for (PBFriend *currentFriend in self.friends) {
        alreadyAdded = NO;
        NSString *currentFriendName = [NSString stringWithFormat:@"%@ %@", currentFriend.firstName, currentFriend.lastName];
        NSRange range = {0, [searchText length]};
        if ([searchText length] <= [currentFriendName length]) {
            NSRange nameRange = [currentFriendName rangeOfString:searchText options:NSCaseInsensitiveSearch range:range];
        
            if (nameRange.length > 0) {
                [searchArray addObject:currentFriend];
                alreadyAdded = YES;
            }
        }
        
        if ([searchText length] <= [currentFriend.lastName length]) {
            NSRange lastNameRange = [currentFriend.lastName rangeOfString:searchText options:NSCaseInsensitiveSearch range:range];
            if (lastNameRange.length > 0 && !alreadyAdded) {
                [lastNameSearchArray addObject:currentFriend];
            }
        }
    }
    
    [searchArray addObjectsFromArray:lastNameSearchArray];
    
    if (![searchText isEqualToString:@""]) {
        self.displayFriends = searchArray;
    } else {
        self.displayFriends = self.friends;
    }
    
}

#pragma mark - UIScrollViewDelegate protocol methods
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self hideKeyboard];
}

#pragma mark - view lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"display friends");
    
    // get me
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSPredicate *getMyUserPredicate = [NSPredicate predicateWithFormat:@"uid = %@",[defaults objectForKey:@"UID"]];
//    PBUser *me = [PBUser objectWithPredicate:getMyUserPredicate];
//    
//    // get my ambassadors and add to array
//    if (me) {
//        for (PBUser* ambassador in me.musicAmbassadors) {
//            NSLog(@"ambassador fbid in view did load is %@",ambassador.fbId);
//            [self.selectedMusicAmbassadorIndexes addObject:ambassador.fbId];
//        }
//    }
//    
//    // replace keyboard 'Search' button with 'Done'
//    for (UIView *searchBarSubview in [self.searchBar subviews]) {
//        if ([searchBarSubview conformsToProtocol:@protocol(UITextInputTraits)]) {
//            @try {
//                [(UITextField *)searchBarSubview setReturnKeyType:UIReturnKeyDone];
//                [(UITextField *)searchBarSubview setKeyboardAppearance:UIKeyboardAppearanceAlert];
//                [(UITextField *)searchBarSubview setEnablesReturnKeyAutomatically:NO];
//                [(UITextField *)searchBarSubview addTarget:self action:@selector(hideKeyboard) forControlEvents:UIControlEventEditingDidEndOnExit];
//            }
//            @catch (NSException * e) {
//
//            }
//        }
//    }
//    
//    [self reloadFriendsList];
}

- (void)reloadFriendsList {
//    NSSortDescriptor *sortDescriptorFirstName = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
//    NSSortDescriptor *sortDescriptorLastName = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES];
//    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptorFirstName,sortDescriptorLastName,nil];
//    self.friends = [[PBFriend allObjects] sortedArrayUsingDescriptors:sortDescriptors];
//    self.displayFriends = self.friends;
//    [self.tableView reloadData];
}
- (void)viewDidUnload
{
    [self setTableView:nil];
    [self setSearchBar:nil];
    [super viewDidUnload];
}


#pragma mark - ib actions

- (IBAction)readyButton:(id)sender {
//    [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
//    AppDelegate* appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    HomeViewController* homeViewController = (HomeViewController*)[[[(PiggybackTabBarController*)appDelegate.window.rootViewController viewControllers] objectAtIndex:0] topViewController];
//    [homeViewController loadAmbassadorData];
}

@end
