//
//  SignupViewController.m
//  BirKelimeBirIslem
//
//  Created by tkiziloren on 06.01.2013.
//
//

#import "SignupViewController.h"
#import "User.h"
#import "ServerInformer.h"

@interface SignupViewController ()

@end

@implementation SignupViewController
@synthesize signupForm;


- (IBAction)signUp:(id)sender {

    User* user = [[User alloc] initWithEmptyData];

    user.username = signupForm.textFieldUserName.text;
    user.email = signupForm.textFieldUserEmail.text;
    user.password = signupForm.textFieldPassword1.text;
    user.password1 = signupForm.textFieldPassword2.text;

    // genel login validasyonu;
    NSString *validateResult = [user validateForSignup];
    if ([validateResult isEqualToString:[[Constants instance] DEFAULT_INTERNAL_STRING_SUCCESS_RESPONSE]] == NO) {
        [GameUtility showAlertView:validateResult];
        return;
    }

    ServerResponse *serverResponse = [ServerInformer signupUser:user];
    NSString *checkResult = serverResponse.getResponseDetails;

    if ([Constants.instance.DEFAULT_INTERNAL_STRING_SUCCESS_RESPONSE isEqualToString:checkResult]) {
        [user writeToPropertyFile];
        [GameUtility showAlertView:@"Kullanıcı bilgileri başarıyla tanımlandı."];
        [self.delegate refreshUserInfoForSignup];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        [GameUtility showAlertView:checkResult];
        return;
    }

}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self prepareForFirstView];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForFirstView {
    self.signupForm = (SignupTableViewController *)[self.childViewControllers objectAtIndex:0];
}


@end
