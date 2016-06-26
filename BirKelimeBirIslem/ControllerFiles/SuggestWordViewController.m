//
// Created by tkiziloren on 14.01.2013.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "SuggestWordViewController.h"
#import "ServerInformer.h"


@implementation SuggestWordViewController{

}

- (IBAction)suggestWord {

    [self.view endEditing:YES];
    if (self.validateWord == NO){
        return;
    }


    NSString *username = [GameUtility readUserName];
    [self suggestWord:textFieldSuggestedWord.text forUser:username];

}

-(void)suggestWord:(NSString *) word forUser:(NSString *)username{

    ServerResponse * serverResponse = [ServerInformer suggestWord:word forUsername:username];

    NSString *checkResult = serverResponse.getResponseDetails;
    if ([GameUtility isOK:checkResult])
        [GameUtility notifyUser:NOTIFY_SUCCESS message:@"Önerdiğiniz kelime başarıyla kaydedildi!"];
    else
        [GameUtility showAlertView:checkResult];

}

-(void)viewDidLoad{
    [super viewDidLoad];
    textFieldSuggestedWord.delegate = self;
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

- (void)viewDidUnload {
    textFieldSuggestedWord = nil;
    [super viewDidUnload];
}

-(BOOL)validateWord{


    NSString *validateResult = [GameUtility validateSuggestedWord:textFieldSuggestedWord.text];
    if ([GameUtility isOK:validateResult] == NO){
        [GameUtility showAlertView:validateResult];
        return NO;
    }

    return YES;


}
@end