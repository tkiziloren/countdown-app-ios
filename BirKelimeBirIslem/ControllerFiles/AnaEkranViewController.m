//
//  AnaEkranViewController.m
//  BirKelimeBirIslem
//
//  Created by Tevfik Kızılören on 5/27/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "AnaEkranViewController.h"
#import "IslemViewController.h"
#import "KelimeViewController.h"

@implementation AnaEkranViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    /*
    
    if ([segue.identifier isEqualToString:@"IslemScene"]) {
        IslemViewController *islemVC = [segue destinationViewController];
    }
        
    if([segue.identifier isEqualToString:@"KelimeScene"]){
        KelimeViewController *kelimeVC = [segue destinationViewController];
    }
      */  
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

- (IBAction)startNumberGame:(id)sender{
    //[self performSegueWithIdentifier:@"IslemScene" sender:sender];
}

- (IBAction)startWordGame:(id)sender{
    //[self performSegueWithIdentifier:@"KelimeScene" sender:sender];
}

- (IBAction)showStats:(id)sender {

}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    //NSLog(@"%@", user.username);
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
