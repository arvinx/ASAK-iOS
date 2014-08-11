//
//  JSONObjectify.h
//  DummyApp
//
//  Created by Arvin Rezvanpour on 2014-07-13.
//  Copyright (c) 2014 Arvin Rezvanpour. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONObjectify : NSObject

+ (NSArray *)makeObject:(id)response forRequestType:(NSString *)requestType;

@end
