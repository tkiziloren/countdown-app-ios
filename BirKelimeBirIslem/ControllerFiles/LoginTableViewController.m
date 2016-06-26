//
// Created by tkiziloren on 06.01.2013.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "LoginTableViewController.h"


@implementation LoginTableViewController {

}
@synthesize textFieldUserName;
@synthesize textFieldPassword;

-(void)viewDidLoad{
    [super viewDidLoad];
    textFieldUserName.delegate = self;
    textFieldPassword.delegate = self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

@end