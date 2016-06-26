//
//  KelimeViewController.h
//  BirKelimeBirIslem
//
//  Created by Tevfik Kızılören on 8/4/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KelimeGame.h"
#import "GradientButton.h"

@interface KelimeViewController : UIViewController{

    KelimeGame* game;
    NSTimer* timer;
    UILabel* labelRemainingTime;
    UILabel* labelWord;
    UIButton* button1;
    UIButton* button2;
    UIButton* button3;
    UIButton* button4;
    UIButton* button5;
    UIButton* button6;
    UIButton* button7;
    UIButton* button8;
    UIButton* button9;

    GradientButton* buttonBasla;
    GradientButton* buttonGeriAl;
    GradientButton* buttonTemizle;
    GradientButton* buttonOnayla;
}

@property (strong) NSTimer* timer;
@property (strong, nonatomic) KelimeGame *game;

@property (strong, nonatomic) IBOutlet UILabel *labelRemainingTime;
@property (strong, nonatomic) IBOutlet UILabel *labelWord;


@property (strong, nonatomic) IBOutlet UIButton *button1;
@property (strong, nonatomic) IBOutlet UIButton *button2;
@property (strong, nonatomic) IBOutlet UIButton *button3;
@property (strong, nonatomic) IBOutlet UIButton *button4;
@property (strong, nonatomic) IBOutlet UIButton *button5;
@property (strong, nonatomic) IBOutlet UIButton *button6;
@property (strong, nonatomic) IBOutlet UIButton *button7;
@property (strong, nonatomic) IBOutlet UIButton *button8;
@property (strong, nonatomic) IBOutlet UIButton *button9;


@property (strong, nonatomic) IBOutlet GradientButton *buttonTemizle;
@property (strong, nonatomic) IBOutlet GradientButton *buttonBasla;
@property (strong, nonatomic) IBOutlet GradientButton *buttonGeriAl;
@property (strong, nonatomic) IBOutlet GradientButton *buttonOnayla;



-(IBAction)basla:(id)sender;
-(IBAction)geriAl:(id)sender;
-(IBAction)temizle:(id)sender;
-(IBAction)onayla:(id)sender;

-(IBAction)karakterSec:(UIButton*)sender;

-(void) clearUserInterface;
-(void) prepareAlertViewBeforeBack;
-(void) initializeButtonTags;
-(void) clearControls;
-(void) confirmExit;
-(void) prepareColors;

-(void) changeStateOfButton:(int) buttonTag withState:(BOOL) enabled;
-(void) changeTextOfButton:(int) buttonTag withString:(NSString*) str;
-(void) changeVisibilityOfButton:(int) buttonTag withState:(BOOL) state;




@end
