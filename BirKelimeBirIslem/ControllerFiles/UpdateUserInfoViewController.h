//
// Created by tkiziloren on 18.01.2013.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "UpdateUserInfoTableViewController.h"
#import "User.h"


@interface UpdateUserInfoViewController : UIViewController<UIAlertViewDelegate,UITextFieldDelegate>{


}

@property(nonatomic, strong) UpdateUserInfoTableViewController *emailForm;
@property(nonatomic, strong) UpdateUserInfoTableViewController *passwordForm;
@property(nonatomic, strong) User *user;

-(IBAction)updateEmail:(id)sender;
-(IBAction)updatePassword:(id)sender;

@end