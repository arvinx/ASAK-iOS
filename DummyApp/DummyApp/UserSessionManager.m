//
//  UserSessionManager.m
//  DummyApp
//
//  Created by Arvin Rezvanpour on 2014-07-05.
//  Copyright (c) 2014 Arvin Rezvanpour. All rights reserved.
//

#import "UserSessionManager.h"
#import "DummyNetworking.h"

static int isFetchingRefresh = 0;

@implementation UserSessionManager

+ (void)createNewUserSession:(NSString*)token withRefreshToken:(NSString*)refreshToken withExpireTime:(NSString*)expireTime {
    [JNKeychain saveValue:token forKey:kLoginResponseToken];
    [JNKeychain saveValue:refreshToken forKey:kLoginResponseRefreshToken];
    [JNKeychain saveValue:expireTime forKey:kLoginResponseExpire];
    [JNKeychain saveValue:[NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]] forKey:kCurrentSystemTime];
}


+ (void)refreshUserSession:(void (^)(void))requestBlock {
    DummyNetworking *dummyNetworking = [[DummyNetworking alloc] init];
    NSDictionary *params = @{kLoginRequestGrantTypeParam: kRefreshTokenGrantType,
                             kLoginResponseRefreshToken: [JNKeychain loadValueForKey:kLoginResponseRefreshToken]};
    
    void (^successBlock)(id) = ^(id responseObject) {
        [JNKeychain saveValue:[responseObject objectForKey:kLoginResponseToken] forKey:kLoginResponseToken];
        [JNKeychain saveValue:[responseObject objectForKey:kLoginResponseRefreshToken] forKey:kLoginResponseRefreshToken];
        [JNKeychain saveValue:[responseObject objectForKey:kLoginResponseExpire] forKey:kLoginResponseExpire];
        [JNKeychain saveValue:[NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]] forKey:kCurrentSystemTime];
        if (requestBlock != nil) {
            requestBlock();
        }
    };
    
    [dummyNetworking postRequest:kRequestTypeRefreshToken withParams:params withFailureBlock:nil withSuccesBlock:successBlock];
}

+ (void)checkShouldRefreshAndRefreshSession:(void (^)(void))requestBlock{
    if (isFetchingRefresh > 0) return;
    if ([JNKeychain loadValueForKey:kLoginResponseToken] == nil) return;
    isFetchingRefresh++;
    double currentTime = [[NSDate date] timeIntervalSince1970];
    double lastTimeGotToken = [[JNKeychain loadValueForKey:kCurrentSystemTime] doubleValue];
    double secondsTillExpire = [[JNKeychain loadValueForKey:kLoginResponseExpire] doubleValue];
    double willExpireAt = lastTimeGotToken + secondsTillExpire;
    if (currentTime >= willExpireAt) {
        [self refreshUserSession:requestBlock];
    } else if (requestBlock != nil) {
        requestBlock();
    }
    isFetchingRefresh--;
}

+ (NSString *)getUserSessionToken {
    return [JNKeychain loadValueForKey:kLoginResponseToken];
}

@end
