//
//  JSONObjectify.m
//  DummyApp
//
//  Created by Arvin Rezvanpour on 2014-07-13.
//  Copyright (c) 2014 Arvin Rezvanpour. All rights reserved.
//

#import "JSONObjectify.h"
#import "constants.h"
#import "Event.h"
#import "Member.h"
#import "UIImageView+AFNetworking.h"


@implementation JSONObjectify

+ (NSArray *)makeObject:(id)response forRequestType:(NSString *)requestType {
    if ([requestType isEqualToString:kRequestTypeEvent]) {
        return [self makeEvents:response];
    }
    return nil;
}

+ (NSArray *)makeEvents:(id)response {

    NSMutableArray *array = [NSMutableArray array];
    
    NSUInteger size = [response count];
    
    for (int i=0; i<size; i++) {
        Event *event = [[Event alloc] init];
        
        event.name = [[response objectAtIndex:i] objectForKey:kEventName];
        event.eventId = [[[response objectAtIndex:i] objectForKey:kEventId] intValue];
        event.url = [[response objectAtIndex:i] objectForKey:kEventUrl];
        event.start_time = [[response objectAtIndex:i] objectForKey:kEventStartTime];
        event.end_time = [[response objectAtIndex:i] objectForKey:kEventEndTime];
        event.location_lat = [[[response objectAtIndex:i] objectForKey:kEventLocationLat] doubleValue];
        event.location_long = [[[response objectAtIndex:i] objectForKey:kEventLocationlong] doubleValue];
        event.upvotes = [[[response objectAtIndex:i] objectForKey:kEventUpvotes] intValue];
        event.downvotes = [[[response objectAtIndex:i] objectForKey:kEventDownvotes] intValue];
        Member *host = [[Member alloc] init];
        host.url = [[[response objectAtIndex:i] objectForKey:kEventHost] objectForKey:kMemberUrl];
        host.username = [[[response objectAtIndex:i] objectForKey:kEventHost] objectForKey:kMemberUsername];
        host.firstName = [[[response objectAtIndex:i] objectForKey:kEventHost] objectForKey:kMemberFirstName];
        host.avatarUrl = [[[response objectAtIndex:i] objectForKey:kEventHost] objectForKey:kMemberAvatarUrl];

        event.host = host;
        event.tags = [[response objectAtIndex:i] objectForKey:kEventTags];
        
        event.attendees = nil;
        event.address = nil;
        event.description = nil;
        
        [array addObject:event];
    }
    
    
    return array;
}


@end
