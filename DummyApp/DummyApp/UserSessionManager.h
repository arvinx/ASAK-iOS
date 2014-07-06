//
//  UserSessionManager.h
//  DummyApp
//
//  Created by Arvin Rezvanpour on 2014-07-05.
//  Copyright (c) 2014 Arvin Rezvanpour. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "constants.h"


@interface UserSessionManager : NSObject

+ (void)createNewUserSession:(NSString*)token withRefreshToken:(NSString*)refreshToken withExpireTime:(NSString*)expireTime;
+ (void)refreshUserSession:(NSDictionary *)refreshResponse;
+ (void)checkShouldRefreshAndRefreshSession;
+ (NSString *)getUserSessionToken;

@end
