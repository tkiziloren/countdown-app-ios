//
//  LoginViewController.m
//  BirKelimeBirIslem
//
//  Created by Tevfik Kızılören on 5/25/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"
#import "ServerInformer.h"

@implementation LoginViewController
@synthesize loginTableViewController;
@synthesize user;


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

-(IBAction)login:(id)sender {

    /* Oyuna giriş yaparken kullanıcının olup olmadığını ve girilen kullanıcı adının geçerli olup olmadığını kontrol et. */

    self.user.username = loginTableViewController.textFieldUserName.text;
    self.user.password = loginTableViewController.textFieldPassword.text;
    self.user.email = [GameUtility readEmail];

    // genel login validasyonu;
    NSString *validateResult = [[self user] validateForLogin];
    if (![GameUtility isOK:validateResult]) {
        [GameUtility showAlertView:validateResult];
        return;
    }

    ServerResponse *serverResponse = [ServerInformer loginUser:user];
    NSString *checkResult = serverResponse.getResponseDetails;

    if ([GameUtility isOK:checkResult]) {
        [self.user writeToPropertyFile];
    }
    else {
        if([serverResponse.responseCode.stringValue isEqualToString:Constants.instance.RESULT_LOGIN_FAIL])
            [self showAlertViewWithTwoOption:checkResult];
        else
            [GameUtility showAlertView:checkResult];

        return;
    }
    // AnaEkran isimli sahneyi açalım.
    [self performSegueWithIdentifier:@"AnaEkran" sender:self];
}

- (void)showAlertViewWithTwoOption:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc]
            initWithTitle:@"Uyarı"
                  message:message
                 delegate:self
        cancelButtonTitle:@"Hayır"
        otherButtonTitles:@"Evet", nil];
    alert.tag = YES_NO;
    [alert show];
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    // sifresini hatirlamiyorsa
    if (alertView.tag == YES_NO && buttonIndex == 1)
        [self showAlertViewPasswordRemind:@"Kullanıcı adı veya e-mail:"];

    // kullanici adi veya email adresi basit validasyon kurallarina uymuyorsa
    if (alertView.tag == SIMPLE_ALERT_AFTER_PASSWORD_REMIND)
        [self showAlertViewPasswordRemind:@"Kullanıcı adı veya e-mail:"];

    if (alertView.tag == PASSWORD_REMIND && buttonIndex == 1){
        User *temp = [User new] ;
        temp.username = [alertView textFieldAtIndex:0].text;
        temp.email = [alertView textFieldAtIndex:1].text;;

        NSString *validateResult = temp.validateForRemindPassword;

        // kullaniciyi uyaralim ve tekrar hatirlatma kutucugunu acalim
        if (![GameUtility isOK:validateResult]){
            [self showAlertView:validateResult withTag:SIMPLE_ALERT_AFTER_PASSWORD_REMIND];
            return;
        }
        [self passwordRemindForUsername:temp.username andEmail:temp.email];
    }
}

-(void)showAlertView:(NSString*) message withTag:(NSUInteger) tag{
    UIAlertView *alert = [[UIAlertView alloc]
            initWithTitle:@"Uyarı"
                  message:message
                 delegate:self
        cancelButtonTitle:nil
        otherButtonTitles:@"OK", nil];
    alert.cancelButtonIndex = 1;
    alert.tag =tag;

    [alert show];
}

- (void)showAlertViewPasswordRemind:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc]
            initWithTitle:@"Uyarı"
                  message:message
                 delegate:self
        cancelButtonTitle:@"Hayır"
        otherButtonTitles:@"Evet", nil];
    alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    alert.tag = PASSWORD_REMIND;

    [alert textFieldAtIndex:0].text = user.username;
    [alert textFieldAtIndex:1].text = user.email;

    [[alert textFieldAtIndex:1] setSecureTextEntry:NO];
    [[alert textFieldAtIndex:0] setPlaceholder:@"Kullanıcı Adı"];
    [[alert textFieldAtIndex:1] setPlaceholder:@"E-mail"];
    [[alert textFieldAtIndex:1] setKeyboardType:UIKeyboardTypeEmailAddress];
    [alert show];
    //label.frame  = CGRectMake(label.frame.origin.x,label.frame.origin.y, label.frame.size.width, label.frame.size.height * 2);

}

- (void)refreshUserInfoForSignup{

    [GameUtility logString:@"Burdayim"];
    [self prepareForFirstView];

}
#pragma mark - View lifecycle

- (void)viewDidLoad
{

    [super viewDidLoad];
    [self prepareForFirstView];

}

- (IBAction)signup:(id)sender {
    // KayitEkrani isimli sahneyi açalım.
    [self performSegueWithIdentifier:@"KayitEkrani" sender:self];

}

-(void)passwordRemindForUsername:(NSString *)username andEmail:(NSString *)email{
    ServerResponse * response = [ServerInformer passwordRemindForUserName:username andOrEmail:email];
    if ([GameUtility isOK:response.getResponseDetails])
    {
        [GameUtility showAlertView:@"Yeni şifreniz kayıtlı olan email adresinizie gönderildi!"];
    }

    if ([GameUtility isNotEmptyString:username])
        self.user.username = username;
    else
        self.user.username = @"";

    if ([GameUtility validateEmail:email])
        self.user.email = email;


    self.user.password = @"";
    [self.user writeToPropertyFile];
    [self refreshUserInfoForSignup];

}


-(void) prepareForSegue:(UIStoryboardPopoverSegue *)segue sender:(id)sender
{
//    // veri taşımak için bunu kullan
//    if ([segue.destinationViewController isKindOfClass:[SignupViewController class]]) {
//        SignupViewController *yeniKontroller = (SignupViewController *) segue.destinationViewController;
//    }

    if ([segue.destinationViewController isKindOfClass:[SignupViewController class]]) {
        SignupViewController *yeniKontroller = (SignupViewController *) segue.destinationViewController;
        yeniKontroller.delegate = self;
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(void)prepareForFirstView {
    [GameUtility checkPropertyFile];
    self.loginTableViewController = (LoginTableViewController *)[self.childViewControllers objectAtIndex:0];

    if (self.user == nil)
        self.user = [User new];
    else
        [user fillFromOPropertyFile];

    loginTableViewController.textFieldUserName.text = user.username;
    loginTableViewController.textFieldPassword.text = user.password;
}

@end
