//
//  SignupViewController.h
//  BirKelimeBirIslem
//
//  Created by tkiziloren on 06.01.2013.
//
//

#import <UIKit/UIKit.h>
#import "SignupTableViewController.h"

@class SignupViewController;

@protocol SignupViewControllerDelegate <NSObject>

- (void)refreshUserInfoForSignup;

@end

@interface SignupViewController : UIViewController{

    SignupTableViewController * signupForm;
}

@property (nonatomic, weak) id <SignupViewControllerDelegate> delegate;
@property(nonatomic, strong) SignupTableViewController *signupForm;


-(IBAction)signUp:(id)sender;


@end
