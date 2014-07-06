//
//  UserHomeViewController.m
//  DummyApp
//
//  Created by Arvin Rezvanpour on 2014-06-07.
//  Copyright (c) 2014 Arvin Rezvanpour. All rights reserved.
//

#import "UserHomeViewController.h"
#include "Screen2A.h"
#include "Screen2B.h"
#include "Screen3.h"

@interface UserHomeViewController ()


@end

@implementation UserHomeViewController

@synthesize textFieldJSON;
@synthesize jsonMsg;
@synthesize bottomTabBar;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.bottomTabBar setDelegate:self];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [textFieldJSON setText:jsonMsg];
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationItem setHidesBackButton:YES animated:NO];
    [self.navigationItem setTitle:@"Screen1"];
    [self.bottomTabBar setDelegate:self];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if(item.tag==0)
    {
        Screen2A* s2a = [[Screen2A alloc] init];
        [self.navigationController pushViewController:s2a animated:YES];
    }
    else if (item.tag==1)
    {
        Screen2B* s2b = [[Screen2B alloc] init];
        [self.navigationController pushViewController:s2b animated:YES];
    } else {
        
        UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Screen3"
                                                      bundle:nil];
        UIViewController* s3 = [sb instantiateViewControllerWithIdentifier:@"Screen3"];
        
        [self.navigationController pushViewController:s3 animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
