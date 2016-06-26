//
// Created by tevfik on 29.12.2012.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface Game : NSObject  {
    BOOL started;
}

@property(nonatomic, assign) BOOL started;

-(void)startGame;
-(void)endGame;
-(void)reset;

@end