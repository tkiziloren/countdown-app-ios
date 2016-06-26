//
//  LoginViewController.h
//  BirKelimeBirIslem
//
//  Created by Tevfik Kızılören on 5/25/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginTableViewController.h"
#import "User.h"
#import "SignupViewController.h"
#import "PasswordReminderViewController.h"


typedef enum {
    SIMPLE, YES_NO, PASSWORD_REMIND, SIMPLE_ALERT_AFTER_PASSWORD_REMIND
}ALERT_TAGS;


@interface LoginViewController : UIViewController<SignupViewControllerDelegate, UIAlertViewDelegate>
{
    LoginTableViewController *loginTableViewController;
    User* user;

}

@property(nonatomic, strong) LoginTableViewController *loginTableViewController;
@property(nonatomic, strong) User *user;


-(void) prepareForFirstView;
-(IBAction)login:(id)sender;
-(IBAction)signup:(id)sender;
-(void)passwordRemindForUsername:(NSString *)username andEmail:(NSString *)email;


	
@end


