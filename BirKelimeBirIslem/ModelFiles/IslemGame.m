//
//  IslemGame.m
//  BirKelimeBirIslem
//
//  Created by Tevfik Kızılören on 5/31/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "IslemGame.h"


@implementation IslemGame
@synthesize targetNumber, remainingTime;
@synthesize startArray, currentArray, islemArray;
@synthesize currentOperation;
- (id)init
{
    
    self = [super init];
    
    if (self) {
        startArray = [NSMutableArray new];
        currentArray = [NSMutableArray new];
        islemArray = [NSMutableArray new];
        currentOperation = [Islem new];
        [self prepareForNewGame];
    }
    return self;
}


-(void)prepareForNewGame{
    
    self.started = NO;
    self.targetNumber = [IslemUtility getTargetNumber:medium]; 
    self.remainingTime = [GameUtility getRemainingTimeForNumberGame:medium];
    
    
    for(int i = 0; i<5; i++){
        int number = [IslemUtility getNumber];
        while([startArray containsObject:@(number)])
            number = [IslemUtility getNumber];
        
        [startArray addObject:@(number)];
        [currentArray addObject:@(number)];
    }
    
    

    NSLog(@"target number%d", targetNumber);
    for(id number in currentArray){
        NSLog(@"%@", number);
    }

    int lastnumber = [IslemUtility getLastNumber];
//    while(((double)targetNumber/(double)lastnumber) < 15)
//        lastnumber = [IslemUtility getLastNumber];
    
    [startArray addObject:@(lastnumber)];
    [currentArray addObject:@(lastnumber)];

    NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
    [currentArray sortUsingDescriptors:@[lowestToHighest]];   
    [startArray sortUsingDescriptors:@[lowestToHighest]];

}
-(void)reset{
    [currentArray removeAllObjects];
    for(id temp in startArray){
        [currentArray addObject:temp];
    }
    NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
    [currentArray sortUsingDescriptors:@[lowestToHighest]];   

    [islemArray removeAllObjects];    
    [currentOperation clear];
}

-(void) nextOperation{
    int firstNumber = currentOperation.firstNumber;
    int secondNumber = currentOperation.secondNumber;
    int result = currentOperation.result;
    
    int indexOfFirstNumber=[self findFirstIndexOfObject:@(firstNumber)];
    [currentArray removeObjectAtIndex:indexOfFirstNumber];
    int indexOfSecondNumber=[self findFirstIndexOfObject:@(secondNumber)];
    [currentArray removeObjectAtIndex:indexOfSecondNumber];
    
    [currentArray addObject:@(result)];
    
    // sıralayalım
    NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
    [currentArray sortUsingDescriptors:@[lowestToHighest]];    

    //Islemleri ekleyelim
    [islemArray addObject:currentOperation];
    currentOperation = [Islem new];
}


-(void) previousOperation{

    if(islemArray == nil || islemArray.count == 0)
        return;
    
    
    int firstNumber = ((Islem*)islemArray.lastObject).firstNumber;
    int secondNumber = ((Islem*)islemArray.lastObject).secondNumber;
    int result = ((Islem*)islemArray.lastObject).result;
    //Operations operation = ((Islem*)islemArray.lastObject).operation;
    
    int indexOfResult=[self findFirstIndexOfObject:@(result)];
    [currentArray removeObjectAtIndex:indexOfResult];

    [currentArray addObject:@(firstNumber)];
    [currentArray addObject:@(secondNumber)];
    
    // sıralayalım
    NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
    [currentArray sortUsingDescriptors:@[lowestToHighest]];   
    
    [islemArray removeLastObject];
    currentOperation = [Islem new];
    
    [currentOperation clear];

}


-(int)findFirstIndexOfObject:(NSNumber*) object{
    for(int i = 0; i<currentArray.count; i++){
        if(object.intValue == [currentArray[i] intValue])
            return i;
    }
    return -1;
}

-(NSString*)obtainGameNumbersAsDelimitedText:(NSString*) delimiter{
    NSMutableString* result = [NSMutableString stringWithString:@""];
    
    for(int i = 0; i<startArray.count - 1; i++){
        
        [result appendString:[NSString stringWithFormat:@"%i", [(NSNumber*)startArray[i] intValue]]];
        [result appendString:delimiter];        
    }
    
    [result appendString:[NSString stringWithFormat:@"%i", [(NSNumber*)startArray[5] intValue]]];
    
    return result;
}

-(NSString*)obtainPastOperationsAsDelimitedText:(NSString*) delimiter{
    NSMutableString* result = [NSMutableString stringWithString:@""];
    for(int i = 0; i<islemArray.count; i++){
        [result appendString:[islemArray[i] obtainResultText]];
        
        if(i == islemArray.count - 1)
            continue;
        
        [result appendString:delimiter];
       
    }
    return result;
}

-(int)findIndexOfLatestResult{
    int latestResult = ((Islem*)islemArray.lastObject).result;
    return [self findFirstIndexOfObject:@(latestResult)];
}

-(BOOL)isTargetNumberReached{
    return targetNumber == [self obtainResultOfLastOperation];
}

-(int)obtainResultOfLastOperation{
    if(currentOperation.firstNumber == -1 && currentOperation.secondNumber == -1)
    {
        if(islemArray == nil || islemArray.count == 0)
            return -1;        
        
        
        return [(Islem*)[islemArray lastObject] result];
    }
    else{
        return currentOperation.result;
    }
    
}

-(int)calculateBasePoints{
    // Tam  sonuc = 25
    // 1 Yaklasik = 20
    // 2 Yaklasik = 15
    // 3 Yaklasik = 10
    // 4 Yaklasik = 5

    
    if([self isTargetNumberReached] == YES)
        return 40;
    
    int yaklasik = abs(targetNumber - [self obtainResultOfLastOperation]);
    
    switch (yaklasik) {
        case 1:
            return 20;
        case 2:
            return 15;
        case 3:
            return 10;
        case 4:
            return 5;
        default:
            return 0;
    }
}

-(int)calculateTotalPoints{
    int points = [self calculateBasePoints];
    int yaklasik = abs(targetNumber - [self obtainResultOfLastOperation]);
    
    switch (yaklasik) {
        case 0:
            return points + remainingTime;
        case 1:
            return points + (int)round(((double)remainingTime * 0.5));
        case 2:
            return points + (int)round(((double)remainingTime * 0.4));
        case 3:
            return points + (int)round(((double)remainingTime * 0.3));
        case 4:
            return points + (int)round(((double)remainingTime * 0.2));
        default:
            return 0;
            
    }
}


-(NSString*)showCalculatedPointsAsText{
    int points = [self calculateBasePoints];
    int totalPoints = [self calculateTotalPoints];
    
    int yaklasik = abs(targetNumber - [self obtainResultOfLastOperation]);
    
    switch (yaklasik) {
        case 0:
            return [NSString stringWithFormat:@"Tam sonuç buldunuz.\n\nSorudan Kazandığınız Puan: %i\nArtırdığınız Süre: %i\n\nKazandığınız puana artırdığınız süre eklendi. \n\nBu sorudan toplam \n%i + %i = %i\n puan kazandınız.", points, remainingTime, points, remainingTime, totalPoints];
        case 1:
            return [NSString stringWithFormat:@"1 yaklaşık sonuç buldunuz.\n\nSorudan Kazandığınız Puan: %i\nArtırdığınız Süre: %i\n\n Kazandığınız puana artırdığınız sürenin 0.5 katı eklendi.\n\nBu sorudan toplam \n%i + (%i x 0.5) = %i\n puan kazandınız.", points, remainingTime, points, remainingTime, totalPoints];
        case 2:
            return [NSString stringWithFormat:@"2 yaklaşık sonuç buldunuz.\n\nSorudan Kazandığınız Puan: %i\nArtırdığınız Süre: %i\n\n Kazandığınız puana artırdığınız sürenin 0.4 katı eklendi.\n\nBu sorudan toplam \n%i + (%i x 0.4) = %i\n puan kazandınız.", points, remainingTime, points, remainingTime, totalPoints];
        case 3:
            return [NSString stringWithFormat:@"3 yaklaşık sonuç buldunuz.\n\nSorudan Kazandığınız Puan: %i\nArtırdığınız Süre: %i\n\n Kazandığınız puana artırdığınız sürenin 0.3 katı eklendi.\n\nBu sorudan toplam \n%i + (%i x 0.3) = %i\n puan kazandınız.", points, remainingTime, points, remainingTime, totalPoints];
        case 4:
            return [NSString stringWithFormat:@"4 yaklaşık sonuç buldunuz.\n\nSorudan Kazandığınız Puan: %i\nArtırdığınız Süre: %i\n\n Kazandığınız puana artırdığınız sürenin 0.2 katı eklendi.\n\nBu sorudan toplam \n%i + (%i x 0.2) = %i\n puan kazandınız.", points, remainingTime, points, remainingTime, totalPoints];
        default:
           return [NSString stringWithFormat:@"%i yaklasik sonuç buldunuz.\nBu sorudan puan alamadınız", yaklasik]; 
    }
    
}

-(NSDictionary*)obtainGameResults
{

    int totalPoints = [self calculateTotalPoints];

    NSDictionary *dictionary = @{@"username": [GameUtility readUserName],
            @"targetNumber": [NSString stringWithFormat:@"%i", targetNumber],
            @"numbers": [self obtainGameNumbersAsDelimitedText:@","],
            @"operationLog": [self obtainPastOperationsAsDelimitedText:@","],
            @"remainingTime": [NSString stringWithFormat:@"%i", remainingTime],
            @"userresult": [NSString stringWithFormat:@"%i", [self obtainResultOfLastOperation]],
            @"points": [NSString stringWithFormat:@"%i", totalPoints]};

    return dictionary;
}


-(NSString *)obtainGameResultsAsJSONString
{
    return [GameUtility convertDictionaryToJSONString:[self obtainGameResults]];
}


-(BOOL) encyptAndPostResultsForUser{
    ServerResponse *serverResponse = [ServerInformer encryptAndSendNumberGameResults:[self obtainGameResults]];
    return [[[Constants instance] DEFAULT_INTERNAL_STRING_SUCCESS_RESPONSE] isEqualToString:serverResponse.getResponseDetails];
}


@end
