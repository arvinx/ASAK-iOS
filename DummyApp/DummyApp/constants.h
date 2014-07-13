//
//  constants.h
//  DummyApp
//
//  Created by Arvin Rezvanpour on 2014-07-04.
//  Copyright (c) 2014 Arvin Rezvanpour. All rights reserved.
//

#ifndef DummyApp_constants_h
#define DummyApp_constants_h

#define kKeyChainId                             @"ASAK-token"

#define kHeaderAuth                             @"Authorization"
#define kClientIdKey                            @"client_id"
#define kClientId                               @"jsotKeCi-Xu4xHz9ax8uQlhKmtWB4xTKhn1xyer-"
#define kBaseURL                                @"https://tools.elkyr.com"
#define kLoginEndpoint                          @"/o/token/"
#define kEndpointRefreshToken                   @"/o/token/"
#define kEndpointEvent                          @"/api/smak/events/"


#define kRequestTypeLogin                       @"kRequestTypeLogin"
#define kRequestTypeRefreshToken                @"kRequestTypeRefreshToken"

//login
#define kLoginRequestParamUsername              @"username"
#define kLoginRequestParamPassword              @"password"
#define kLoginRequestGrantTypeParam             @"grant_type"
#define kLoginRequestGrantType                  @"password"
#define kRefreshTokenGrantType                  @"refresh_token"

#define kLoginResponseToken                     @"access_token"
#define kLoginResponseExpire                    @"expires_in"
#define kLoginResponseRefreshToken              @"refresh_token"

#define kCurrentSystemTime                      @"kCurrentSystemTime"

//events
#define kRequestTypeEvent                       @"kRequestTypeEvent"
#define kEventName                              @"name"
#define kEventUrl                               @"url"
#define kEventId                                @"id"
#define kEventStartTime                         @"start_time"
#define kEventEndTime                           @"end_time"
#define kEventLocationLat                       @"location_lat"
#define kEventLocationlong                      @"location_long"
#define kEventAddress                           @"address"
#define kEventDescription                       @"description"
#define kEventTags                              @"tags"
#define kEventHost                              @"host"
#define kEventUpvotes                           @"upvotes"
#define kEventDownvotes                         @"downvotes"
#define kEventAttendees                         @"attendees"

//member
#define kMemberUrl                              @"url"
#define kMemberUsername                         @"username"
#define kMemberFirstName                        @"first_name"
#define kMemberAvatarUrl                        @"avatar"


#endif
