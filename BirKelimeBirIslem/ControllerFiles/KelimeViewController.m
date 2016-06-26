//
//  KelimeViewController.m
//  BirKelimeBirIslem
//
//  Created by Tevfik Kızılören on 8/4/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "KelimeViewController.h"
#import "GameUtility.h"

@implementation KelimeViewController
@synthesize game, timer;
@synthesize labelRemainingTime, labelWord;
@synthesize button1, button2, button3, button4, button5, button6, button7, button8, button9;
@synthesize buttonTemizle, buttonBasla, buttonGeriAl, buttonOnayla;

const int numberOfAlphabetButtons = 9;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self clearUserInterface];
    [self prepareAlertViewBeforeBack];
    
}

-(void) clearUserInterface{
    
    [self initializeButtonTags];
    [self clearControls];
    [self prepareColors];

}

-(IBAction)basla:(id)sender{
    
    [self clearUserInterface];
    game = [KelimeGame new];
    [game startGame];
    
    [labelWord setText:@""];
    
    for(int i = 0; i<numberOfAlphabetButtons; i++){
        [self changeStateOfButton:i withState:YES];
        [self changeTextOfButton:i withString:[game charArray][i]];
    }

    
    [buttonBasla setEnabled:NO];
    [buttonTemizle setEnabled:YES];
    [buttonGeriAl setEnabled:YES];
    [buttonOnayla setEnabled:YES];
    labelRemainingTime.text = [NSString stringWithFormat:@"%d", [game remainingTime]];

    timer = [NSTimer scheduledTimerWithTimeInterval:(1.0/1.0) target:self selector:@selector(updateRemainingTimeLabel) userInfo:nil repeats:YES];

    
}

-(void) updateRemainingTimeLabel{
    game.remainingTime--;
    NSLog(@"%i", [game remainingTime]);
    
    if(game.remainingTime == 0){
        [timer invalidate];
        UIAlertView *alert = [[UIAlertView alloc] 
                              initWithTitle:@"Uyarı" 
                              message:@"Süre bitti!" 
                              delegate:self 
                              cancelButtonTitle:nil
                              otherButtonTitles:@"OK", nil];
        alert.cancelButtonIndex = 1;
        alert.tag = 2;
        [alert show];   
    }
    labelRemainingTime.text = [NSString stringWithFormat:@"%d", [game remainingTime]];
}


-(IBAction)karakterSec:(UIButton*)sender{
    
    if(game == nil || game.started == NO)
        return;
    
    [[game word] appendString:[[sender titleLabel] text]];
    labelWord.text =  [game word];
    [[game arrayOfIndexOfPressedButtons] addObject:@(sender.tag)];        
    [self changeStateOfButton:sender.tag withState:NO];
}

-(IBAction)geriAl:(id)sender{
   
    if(game == nil 
       || game.started == NO 
       || game.arrayOfIndexOfPressedButtons == nil 
       || game.arrayOfIndexOfPressedButtons.count == 0)
    {
        return;
    }
        
    NSNumber* lastIndex = (NSNumber*)[[game arrayOfIndexOfPressedButtons] lastObject];
    [self changeStateOfButton:lastIndex.intValue withState:YES];
    [game getBack];
    labelWord.text = [game word];
    
    
}

-(IBAction)temizle:(id)sender{

    if(game == nil)
        return;
    
    [game clearWord];
    [labelWord setText:@""];
    [[game arrayOfIndexOfPressedButtons] removeAllObjects];
    for(int i = 0; i<numberOfAlphabetButtons; i++){
        [self changeStateOfButton:i withState:YES];
    }
    
}

-(IBAction)onayla:(id)sender
{

    if(game == nil || [game started] == NO){
        return;
    }

    if (game.word == nil || game.word.length < 3){
        return;
    }

    int points = [game calculatePoints];

    NSString *header = points > 0 ?  @"Tebrikler" : @"Bilgi";
    [self showResults:header];
}

- (void)showResults:(NSString *)header {

    [timer invalidate];
    timer = nil;

    UIAlertView *alert = [[UIAlertView alloc]
            initWithTitle:header
                  message:[game showCalculatedPointsAsText]
                 delegate:self
        cancelButtonTitle:nil
        otherButtonTitles:@"OK", nil];

    alert.cancelButtonIndex = 1;
    alert.tag = ALERT_DOGRU_SONUC;
    [alert show];
}


-(void) initializeButtonTags{
    [button1 setTag:0];
    [button2 setTag:1];
    [button3 setTag:2];
    [button4 setTag:3];
    [button5 setTag:4];
    [button6 setTag:5];
    [button7 setTag:6];
    [button8 setTag:7];
    [button9 setTag:8];
}

-(void) clearControls{
    [labelWord setText:@""];
    [labelRemainingTime setText:@""];
    for(int i = 0; i<numberOfAlphabetButtons; i++){
        [self changeTextOfButton:i withString:@"-"];
        [self changeStateOfButton:i withState:NO];
        [self changeVisibilityOfButton:i withState:YES];
    }

    [buttonBasla setEnabled:YES];
    [buttonTemizle setEnabled:NO];
    [buttonGeriAl setEnabled:NO];
    [buttonOnayla setEnabled:NO];


}

-(void) prepareColors{
    [buttonTemizle useWhiteStyle];
    [buttonBasla useWhiteStyle];
    [buttonGeriAl useWhiteStyle];
    [buttonOnayla useGreenConfirmStyle];
    
    [buttonBasla setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [buttonTemizle setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [buttonGeriAl setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [buttonOnayla setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
}


-(UIButton*) obtainNumberButtonWithTag:(int) buttonTag{
    switch(buttonTag){
        case 0:
            return button1;            
        case 1:
            return button2;            
        case 2:
            return button3;            
        case 3:
            return button4;            
        case 4:
            return button5;            
        case 5:
            return button6;            
        case 6:
            return button7;            
        case 7:
            return button8;            
        case 8:
            return button9;            
        default:
            return nil;
    }
}

-(void) changeStateOfButton:(int) buttonTag withState:(BOOL) enabled{
    [[self obtainNumberButtonWithTag:buttonTag] setEnabled:enabled];
    if(enabled == YES)
        [[self obtainNumberButtonWithTag:buttonTag] setAlpha:0.9];
    else
        [[self obtainNumberButtonWithTag:buttonTag] setAlpha:0.4];

}

-(void) changeTextOfButton:(int) buttonTag withString:(NSString*) str{
    [[self obtainNumberButtonWithTag:buttonTag] setTitle:str forState:UIControlStateNormal];
    [[self obtainNumberButtonWithTag:buttonTag] setTitle:str forState:UIControlStateHighlighted];
    
}

-(void) changeVisibilityOfButton:(int) buttonTag withState:(BOOL) state{
    [[self obtainNumberButtonWithTag:buttonTag] setHidden: !(state)];
    
}



-(void) prepareAlertViewBeforeBack{   
    UIButton* backButton = [UIButton buttonWithType:101]; 
    [backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setTitle:@"Geri" forState:UIControlStateNormal];
    UIBarButtonItem* backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;    
}
-(void)backButtonPressed:(id)sender {
    if(game != nil && game.started == YES){
        [self confirmExit];
    }
    else
        [[self navigationController] popViewControllerAnimated:YES];
    
}

-(void)confirmExit {
    UIAlertView *alert = [[UIAlertView alloc] init];
    alert.tag = 1;
	[alert setTitle:@"Onayla"];
	[alert setMessage:@"Çıkmak istediğinize emin misiniz?"];
	[alert setDelegate:self];
	[alert addButtonWithTitle:@"Evet"];
	[alert addButtonWithTitle:@"Hayır"];
	[alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    // cikmak istiyor musunuz sorusuna hayir cevabini vermis ise oyunu devam ettirelim
    if (alertView.tag == ALERT_CIKIS && buttonIndex != 0){
        return;
    }

    if (alertView.tag == ALERT_CIKIS && buttonIndex == 0){
        [self clearUserInterface];
        [[self navigationController] popViewControllerAnimated:YES];

    }

    if(alertView.tag == ALERT_SURE_BITTI && buttonIndex == 0){
        [self clearUserInterface];
    }

    if(alertView.tag == ALERT_DOGRU_SONUC && buttonIndex == 0){
        [self clearUserInterface];
    }

    if(game.started){
        [game endGame];
    }

    game = nil;

    if(timer != nil)
        [timer invalidate];

}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
