//
//  KelimeGame.m
//  BirKelimeBirIslem
//
//  Created by Tevfik Kızılören on 8/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "KelimeGame.h"
#import "GameUtility.h"
#import "ServerInformer.h"

@implementation KelimeGame
@synthesize remainingTime, word, charArray, arrayOfIndexOfPressedButtons;
@synthesize calculatedPoints;
@synthesize serverResult;


- (id)init {
    self = [super init];
    if (self) {
        word = [NSMutableString new];
        serverResult = [NSMutableString new];
        charArray = [NSMutableArray new];
        arrayOfIndexOfPressedButtons = [NSMutableArray new];
        calculatedPoints = -1;
    }

    return self;
}


- (void)prepareForNewGame {

    [self clearWord];
    [self prepareRandomChars];
    [[self arrayOfIndexOfPressedButtons] removeAllObjects];
    self.remainingTime = [GameUtility getRemainingTimeForWordGame:medium];
    self.calculatedPoints = -1;

}

- (void)clearWord {
    [word setString:@""];
}

- (void)prepareRandomChars {
    [[self charArray] removeAllObjects];

    for (int i = 0; i < 3; i++)
        [charArray addObject:[GameUtility getRandomVowel]];

    for (int i = 0; i < 5; i++)
        [charArray addObject:[GameUtility getRandomConsonant]];

    [charArray shuffle];
    [charArray addObject:@"?"];

}

- (void)getBack {

    if (self.word != nil && self.word.length > 0) {
        [self.word deleteCharactersInRange:NSMakeRange(self.word.length - 1, 1)];
        [self.arrayOfIndexOfPressedButtons removeLastObject];
    }
}

- (void)startGame {
    [self prepareForNewGame];
    [super startGame];

}

-(int)calculateBasePoints {

    if (word == nil || word.length < 3)
        return -1;


    ServerResponse *serverResponse = [ServerInformer checkForWordGameAnswer:[self obtainGameResults]];
    if (![[[Constants instance] DEFAULT_INTERNAL_STRING_SUCCESS_RESPONSE] isEqualToString: serverResponse.getResponseDetails])
        return -1;

    self.serverResult = serverResponse.getFoundedWordForActionCheckForWord;
    return word.length * 10;
}

-(int) calculatePoints{

    calculatedPoints = [self calculateBasePoints];
    return calculatedPoints;

}

- (NSDictionary*)obtainGameResults {

    NSMutableString *question = [NSMutableString new];

    for (NSString *str in charArray)
        [question appendString:str];

    NSDictionary *dictionary = @{@"username": [GameUtility readUserName],
            @"question": question,
            @"answer": word,
            @"remainingTime": [NSString stringWithFormat:@"%i", remainingTime]
    };

   return dictionary;
}

-(int)calculateTotalPoints {
    BOOL jokerDurum = [GameUtility isJokerCharacterUsedFor:word];
    int gamePoints = jokerDurum ? calculatedPoints + (int)round(((double)remainingTime * 0.5)) : calculatedPoints + remainingTime;
    return gamePoints;
}

-(NSString *)obtainGameResultsAsJSONString
{
    return [GameUtility convertDictionaryToJSONString:[self obtainGameResults]];
}

- (BOOL)encyptAndPostResultsForUser {
    ServerResponse *serverResponse = [ServerInformer encryptAndSendNumberGameResults:[self obtainGameResults]];
    return [Constants.instance.DEFAULT_INTERNAL_STRING_SUCCESS_RESPONSE isEqualToString:serverResponse.getResponseDetails];
}

- (NSString *)showCalculatedPointsAsText{

    if (serverResult == nil || calculatedPoints <= 0){
        return @"Bu sorudan puan alamadınız!";
    }

    NSMutableString *resultText = [NSMutableString new];
    BOOL jokerDurum = [GameUtility isJokerCharacterUsedFor:word];

    NSString *strJokerDurum = jokerDurum ? @"(Jokerli)" : @"(Jokersiz)";
    NSString *strEklenenPuan = jokerDurum ? @"yarısı" : @"tamamı";

    [resultText appendString:@"Buldugunuz Kelime:"];
    [resultText appendString:[self word]];
    [resultText appendString:@"\nSunucudaki Kelime:"];
    [resultText appendString:[self serverResult]];
    [resultText appendString:@"\n\nKazandığınız Puan:"];
    [resultText appendString:[NSString stringWithFormat:@"%i ", calculatedPoints]];
    [resultText appendString:strJokerDurum];
    [resultText appendString:@"\nArtırdığınız Süre:"];
    [resultText appendString:[NSString stringWithFormat:@"%i ", remainingTime]];
    [resultText appendString:[NSString stringWithFormat:@"\n\nKazandığınız puana artırdığınız sürenin %@ eklendi.", strEklenenPuan]];


    int gamePoints = [self calculateTotalPoints];

    if (jokerDurum)
        [resultText appendString:[NSString stringWithFormat:@"\n\nBu sorudan toplam %i + (%i x 0.5) = %i puan kazandınız.", calculatedPoints, remainingTime, gamePoints]];
    else
        [resultText appendString:[NSString stringWithFormat:@"\n\nBu sorudan toplam %i + %i = %i puan kazandınız.", calculatedPoints, remainingTime, gamePoints]];


    return resultText;

}

@end
