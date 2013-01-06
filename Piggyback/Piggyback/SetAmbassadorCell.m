//
//  SetAmbassadorCell.m
//  Piggybackv2
//
//  Created by Kimberly Hsiao on 7/5/12.
//  Copyright (c) 2012 Calimucho. All rights reserved.
//

#import "SetAmbassadorCell.h"
#import "PBUser.h"
#import <QuartzCore/QuartzCore.h>

@interface SetAmbassadorCell ()

@end

@implementation SetAmbassadorCell

#pragma mark - ib actions

- (IBAction)clickFollowMusic {
    [self.setAmbassadorDelegate clickFollow:self.friend forType:@"music"];
}

#pragma mark - tablecell delegate methods

@end
