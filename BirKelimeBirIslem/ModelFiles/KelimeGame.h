//
//  KelimeGame.h
//  BirKelimeBirIslem
//
//  Created by Tevfik Kızılören on 8/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSMutableArray+Shuffling.h"
#import "Playable.h"
#import "Game.h"

@interface KelimeGame : Game<Playable>{
    int remainingTime;
    int calculatedPoints;
    NSString* serverResult;
    NSMutableString* word;
    NSMutableArray* charArray;
    NSMutableArray* pressedButtons;
}

@property(nonatomic, assign) int remainingTime;
@property(nonatomic, copy) NSMutableString* word;
@property(nonatomic, copy) NSMutableArray* charArray;
@property(nonatomic, copy) NSMutableArray* arrayOfIndexOfPressedButtons;
@property(nonatomic) int calculatedPoints;
@property(nonatomic, copy) NSString *serverResult;


-(void)prepareForNewGame;
-(void)prepareRandomChars;
-(void)clearWord;
-(void)getBack;

-(int) calculatePoints;

- (NSString *)showCalculatedPointsAsText;
@end
