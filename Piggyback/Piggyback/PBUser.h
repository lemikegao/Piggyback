//
//  PBUser.h
//  Piggybackv2
//
//  Created by Kimberly Hsiao on 7/25/12.
//  Copyright (c) 2012 Calimucho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PBMusicActivity, PBUser;

@interface PBUser : NSManagedObject

@property (nonatomic, retain) NSDate * dateAdded;
@property (nonatomic, retain) NSNumber * fbId;
@property (nonatomic, retain) NSNumber * uid;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * spotifyUsername;
@property (nonatomic, retain) NSSet *musicActivity;
@property (nonatomic, retain) NSSet *musicAmbassadors;
@property (nonatomic, retain) NSSet *musicFollowers;
@end

@interface PBUser (CoreDataGeneratedAccessors)

- (void)addMusicActivityObject:(PBMusicActivity *)value;
- (void)removeMusicActivityObject:(PBMusicActivity *)value;
- (void)addMusicActivity:(NSSet *)values;
- (void)removeMusicActivity:(NSSet *)values;

- (void)addMusicAmbassadorsObject:(PBUser *)value;
- (void)removeMusicAmbassadorsObject:(PBUser *)value;
- (void)addMusicAmbassadors:(NSSet *)values;
- (void)removeMusicAmbassadors:(NSSet *)values;

- (void)addMusicFollowersObject:(PBUser *)value;
- (void)removeMusicFollowersObject:(PBUser *)value;
- (void)addMusicFollowers:(NSSet *)values;
- (void)removeMusicFollowers:(NSSet *)values;

@end
