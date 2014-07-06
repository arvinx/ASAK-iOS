//
//  UserSessionManager.h
//  DummyApp
//
//  Created by Arvin Rezvanpour on 2014-07-05.
//  Copyright (c) 2014 Arvin Rezvanpour. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JNKeychain.h"
#import "DummyNetworking.h"
#include "constants.h"
@import Security;


@interface UserSessionManager : NSObject

+ (void)createNewUserSession:(NSString*)token withRefreshToken:(NSString*)refreshToken withExpireTime:(NSString*)expireTime;
+ (void)refreshUserSession;
+ (void)checkShouldRefreshAndRefreshSession;
+ (NSString *)getUserSessionToken;

@end
