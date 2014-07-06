//
//  DummyNetworking.m
//  DummyApp
//
//  Created by Arvin Rezvanpour on 2014-06-06.
//  Copyright (c) 2014 Arvin Rezvanpour. All rights reserved.
//

#import "DummyNetworking.h"
#import "AFNetworking.h"

@implementation DummyNetworking

static NSString * const BaseURLString = @"http://www.raywenderlich.com/demos/weather_sample/";

- (void)getRequest:(NSString *)notificationReciever {
    NSString *string = [NSString stringWithFormat:@"%@weather.php?format=json", BaseURLString];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        id<RequestFinishedDelegate> strongDelegate = self.delegate;
        
        if ([strongDelegate respondsToSelector:@selector(requestDidFinish:response:forRequestType:)]) {
            [strongDelegate requestDidFinish:self response:responseObject forRequestType:kRequestTypeLogin];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];

    [operation start];
}

- (void)postRequest:(NSString *)requestType withParams:(NSDictionary *)params withFailureBlock:(void (^)(void))failureBlock withSuccesBlock:(void (^)(void))successBlock {
    NSString *url = nil;
    if ([requestType isEqualToString:kRequestTypeLogin]) {
        url = [NSString stringWithFormat:@"%@%@", kBaseURL, kLoginEndpoint];
    }
    
    NSMutableDictionary *paramsWithClientId = [NSMutableDictionary dictionaryWithDictionary:params];
    [paramsWithClientId setObject:kClientId forKey:kClientIdKey];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:url parameters:paramsWithClientId success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        id<RequestFinishedDelegate> strongDelegate = self.delegate;
        
        if ([strongDelegate respondsToSelector:@selector(requestDidFinish:response:forRequestType:)]) {
            [strongDelegate requestDidFinish:self response:responseObject forRequestType:kRequestTypeLogin];
        }
        
        successBlock();

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);

        failureBlock();
    }];
    
}

@end
