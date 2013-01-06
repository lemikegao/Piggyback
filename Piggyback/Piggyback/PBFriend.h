//
//  PBFriend.h
//  Piggybackv2
//
//  Created by Kimberly Hsiao on 7/16/12.
//  Copyright (c) 2012 Calimucho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PBFriend : NSManagedObject

@property (nonatomic, retain) NSNumber * fbId;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * spotifyUsername;

@end
