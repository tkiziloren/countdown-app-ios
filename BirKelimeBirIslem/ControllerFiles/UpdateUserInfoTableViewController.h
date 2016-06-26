//
//  UpdateUserInfoTableViewController.h
//  BirKelimeBirIslem
//
//  Created by tkiziloren on 20.01.2013.
//
//

#import <UIKit/UIKit.h>

@interface UpdateUserInfoTableViewController: UITableViewController<UITextFieldDelegate>{
    
    IBOutlet UITextField *textFieldOldPassword;
    IBOutlet UITextField *textFieldUserEmail;
    IBOutlet UITextField *textFieldUserEmail2;
    IBOutlet UITextField *textFieldPassword;
    IBOutlet UITextField *textFieldPassword2;
    
    
}
@property(nonatomic, strong) UITextField *textFieldOldPassword;
@property(nonatomic, strong) UITextField *textFieldUserEmail;
@property(nonatomic, strong) UITextField *textFieldUserEmail2;
@property(nonatomic, strong) UITextField *textFieldPassword;
@property(nonatomic, strong) UITextField *textFieldPassword2;



@end
