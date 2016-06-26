//
//  IslemGame.h
//  BirKelimeBirIslem
//
//  Created by Tevfik Kızılören on 5/31/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Islem.h"
#import "SBJsonWriter.h"
#import "IslemUtility.h"
#import "NSString+AES.h"
#import "NSData+AES.h"
#import "Base64.h"
#import "Constants.h"
#import "GameUtility.h"
#import "ServerInformer.h"
#import "Playable.h"
#import "Game.h"

@interface IslemGame : Game<Playable>{
    int targetNumber;
    int remainingTime;
    NSMutableArray* startArray;
    NSMutableArray* currentArray;
    NSMutableArray* islemArray;
    Islem* currentOperation;
}


@property(nonatomic, assign) int targetNumber;
@property(nonatomic, assign) int remainingTime;
@property(nonatomic, copy) NSMutableArray* startArray;
@property(nonatomic, copy) NSMutableArray* currentArray;
@property(nonatomic, copy) NSMutableArray* islemArray;
@property(nonatomic, strong) Islem* currentOperation;

-(int)findFirstIndexOfObject:(NSNumber*) object;
-(void)nextOperation;
-(void)previousOperation;
-(NSString*)obtainPastOperationsAsDelimitedText:(NSString*)delimiter;
-(int)findIndexOfLatestResult;
-(BOOL)isTargetNumberReached;
-(int)calculateBasePoints;
-(NSString*)showCalculatedPointsAsText;
-(int)obtainResultOfLastOperation;



@end
