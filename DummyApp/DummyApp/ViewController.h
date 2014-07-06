//
//  ViewController.h
//  DummyApp
//
//  Created by Arvin Rezvanpour on 2014-06-06.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DummyNetworking.h"

@interface ViewController : UIViewController <RequestFinishedDelegate>
@property (weak, nonatomic) IBOutlet UILabel* Title;
@property (weak, nonatomic) IBOutlet UIButton *TopButton;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *buttonLogIn;

- (IBAction)TopButtonTouchUp:(id)sender;
- (IBAction)textFieldReturn:(id)sender;
- (IBAction)passwordTextFieldReturn:(id)sender;
- (IBAction)logInButtonTouchUp:(id)sender;


@end
