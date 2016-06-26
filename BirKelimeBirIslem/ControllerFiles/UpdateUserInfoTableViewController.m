//
//  UpdateUserInfoTableViewController.m
//  BirKelimeBirIslem
//
//  Created by tkiziloren on 20.01.2013.
//
//

#import "UpdateUserInfoTableViewController.h"

@implementation UpdateUserInfoTableViewController
@synthesize textFieldOldPassword;
@synthesize textFieldPassword;
@synthesize textFieldPassword2;
@synthesize textFieldUserEmail;
@synthesize textFieldUserEmail2;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    textFieldUserEmail.delegate = self;
    textFieldUserEmail2.delegate = self;
    textFieldOldPassword.delegate = self;
    textFieldPassword.delegate = self;
    textFieldPassword2.delegate = self;

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self viewDidLoad];
    return NO;
}
//
//- (void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    [self animateTextField: textField up: YES];
//}
//
//
//- (void)textFieldDidEndEditing:(UITextField *)textField
//{
//    [self animateTextField: textField up: NO];
//}
//
//- (void) animateTextField: (UITextField*) textField up: (BOOL) up
//{
//    const int movementDistance = 80; // tweak as needed
//    const float movementDuration = 0.3f; // tweak as needed
//    
//    int movement = (up ? -movementDistance : movementDistance);
//    
//    [UIView beginAnimations: @"anim" context: nil];
//    [UIView setAnimationBeginsFromCurrentState: YES];
//    [UIView setAnimationDuration: movementDuration];
//    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
//    [UIView commitAnimations];
//}
//
@end
