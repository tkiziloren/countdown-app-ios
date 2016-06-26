//
//  ServerInformer.h
//  BirKelimeBirIslem
//
//  Created by Tevfik Kızılören on 7/27/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "NSString+AES.h"
#import "NSData+AES.h"
#import "Base64.h"
#import "GameUtility.h"
#import "SBJsonWriter.h"
#import "ServerResponse.h"
#import "User.h"



@interface ServerInformer : NSObject

+(ServerResponse*) encryptAndSendNumberGameResults: (NSDictionary*)gameResults;
+(ServerResponse*) checkForWordGameAnswer: (NSDictionary *)gameResults;
+(ServerResponse*) loginUser: (User*)user;
+(ServerResponse*) signupUser: (User*)user;
+(ServerResponse*) updateUserInfo: (User*)user;
+(ServerResponse*) passwordRemindForUserName: (NSString*)username andOrEmail:(NSString *)email;
+(ServerResponse*) suggestWord: (NSString*)word forUsername:(NSString *)username;
+(ServerResponse*) getStatsForUser:(NSString *)username andStatsId:(NSString *) statsId;
+(ServerResponse*)getStatsForSpecifiUser:(NSString *)username andStatsId:(NSString *) statsId forUser:(NSString *)specificUsername;


    @end
