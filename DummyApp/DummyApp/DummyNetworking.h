//
//  DummyNetworking.h
//  DummyApp
//
//  Created by Arvin Rezvanpour on 2014-06-06.
//  Copyright (c) 2014 Arvin Rezvanpour. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "constants.h"

@protocol RequestFinishedDelegate;
@class DummyNetworking;

@interface DummyNetworking : NSObject

@property (nonatomic, weak) id<RequestFinishedDelegate> delegate;

- (void)getRequest:(NSString *)requestType withParams:(NSDictionary *)params withFailureBlock:(void (^)(void))failureBlock withSuccesBlock:(void (^)(id))successBlock;
- (void)postRequest:(NSString *)requestType withParams:(NSDictionary *)params withFailureBlock:(void (^)(void))failureBlock
    withSuccesBlock:(void (^)(id))successBlock;

@end


@protocol RequestFinishedDelegate <NSObject>

- (void)requestDidFinish:(DummyNetworking *)viewController response:(id)responseObject forRequestType:(NSString *)requestType;

@end