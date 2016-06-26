//
//  GameUtility.h
//  BirKelimeBirIslem
//
//  Created by Tevfik Kızılören on 7/27/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"
#import "SBJsonWriter.h"
#import "NSString+AES.h"
#import "NSData+AES.h"
#import "Base64.h"
#import "ServerResponse.h"
#import "JSNotifier.h"

@interface GameUtility : NSObject
typedef enum{easy=1, medium, hard} Levels;
typedef enum{ALERT_CIKIS=1, ALERT_SURE_BITTI=2, ALERT_DOGRU_SONUC=3}AlertTags;
typedef enum{NOTIFY_SUCCESS=1, NOTIFY_FAIL=2, NOTIFY_ACTIVITY_INDICATOR=3}NotificationType;



+(void)checkPropertyFile;
+(void)logString:(NSString*) stringToBeLogged;
+(BOOL)isEmptyString:(NSString*) stringToBeChecked;
+(BOOL)isNotEmptyString:(NSString*) stringToBeChecked;
+(void)saveUserName:(NSString*)username;
+(NSString*)readUserName;
+(void)saveEmail:(NSString *)email;
+(NSString*)readEmail;
+(void)savePassword:(NSString *)password;
+(NSString*)readPassword;

+(void)setPropertyToFileValue:(id)value forKey:(NSString *)key;
+(id)getValueFromPropertyFileForKey:(NSString *)key;

+(NSString*)convertDictionaryToJSONString:(NSDictionary*) dictionary;
+(NSString*)obtainBase64CipherFromDictionary:(NSDictionary*) dictionary;
+(void)showAlertView:(NSString*) message;

+(int) generateRandomNumberForWordGame:(int)maximum;

+(int) getRemainingTimeForWordGame:(Levels) level;
+(int) getRemainingTimeForNumberGame:(Levels) level;

+(NSString*)getRandomVowel;
+(NSString*)getRandomConsonant;
+(BOOL)isJokerCharacterUsedFor:(NSString *)word;
+(NSString *)preparePostForAction:(NSString *) action andDictionary:(NSDictionary *) dictionary;
+(BOOL) validateEmail: (NSString *) candidate;
+(NSString *) validateUsername: (NSString *) candidate;
+(NSString *) validatePassword: (NSString *) candidate;
+(NSString *) validateSuggestedWord: (NSString *) candidate;
+(BOOL)isOK:(NSString *)candidate;
+(void)notifyUser: (NotificationType) type message:(NSString *)message;

+(NSArray *)getStatsTableCellHeadersForTable:(NSString*) tableName;
+(NSArray *)getStatsTableCellDetailsForTable:(NSString*) tableName;
+(NSString *)getNumberOfPlayedGamesString:(NSString*) numberOfPlayedGames;
+(NSString *)getNumberOfSuggestedWordsString:(NSString*) numberOfSuggestedWords;
+(void)saveUserStats:(NSArray *)userStats;
+(void)saveGeneralStats:(NSArray *)generalStats;
+(NSArray *)getGeneralStats;
+(NSArray *)getGeneralStatsFromServer;
+(NSArray *)getUserStatsForUsername:(NSString *)userOfInterest;
+(NSArray *)getUserStatsFromServerForUserName:(NSString *)userOfInterest;




@end
