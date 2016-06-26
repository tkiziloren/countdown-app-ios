//
//  IslemViewController.h
//  BirKelimeBirIslem
//
//  Created by Tevfik Kızılören on 5/27/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "User.h"
#import "IslemUtility.h"
#import "GradientButton.h"
#import "IslemGame.h"
@interface IslemViewController : UIViewController{
    
    IslemGame *game;
    UILabel *labelTargetNumber;
    UILabel *labelRemainingTime;
    UILabel *labelCurrentOperation;
    UILabel *labelPastOperations;
    NSTimer *timer;
    NSMutableSet* usedButtons;
    
    GradientButton *button1;
    GradientButton *button2;
    GradientButton *button3;
    GradientButton *button4;
    GradientButton *button5;
    GradientButton *button6;
    GradientButton *buttonTopla;
    GradientButton *buttonCikar;
    GradientButton *buttonCarp;
    GradientButton *buttonBol;    
   
    GradientButton *buttonTemizle;
    GradientButton *buttonSifirla;
    GradientButton *buttonBasla;
    GradientButton *buttonGeriAl;
    GradientButton *buttonOnayla;
}

@property (strong) NSTimer* timer;
@property (strong, nonatomic) IslemGame *game;
@property (strong, nonatomic) NSMutableSet *usedButtons;

@property (strong, nonatomic) IBOutlet UILabel *labelTargetNumber;
@property (strong, nonatomic) IBOutlet UILabel *labelRemainingTime;
@property (strong, nonatomic) IBOutlet UILabel *labelCurrentOperation;
@property (strong, nonatomic) IBOutlet UILabel *labelPastOperations;


@property (strong, nonatomic) IBOutlet GradientButton *button1;
@property (strong, nonatomic) IBOutlet GradientButton *button2;
@property (strong, nonatomic) IBOutlet GradientButton *button3;
@property (strong, nonatomic) IBOutlet GradientButton *button4;
@property (strong, nonatomic) IBOutlet GradientButton *button5;
@property (strong, nonatomic) IBOutlet GradientButton *button6;

@property (strong, nonatomic) IBOutlet GradientButton *buttonSifirla;
@property (strong, nonatomic) IBOutlet GradientButton *buttonTemizle;
@property (strong, nonatomic) IBOutlet GradientButton *buttonBasla;
@property (strong, nonatomic) IBOutlet GradientButton *buttonGeriAl;
@property (strong, nonatomic) IBOutlet GradientButton *buttonOnayla;


@property (strong, nonatomic) IBOutlet GradientButton *buttonTopla;
@property (strong, nonatomic) IBOutlet GradientButton *buttonCikar;
@property (strong, nonatomic) IBOutlet GradientButton *buttonCarp;
@property (strong, nonatomic) IBOutlet GradientButton *buttonBol;


-(IBAction)basla:(id)sender;
-(IBAction)geriAl:(id)sender;
-(IBAction)temizle:(id)sender;
-(IBAction)sifirla:(id)sender;
-(IBAction)onayla:(id)sender;

-(IBAction)rakamSec:(UIButton*)sender;
-(IBAction)islemSec:(UIButton*)sender;


-(void) clearUserInterface;
-(void) prepareForBasla;
-(void) prepareForNextOperation;
-(void) prepareForPreviousOperation;
-(void) prepareColors;
-(void) prepareAlertViewBeforeBack;
-(void) clearControls;
-(void) updateRemainingTimeLabel;
-(void) changeStateOfOperationButtons:(BOOL)state;
-(void) colorizeLatestResultButton;

-(GradientButton*) obtainNumberButtonWithTag:(int) buttonTag;
-(void) initializeButtonTags;
-(void) changeStateOfNumberButton:(int) buttonTag withState:(BOOL) enabled;
-(void) changeTextOfNumberButton:(int) buttonTag withString:(NSString*) str;
-(void) changeTextOfNumberButton:(int) buttonTag withNumber:(int) number;
-(void) changeVisibilityOfNumberbutton:(int) buttonTag withState:(BOOL) state;
-(void) confirmExit;
-(void) showResults;


@end
