//
// Created by tevfik on 29.12.2012.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "Game.h"


@implementation Game {

}
@synthesize started;


-(void)startGame{
    started = YES;
}

-(void)endGame{
    started = NO;
}


- (void)reset {

}


@end