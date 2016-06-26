//
//  IslemUtility.m
//  BirKelimeBirIslem
//
//  Created by Tevfik Kızılören on 5/31/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "IslemUtility.h"

@implementation IslemUtility

+(int) getTargetNumber:(Levels) level{
    int targetNumber = [self generateRandomNumber:1000];
    switch (level) {
        case easy:
            while (targetNumber < 250 || targetNumber % 2 == 1) {
                targetNumber = [self generateRandomNumber:600];
            }
            break;
        case medium:
            while(targetNumber < 250){
                targetNumber = [self generateRandomNumber:1000];
            }
            break; 
        case hard:
            while (targetNumber < 500 || targetNumber % 2 == 0) {
                targetNumber = [self generateRandomNumber:1000];
            }
            break;
        default:
            break;
    }
    return targetNumber;    
}


+(int) getNumber{
    return  [self generateRandomNumber:10];
}

+(int) getLastNumber{
    int size = 9;
    int lastNumber[] = {25,30,40,50,60,75,80,100};
    int index = [self generateRandomNumber:size];
    NSLog(@"index:%d", index);
    return lastNumber[index -1];        
}

+(NSString*) convertNumberToString:(int) number{
    return [NSString stringWithFormat:@"%i",number];
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

+(int) generateRandomNumber:(int)maximum{
    return arc4random()%(maximum-1) + 1;
}
@end
