//
//  NavBarViewController.m
//  DummyApp
//
//  Created by Arvin Rezvanpour on 2014-06-07.
//  Copyright (c) 2014 Arvin Rezvanpour. All rights reserved.
//

#import "NavBarViewController.h"

@interface NavBarViewController ()

@end

@implementation NavBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"Hello Title"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
