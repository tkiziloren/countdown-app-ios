//
//  SignupTableViewController.h
//  BirKelimeBirIslem
//
//  Created by tkiziloren on 06.01.2013.
//
//

#import <UIKit/UIKit.h>


@interface SignupTableViewController : UITableViewController<UITextFieldDelegate>{

    IBOutlet UITextField *textFieldUserName;
    IBOutlet UITextField *textFieldUserEmail;
    IBOutlet UITextField *textFieldPassword1;
    IBOutlet UITextField *textFieldPassword2;

}
@property(nonatomic, strong) UITextField *textFieldUserName;
@property(nonatomic, strong) UITextField *textFieldUserEmail;
@property(nonatomic, strong) UITextField *textFieldPassword1;
@property(nonatomic, strong) UITextField *textFieldPassword2;


@end