//
// Created by tkiziloren on 14.01.2013.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <UIKit/UIKit.h>
#import "User.h"
@interface SuggestWordViewController : UIViewController<UITextFieldDelegate>{
    
    
    __weak IBOutlet UITextField *textFieldSuggestedWord;
    
}


- (IBAction)suggestWord;

@end