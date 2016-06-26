//
// Created by tkiziloren on 06.01.2013.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface LoginTableViewController : UITableViewController<UITextFieldDelegate>  {

    IBOutlet UITextField *textFieldUserName;
    IBOutlet UITextField *textFieldPassword;
}
@property(nonatomic, strong) UITextField *textFieldUserName;
@property(nonatomic, strong) UITextField *textFieldPassword;


@end