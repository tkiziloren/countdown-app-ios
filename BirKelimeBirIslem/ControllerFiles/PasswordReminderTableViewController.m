//
//  PasswordReminderTableViewController.m
//  BirKelimeBirIslem
//
//  Created by tkiziloren on 06.01.2013.
//
//

#import "PasswordReminderTableViewController.h"

@interface PasswordReminderTableViewController ()

@end

@implementation PasswordReminderTableViewController
@synthesize textFieldUserName;
@synthesize textFieldUserEmail;


-(void)viewDidLoad{
    [super viewDidLoad];
    textFieldUserEmail.delegate = self;
    textFieldUserName.delegate = self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}


@end
