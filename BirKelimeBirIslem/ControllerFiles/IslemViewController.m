//
//  IslemViewController.m
//  BirKelimeBirIslem
//
//  Created by Tevfik Kızılören on 5/27/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "IslemViewController.h"
#import "GameUtility.h"

@implementation IslemViewController
@synthesize game, timer, usedButtons;
@synthesize labelTargetNumber, labelRemainingTime, labelCurrentOperation, labelPastOperations;
@synthesize button1, button2, button3, button4, button5, button6;
@synthesize buttonTopla, buttonCikar, buttonCarp, buttonBol;
@synthesize buttonSifirla, buttonTemizle, buttonBasla, buttonGeriAl, buttonOnayla;

const int numberOfNumberButtons = 6;

-(void)viewDidLoad{
    [super viewDidLoad];    
    [self clearUserInterface];
    [self prepareAlertViewBeforeBack];
}

-(void) clearUserInterface{
    [self initializeButtonTags];
    [self clearControls];
    [self prepareColors];
}

-(IBAction)basla:(id)sender {
    [self clearUserInterface];
    [self prepareForBasla];    
}

-(IBAction)temizle:(id)sender {
    
    [game.currentOperation clear];
    labelCurrentOperation.text = @"";
    
    for(int i = 0; i<game.currentArray.count; i++){
        int number = [(game.currentArray)[i] intValue];
        [[self obtainNumberButtonWithTag:i] setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        [self changeTextOfNumberButton:i withNumber:number];
        [self changeStateOfNumberButton:i withState:YES];
        [self changeVisibilityOfNumberbutton:i withState:YES];
    }
    
    for(int i = game.currentArray.count; i< numberOfNumberButtons; i++){
        [self changeTextOfNumberButton:i withString:@""];
        [self changeVisibilityOfNumberbutton:i withState:NO];
    }
    
    if(usedButtons != nil)
        [usedButtons removeAllObjects];
    
}

-(IBAction)geriAl:(id)sender {
    [game.currentOperation clear];
    labelCurrentOperation.text = @"";
    [self prepareForPreviousOperation];
}

-(IBAction)sifirla:(id)sender {
    
    [game reset];
    
    labelPastOperations.text = @"";
    labelCurrentOperation.text = @"";
    
    for(int i = 0; i<game.currentArray.count; i++){
        int number = [(game.currentArray)[i] intValue];
        [[self obtainNumberButtonWithTag:i] setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        [self changeTextOfNumberButton:i withNumber:number];
        [[self obtainNumberButtonWithTag:i] useBlackStyle];
        [self changeStateOfNumberButton:i withState:YES];
        [self changeVisibilityOfNumberbutton:i withState:YES];
    }
    
    for(int i = game.currentArray.count; i< numberOfNumberButtons; i++){
        [self changeTextOfNumberButton:i withString:@""];
        [self changeVisibilityOfNumberbutton:i withState:NO];
    }
    
    if(usedButtons != nil)
        [usedButtons removeAllObjects];
    
}

-(IBAction)onayla:(id)sender{
    
    if(game == nil || [game started] == NO){
        return;
    }
        
    
    int points = [game calculateBasePoints];
    if(points > 0){
        [self showResults];
        
    }
    
    
}

-(IBAction)rakamSec:(UIButton*)sender{
    
    if(game == nil || game.started == NO)
        return;
    
    if(usedButtons == nil)
        usedButtons = [NSMutableSet new];

    int tag = sender.tag;
    int operand = [(game.currentArray)[tag] intValue];
    
    /* 
     index degişkeni inject edilen operand'ın ilk mi ikinci mi olduğu bilgisini tutar
     Eğer ikinci operand ise işlem sonucunun doğruluğunu teyit etmemiz lazım. 
     Örneğin işlem sonucu negatifse(çıkarma) veya küsüratlıysa(bölme) işlemi dikkate almıyoruz. 
     */
    int index = [[game currentOperation] injectOperand:operand];

    
    // Butonlara 2 defa tıklanırsa dikkate almıyoruz
    if([usedButtons containsObject:@(tag)]){
        return;
    }
    
    // Yukarıda elde edilen index değişkeni 2. operandı belirtiyorsa ve işlemde hata varsa
    // usedbuttons set'ini güncelliyoruz
    if(!(index == 2 && [game.currentOperation performOperation] == -1))
    {
        for(id number in usedButtons){
            [self changeStateOfNumberButton:((NSNumber*)number).intValue withState:YES];
        }        
        [usedButtons removeAllObjects];
        [self changeStateOfNumberButton:tag withState:NO];
        [usedButtons addObject:@(tag)];
    }

    NSString* textToBeShown = [game.currentOperation obtainResultText];

    if(textToBeShown == nil)
    {
        textToBeShown = [game.currentOperation obtainPartialResultText];
        [labelCurrentOperation setText:textToBeShown];
    }
    else
    {
        // yapilan islemin sonucu dogrulandi
        [usedButtons removeAllObjects];
        usedButtons = nil;
        
        [labelCurrentOperation setText:textToBeShown];
        if([game isTargetNumberReached] == YES){
            // json string'ini doğru bir şekilde elde edebilmek için son işlem sonucunu ekleyelim
            [game nextOperation];
            [self showResults];    
        }
        else{     
            [self prepareForNextOperation];        
        }
    }
}




-(IBAction)islemSec:(UIButton*)sender{

    if(game == nil || game.started == NO)
        return;
    
    NSString *buttonText = sender.titleLabel.text;
    Operations operation = -1;
    			
    if([buttonText isEqualToString:@"+"])
        operation = addition;
    
    if([buttonText isEqualToString:@"-"])
        operation = substraction;
    
    if([buttonText isEqualToString:@"x"])
        operation = multiplication;
    
    if([buttonText isEqualToString:@"÷"])
        operation = division;
    
   
    if(game.islemArray != nil && game.islemArray.count > 0 && game.currentOperation.firstNumber < 0){
        int tag= [game findIndexOfLatestResult];
        int operand = [(game.currentArray)[tag] intValue];
        [[game currentOperation] injectOperand:operand];
        [self changeStateOfNumberButton:tag withState:NO];
        
        if(usedButtons == nil)
            usedButtons = [NSMutableSet new];
        
        [usedButtons addObject:@(tag)];
    }
    
    
    [[game currentOperation] injectOperation:operation];
    NSString* textToBeShown = [game.currentOperation obtainPartialResultText];
    if(textToBeShown != nil)
        [labelCurrentOperation setText:textToBeShown];
    
}

-(void) prepareForBasla{
    
    
    if(game != nil){
        [game endGame];
        game = nil;
    }
    
    game = [IslemGame new];
    
    [game startGame];
    
    int targetNumber = game.targetNumber;
    [labelTargetNumber setText:[IslemUtility convertNumberToString:targetNumber]];
    
    
    for(int i = 0; i<numberOfNumberButtons; i++){
        int number = [(game.currentArray)[i] intValue];
        [self changeTextOfNumberButton:i withNumber:number];
        [self changeStateOfNumberButton:i withState:YES];
    }
    
    [self changeStateOfOperationButtons:YES];
    

    [buttonSifirla setEnabled:YES];
    [buttonTemizle setEnabled:YES];
    [buttonGeriAl setEnabled:YES];
    [buttonOnayla setEnabled:YES];
    [buttonBasla setEnabled:NO];

    
    labelRemainingTime.text = [NSString stringWithFormat:@"%d", [game remainingTime]];
    timer = [NSTimer scheduledTimerWithTimeInterval:(1.0/1.0) target:self selector:@selector(updateRemainingTimeLabel) userInfo:nil repeats:YES];
    
}

-(void) prepareForNextOperation{
   
    [game nextOperation];
    
    for(int i = 0; i<game.currentArray.count; i++){
        int number = [(game.currentArray)[i] intValue];
        [[self obtainNumberButtonWithTag:i] useBlackStyle];
        [[self obtainNumberButtonWithTag:i] setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        [self changeTextOfNumberButton:i withNumber:number];
        [self changeStateOfNumberButton:i withState:YES];
        [self changeVisibilityOfNumberbutton:i withState:YES];
    }
    
    for(int i = game.currentArray.count; i< numberOfNumberButtons; i++){
        [self changeTextOfNumberButton:i withString:@""];
        [self changeVisibilityOfNumberbutton:i withState:NO];
    }

    [self colorizeLatestResultButton];
    labelPastOperations.text = [NSString stringWithFormat:@"%@\n\n\n\n\n", [game obtainPastOperationsAsDelimitedText:@"\n"]];
}


-(void) prepareForPreviousOperation{
    
    [game previousOperation];
    
    for(int i = 0; i<game.currentArray.count; i++){
        int number = [(game.currentArray)[i] intValue];
        [[self obtainNumberButtonWithTag:i] useBlackStyle];
        [[self obtainNumberButtonWithTag:i] setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        [self changeTextOfNumberButton:i withNumber:number];
        [self changeStateOfNumberButton:i withState:YES];
        [self changeVisibilityOfNumberbutton:i withState:YES];
    }
    
    for(int i = game.currentArray.count; i< numberOfNumberButtons; i++){
        [self changeTextOfNumberButton:i withString:@""];
        [self changeVisibilityOfNumberbutton:i withState:NO];
    }
    
    [self colorizeLatestResultButton];
    labelPastOperations.text = [NSString stringWithFormat:@"%@\n\n\n\n\n", [game obtainPastOperationsAsDelimitedText:@"\n"]];
}


-(void) colorizeLatestResultButton{
    if(game == nil || game.islemArray == nil || game.islemArray.count == 0)
        return;
    
    int index = [game findIndexOfLatestResult];
    [[self obtainNumberButtonWithTag:index] useRedDeleteStyle];
}

-(void) initializeButtonTags{
    [button1 setTag:0];
    [button2 setTag:1];
    [button3 setTag:2];
    [button4 setTag:3];
    [button5 setTag:4];
    [button6 setTag:5];
}

-(void) clearControls{
    
    [labelTargetNumber setText:@""];
    [labelRemainingTime setText:@""];
    [labelCurrentOperation setText:@""];
    [labelPastOperations setText:@""];
//    
//    CGSize textSize = [labelPastOperations.text sizeWithFont:labelPastOperations.font constrainedToSize:CGSizeMake(labelPastOperations.frame.size.width, MAXFLOAT) lineBreakMode:labelPastOperations.lineBreakMode];
//    labelPastOperations.frame = CGRectMake(20.0f, 20.0f, textSize.width, textSize.height);
    
    for(int i = 0; i<numberOfNumberButtons; i++){
        [self changeTextOfNumberButton:i withString:@""];
        [self changeStateOfNumberButton:i withState:NO];
        [self changeVisibilityOfNumberbutton:i withState:YES];
    }
    [self changeStateOfOperationButtons:NO];
    
    [buttonBasla setEnabled:YES];
    [buttonSifirla setEnabled:NO];
    [buttonTemizle setEnabled:NO];
    [buttonGeriAl setEnabled:NO];
    [buttonOnayla setEnabled:NO];
    
}

-(void) prepareColors{
    
    for(int i = 0; i<numberOfNumberButtons; i++){
        [[self obtainNumberButtonWithTag:i] useBlackStyle];
        [[self obtainNumberButtonWithTag:i] setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    }
    [buttonCarp useSimpleOrangeStyle];
    [buttonBol useSimpleOrangeStyle];
    [buttonTopla  useSimpleOrangeStyle];
    [buttonCikar useSimpleOrangeStyle];
 
    [buttonTemizle useWhiteStyle];
    [buttonBasla useWhiteStyle];
    [buttonGeriAl useWhiteStyle];
    [buttonSifirla useRedDeleteStyle];
    [buttonOnayla useGreenConfirmStyle];

    [buttonBasla setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [buttonTemizle setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [buttonGeriAl setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [buttonOnayla setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
    [buttonSifirla setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];


}

-(void) changeStateOfOperationButtons:(BOOL)state{
    
    buttonTopla.enabled = state;
    buttonCarp.enabled = state;
    buttonCikar.enabled = state;
    buttonBol.enabled = state;
}

-(GradientButton*) obtainNumberButtonWithTag:(int) buttonTag{
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
        default:
            return nil;
    }
}

-(void) changeStateOfNumberButton:(int) buttonTag withState:(BOOL) enabled{
    [[self obtainNumberButtonWithTag:buttonTag] setEnabled:enabled];
}

-(void) changeVisibilityOfNumberbutton:(int) buttonTag withState:(BOOL) state{
    [[self obtainNumberButtonWithTag:buttonTag] setHidden:!(state)];
}

-(void) changeTextOfNumberButton:(int) buttonTag withNumber:(int) number{
    [[self obtainNumberButtonWithTag:buttonTag] setTitle:[IslemUtility convertNumberToString:number] forState:UIControlStateNormal];
    [[self obtainNumberButtonWithTag:buttonTag] setTitle:[IslemUtility convertNumberToString:number] forState:UIControlStateHighlighted];
}

-(void) changeTextOfNumberButton:(int) buttonTag withString:(NSString*) str{
    [[self obtainNumberButtonWithTag:buttonTag] setTitle:str forState:UIControlStateNormal];
    [[self obtainNumberButtonWithTag:buttonTag] setTitle:str forState:UIControlStateHighlighted];
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
        [game encyptAndPostResultsForUser];
        [game endGame];
    }
    
    game = nil;
    
    if(timer != nil)
        [timer invalidate];


}

-(void)confirmExit {
    UIAlertView *alert = [[UIAlertView alloc] init];
    alert.tag = ALERT_CIKIS;
	[alert setTitle:@"Onayla"];
	[alert setMessage:@"Çıkmak istediğinize emin misiniz?"];
	[alert setDelegate:self];
	[alert addButtonWithTitle:@"Evet"];
	[alert addButtonWithTitle:@"Hayır"];
	[alert show];
}

-(void) updateRemainingTimeLabel{
    game.remainingTime--;
    NSLog(@"%i", [game remainingTime]);
    
    if(game.remainingTime == 0){
        [timer invalidate];
        timer = nil;
        
        UIAlertView *alert = [[UIAlertView alloc] 
                              initWithTitle:@"Uyarı" 
                              message:@"Süre bitti!" 
                              delegate:self 
                              cancelButtonTitle:nil
                              otherButtonTitles:@"OK", nil];
        alert.cancelButtonIndex = 1;
        alert.tag = ALERT_SURE_BITTI;
        [alert show];
    }
    labelRemainingTime.text = [NSString stringWithFormat:@"%d", [game remainingTime]];
}

-(void) showResults{
    
    [timer invalidate];
    timer = nil;
    
    UIAlertView *alert = [[UIAlertView alloc] 
                              initWithTitle:@"Tebrikler" 
                              message:[game showCalculatedPointsAsText]
                              delegate:self 
                              cancelButtonTitle:nil
                              otherButtonTitles:@"OK", nil];
    
    alert.cancelButtonIndex = 1;
    alert.tag = ALERT_DOGRU_SONUC;
    [alert show];
}


-(void)viewDidUnload{
    [super viewDidUnload];
    [self setButtonBasla:nil];
    [self setButtonSifirla:nil];
    [self setButtonTemizle:nil];
    [self setButtonGeriAl:nil];
    [self setButtonOnayla:nil];
    
    labelTargetNumber = nil;
    [self setLabelTargetNumber:nil];
  
    self.button1 = nil;
    self.button2 = nil;
    self.button3 = nil;
    self.button4 = nil;
    self.button5 = nil;
    self.button6 = nil;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}


@end
