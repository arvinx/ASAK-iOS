//
//  ViewController.m
//  DummyApp
//
//  Created by Arvin Rezvanpour on 2014-06-06.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"
#import "DummyNetworking.h"
#import "UserHomeViewController.h"
#import "Screen2B.h"
#import "NavBarViewController.h"
#import "UserSessionManager.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize Title;
@synthesize TopButton;
@synthesize userNameTextField;
@synthesize passwordTextField;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [Title setText:@"Hello world"];
    [[self navigationController] setNavigationBarHidden:YES];
    
}

- (void)TopButtonTouchUp:(id)sender {
    if ([TopButton isSelected]) {
        [TopButton setSelected:NO];
        [Title setText:@"DAT"];
        
    } else {
        [TopButton setSelected:YES];
        [Title setText:@"ASS"];
    }
}

- (IBAction)textFieldReturn:(id)sender {
    [userNameTextField resignFirstResponder];
}

- (IBAction)passwordTextFieldReturn:(id)sender {
    [passwordTextField resignFirstResponder];
}

- (IBAction)logInButtonTouchUp:(id)sender {
    DummyNetworking *dummyNetwork = [[DummyNetworking alloc] init];
    [dummyNetwork setDelegate:self];
    NSDictionary *params = @{kLoginRequestGrantTypeParam: kLoginRequestGrantType,
                             kLoginRequestParamPassword: [passwordTextField text],
                             kLoginRequestParamUsername: [userNameTextField text]};
    void (^failureBlock)(void) = ^{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Logging In"
                                                            message:@"Username or Password Incorrect"
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    };
    
    [dummyNetwork postRequest:kRequestTypeLogin withParams:params withFailureBlock:failureBlock withSuccesBlock:nil];
}

-(void)dismissKeyboard {
    [userNameTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
}


- (void)requestDidFinish:(DummyNetworking *)viewController response:(id)responseObject forRequestType:(NSString *)requestType {
    /*
     format of response json:
     {"access_token": "hfy0Z0IrtndJIMRAhok5eq7v052zS4", "token_type": "Bearer", "expires_in": 120, "refresh_token": "Sd5KBh4aRw7307FAc1tIxPNC8WhAU5", "scope": "read write"}
     */
    if ([requestType isEqualToString:kRequestTypeLogin]) {
        NSString *token = [responseObject objectForKey:kLoginResponseToken];
        NSString *refreshToken = [responseObject objectForKey:kLoginResponseRefreshToken];
        NSString *expireTime = [responseObject objectForKey:kLoginResponseExpire];
        
        [UserSessionManager createNewUserSession:token withRefreshToken:refreshToken withExpireTime:expireTime];
        
        Screen2B* maps = [[Screen2B alloc] init];
        [self.navigationController pushViewController:maps animated:YES];

    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
