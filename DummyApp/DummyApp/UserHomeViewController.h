//
//  UserHomeViewController.h
//  DummyApp
//
//  Created by Arvin Rezvanpour on 2014-06-07.
//  Copyright (c) 2014 Arvin Rezvanpour. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserHomeViewController : UIViewController <UITabBarDelegate>

@property NSString* jsonMsg;

@property (weak, nonatomic) IBOutlet UITextView *textFieldJSON;
@property (weak, nonatomic) IBOutlet UIViewController *tabBar;

@property (weak, nonatomic) IBOutlet UITabBarItem *buttonScreen2A;
@property (weak, nonatomic) IBOutlet UITabBarItem *buttonScreen2B;
@property (weak, nonatomic) IBOutlet UITabBarItem *Screen2C;

@property (weak, nonatomic) IBOutlet UITabBar *bottomTabBar;


@end
