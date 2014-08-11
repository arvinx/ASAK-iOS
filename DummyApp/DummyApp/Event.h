//
//  Event.h
//  DummyApp
//
//  Created by Arvin Rezvanpour on 2014-06-15.
//  Copyright (c) 2014 Arvin Rezvanpour. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Member.h"

@interface Event : NSObject

#pragma mark BASIC
@property int eventId;
@property NSString *name;
@property NSString *url;
@property Member *host;
@property NSString *start_time;
@property NSString *end_time;
@property double location_lat;
@property double location_long;
@property NSArray *tags; //NSString array
@property int upvotes;
@property int downvotes;

#pragma mark DETAILS
@property NSString *description;
@property NSString *address;
@property NSArray *attendees; //list of Member objects

#pragma mark DEPRECATED
//@property NSString *snippit;
//@property NSString *date;
//@property NSNumber *longitude;
//@property NSNumber *latitude;
//@property UIImage *imageHost;



//@property UIImage *imageHost;

@end

/* an event response

 {
 
 "url": "https://tools.elkyr.com/api/smak/events/4/",
 
 "id": 4,
 
 "name": "gh",
 
 "host": {
 
 "url": "https://tools.elkyr.com/api/smak/users/siamak/",
 
 "username": "siamak",
 
 "first_name": "",
 
 "avatar": "https://elkyrtools-storage.s3.amazonaws.com/media/avatars/fda54e5db8594357bf644f74fee5f93b.png?Signature=ByuTgHLMWP%2Fu7vogZuX3MJv9BAw%3D&Expires=1405239491&AWSAccessKeyId=AKIAINKEOXIDRPSO3N2A"
 
 },
 
 "start_time": "2013-02-04T06:33:00Z",
 
 "end_time": "2013-02-04T08:33:00Z",
 
 "location_lat": "43.663847",
 
 "location_long": "-79.394612",
 
 "address": "hart house",
 
 "description": "killa",
 
 "tags": [
 
 "dutty",
 
 "gal",
 
 "yas"
 
 ],
 
 "upvotes": 0,
 
 "downvotes": 0,
 
 "attendees": [
 
 {
 
 "url": "https://tools.elkyr.com/api/smak/users/admin/",
 
 "username": "admin",
 
 "first_name": "",
 
 "avatar": "https://elkyrtools-storage.s3.amazonaws.com/media/avatars/12093_10200302436917340_675009596_n.jpg?Signature=mauHt9HrcfSpx38RQ3aEuD6VRcA%3D&Expires=1405239491&AWSAccessKeyId=AKIAINKEOXIDRPSO3N2A"
 
 },
 
 {
 
 "url": "https://tools.elkyr.com/api/smak/users/siamak/",
 
 "username": "siamak",
 
 "first_name": "",
 
 "avatar": "https://elkyrtools-storage.s3.amazonaws.com/media/avatars/fda54e5db8594357bf644f74fee5f93b.png?Signature=ByuTgHLMWP%2Fu7vogZuX3MJv9BAw%3D&Expires=1405239491&AWSAccessKeyId=AKIAINKEOXIDRPSO3N2A"
 
 }
 
 ]
 
 }

*/