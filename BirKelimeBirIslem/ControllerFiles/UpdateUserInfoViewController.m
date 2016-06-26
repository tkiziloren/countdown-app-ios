//
// Created by tkiziloren on 18.01.2013.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "UpdateUserInfoViewController.h"
#import "User.h"
#import "ServerInformer.h"


@implementation UpdateUserInfoViewController
@synthesize emailForm, passwordForm;
@synthesize user;

-(IBAction)updateEmail:(id)sender
{

    if ([emailForm.textFieldUserEmail isEqual:emailForm.textFieldUserEmail2]){
        [GameUtility showAlertView:@"E-mail adresiniz sistemde kayıtlı olan e-mail adresinizden farklı olmalıdır."];
        return;
    }

    user.email = emailForm.textFieldUserEmail2.text;
    NSString *validateResult = [[self user] validateForUpdateEmail];
    if (![GameUtility isOK:validateResult]) {
        [GameUtility showAlertView:validateResult];
        return;
    }

    ServerResponse *serverResponse = [ServerInformer updateUserInfo:user];
    NSString *checkResult = serverResponse.getResponseDetails;

    if ([GameUtility isOK:checkResult]){
        [self.user writeToPropertyFile];
        [GameUtility showAlertView:@"E-mail adresiniz başarıyla güncellendi."];
    }
    else{
        [GameUtility showAlertView:checkResult];
    }

    [self prepareForFirstView];
    [self.navigationController popViewControllerAnimated:YES];


}

-(IBAction)updatePassword:(id)sender{

    if ([user.password isEqualToString:passwordForm.textFieldOldPassword.text] == NO){
        [GameUtility showAlertView:@"Eski şifrenizi yanlış girdiniz. Lütfen kontrol edip tekrar deneyiniz."];
        return;
    }

    if ([user.password isEqualToString:passwordForm.textFieldPassword.text]){
        [GameUtility showAlertView:@"Yeni şifreniz eski şifrenizden farklı bir şifre olmalıdır."];
        return;
    }
    NSString* oldPasswordTemp = user.password;

    user.password = passwordForm.textFieldPassword.text;
    user.password1 = passwordForm.textFieldPassword2.text;

    NSString *validateResult = [[self user] validateForUpdatePassword];
    if (![GameUtility isOK:validateResult]) {
        user.password = oldPasswordTemp;
        [GameUtility showAlertView:validateResult];
        return;
    }

    ServerResponse *serverResponse = [ServerInformer updateUserInfo:user];
    NSString *checkResult = serverResponse.getResponseDetails;

    if ([GameUtility isOK:checkResult]){
        [self.user writeToPropertyFile];
        [GameUtility showAlertView:@"Şifreniz başarıyla güncellendi."];
    }
    else{
        [GameUtility showAlertView:checkResult];
    }

    [self prepareForFirstView];
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self prepareForFirstView];
	// Do any additional setup after loading the view.
}

-(void)prepareForFirstView {
    [GameUtility checkPropertyFile];
    emailForm = (UpdateUserInfoTableViewController *)[self.childViewControllers objectAtIndex:0];
    passwordForm = (UpdateUserInfoTableViewController *)[self.childViewControllers objectAtIndex:1];

    if (user == nil)
        user = [User new];
    else
        [user fillFromOPropertyFile];

    emailForm.textFieldUserEmail.text = user.email;
}


@end