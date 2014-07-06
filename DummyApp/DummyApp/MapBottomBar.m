//
//  MapBottomBar.m
//  DummyApp
//
//  Created by Arvin Rezvanpour on 2014-06-21.
//  Copyright (c) 2014 Arvin Rezvanpour. All rights reserved.
//

#import "MapBottomBar.h"

@implementation MapBottomBar
@synthesize imageUser;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        imageUser.contentMode = UIViewContentModeScaleAspectFit;
        imageUser.clipsToBounds = YES;

    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
