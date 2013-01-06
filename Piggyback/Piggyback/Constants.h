//
//  Constants.h
//  Piggyback
//
//  Created by Michael Gao on 1/6/13.
//  Copyright (c) 2013 Piggyback. All rights reserved.
//

#ifndef Piggyback_Constants_h
#define Piggyback_Constants_h

typedef enum fbApiCall {
    fbAPIGraphMeFromLogin,
    fbAPIGraphMeFriends
} fbApiCall;

typedef enum fsApiCall {
    fsAPIGetSelf,
    fsAPIGetFriends,
    fsAPIGetRecentCheckins
} fsApiCall;

#endif
