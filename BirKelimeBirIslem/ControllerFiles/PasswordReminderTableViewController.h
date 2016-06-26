//
//  PasswordReminderTableViewController.h
//  BirKelimeBirIslem
//
//  Created by tkiziloren on 06.01.2013.
//
//

#import <UIKit/UIKit.h>

@interface PasswordReminderTableViewController : UITableViewController<UITextFieldDelegate>{
    IBOutlet UITextField *textFieldUserName;
    IBOutlet UITextField *textFieldUserEmail;
}
@property(nonatomic, strong) UITextField *textFieldUserName;
@property(nonatomic, strong) UITextField *textFieldUserEmail;


@end

