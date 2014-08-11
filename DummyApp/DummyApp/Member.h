//
//  Member.h
//  DummyApp
//
//  Created by Arvin Rezvanpour on 2014-07-13.
//  Copyright (c) 2014 Arvin Rezvanpour. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Member : NSObject

@property NSString *url;
@property NSString *username;
@property NSString *firstName;
@property NSString *avatarUrl;
@property UIImage *avatar;



@end

/* A host/member/attendie response json

 {
 
 "url": "https://tools.elkyr.com/api/smak/users/siamak/",
 
 "username": "siamak",
 
 "first_name": "",
 
 "avatar": "https://elkyrtools-storage.s3.amazonaws.com/media/avatars/fda54e5db8594357bf644f74fee5f93b.png?Signature=ByuTgHLMWP%2Fu7vogZuX3MJv9BAw%3D&Expires=1405239491&AWSAccessKeyId=AKIAINKEOXIDRPSO3N2A"
 
 }
 
*/