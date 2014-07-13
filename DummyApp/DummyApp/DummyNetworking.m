//
//  DummyNetworking.m
//  DummyApp
//
//  Created by Arvin Rezvanpour on 2014-06-06.
//  Copyright (c) 2014 Arvin Rezvanpour. All rights reserved.
//

#import "DummyNetworking.h"
#import "UserSessionManager.h"
#import "AFNetworking.h"

/*
 CACHE POLICIES
 
 UseProtocolCachePolicy                         Default behavior
 ReloadIgnoringLocalCacheData                   Don't use the cache
 ReloadIgnoringLocalAndRemoteCacheData          ---Seriously, don't use the cache
 ReturnCacheDataElseLoad                        Use the cache (no matter how out of date), or if no cached response exists, load from the network
 ReturnCacheDataDontLoad                        Offline mode: use the cache (no matter how out of date), but don't load from the network
 ReloadRevalidatingCacheData                    ---Validate cache against server before using
 
*/

@implementation DummyNetworking


- (void)getRequest:(NSString *)requestType withParams:(NSDictionary *)params withFailureBlock:(void (^)(void))failureBlock withSuccesBlock:(void (^)(id))successBlock {

    [UserSessionManager checkShouldRefreshAndRefreshSession];
    
    NSString *url = nil;
    if ([requestType isEqualToString:kRequestTypeEvent]) {
        url = [NSString stringWithFormat:@"%@%@", kBaseURL, kEndpointEvent];
    }

    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager manager] initWithBaseURL:[NSURL URLWithString:kBaseURL]];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", [UserSessionManager getUserSessionToken]] forHTTPHeaderField:kHeaderAuth];
    [manager.requestSerializer setCachePolicy:NSURLRequestUseProtocolCachePolicy];
    [manager.requestSerializer setTimeoutInterval:20.0];
    
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        id<RequestFinishedDelegate> strongDelegate = self.delegate;
        
        if ([strongDelegate respondsToSelector:@selector(requestDidFinish:response:forRequestType:)]) {
            [strongDelegate requestDidFinish:self response:responseObject forRequestType:requestType];
        }
        
        if (successBlock != nil) {
            successBlock(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
        if (failureBlock != nil) {
            failureBlock();
        }
    }];

}

- (void)postRequest:(NSString *)requestType withParams:(NSDictionary *)params withFailureBlock:(void (^)(void))failureBlock withSuccesBlock:(void (^)(id))successBlock {
    [UserSessionManager checkShouldRefreshAndRefreshSession];
    
    NSString *url = nil;
    if ([requestType isEqualToString:kRequestTypeLogin]) {
        url = [NSString stringWithFormat:@"%@%@", kBaseURL, kLoginEndpoint];
    } else if([requestType isEqualToString:kRequestTypeRefreshToken]) {
        url = [NSString stringWithFormat:@"%@%@", kBaseURL, kEndpointRefreshToken];
    }
    
    
    NSMutableDictionary *paramsWithClientId = [NSMutableDictionary dictionaryWithDictionary:params];
    [paramsWithClientId setObject:kClientId forKey:kClientIdKey];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    [manager POST:url parameters:paramsWithClientId success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        id<RequestFinishedDelegate> strongDelegate = self.delegate;
        
        if ([strongDelegate respondsToSelector:@selector(requestDidFinish:response:forRequestType:)]) {
            [strongDelegate requestDidFinish:self response:responseObject forRequestType:kRequestTypeLogin];
        }
        
        if (successBlock != nil) {
            successBlock(responseObject);
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
        if (failureBlock != nil) {
            failureBlock();
        }
    }];
    
}

@end
