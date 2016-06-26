//
//  PasswordReminderViewController.h
//  BirKelimeBirIslem
//
//  Created by tkiziloren on 06.01.2013.
//
//

#import <UIKit/UIKit.h>
#import "PasswordReminderTableViewController.h"
@interface PasswordReminderViewController : UIViewController{
    PasswordReminderTableViewController *passwordReminderForm;
}
@property(nonatomic, strong) PasswordReminderTableViewController *passwordReminderForm;


-(IBAction)remindPassword:(id)sender;


@end
