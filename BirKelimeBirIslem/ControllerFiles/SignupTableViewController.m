//
//  SignupTableViewController.m
//  BirKelimeBirIslem
//
//  Created by tkiziloren on 06.01.2013.
//
//

#import "SignupTableViewController.h"

@interface SignupTableViewController ()

@end

@implementation SignupTableViewController
@synthesize textFieldUserName;
@synthesize textFieldPassword1;
@synthesize textFieldPassword2;
@synthesize textFieldUserEmail;;

-(void)viewDidLoad{
    [super viewDidLoad];
    textFieldUserEmail.delegate = self;
    textFieldUserName.delegate = self;
    textFieldPassword1.delegate = self;
    textFieldPassword2.delegate = self;


}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}


@end
