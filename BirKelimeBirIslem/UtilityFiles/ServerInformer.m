//
//  ServerInformer.m
//  BirKelimeBirIslem
//
//  Created by Tevfik Kızılören on 7/27/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ServerInformer.h"
#import "Constants.h"
#import "User.h"

@implementation ServerInformer

+(ServerResponse*) encryptAndSendNumberGameResults: (NSDictionary*)gameResults{
    return [self post:gameResults forAction:Constants.instance.ACTION_SAVE_NUMBER_GAME_RESULTS];
}

+(ServerResponse*) checkForWordGameAnswer: (NSDictionary *)gameResults{
    return [self post:gameResults forAction:Constants.instance.ACTION_CHECK_FOR_WORD];
}


+(ServerResponse*) loginUser: (User*)user{
    NSDictionary *dictionary = @{@"username": user.username, @"password": user.password};
    return [self post:dictionary forAction:Constants.instance.ACTION_LOGIN_USER];
}

+(ServerResponse*)signupUser:(User *)user {
    NSDictionary *dictionary = @{@"username": user.username, @"password": user.password, @"email": user.email, @"deviceid": @"-"};
    return [self post:dictionary forAction:Constants.instance.ACTION_SIGNUP_USER];
}

+(ServerResponse*) passwordRemindForUserName: (NSString*)username andOrEmail:(NSString *)email{
    NSDictionary *dictionary = @{@"username": username,  @"email": email};
    return [self post:dictionary forAction:Constants.instance.ACTION_REMIND_PASSWORD];
}

+(ServerResponse*) suggestWord: (NSString*)word forUsername:(NSString *)username{
    NSDictionary *dictionary = @{@"username": username,  @"word": word};
    return [self post:dictionary forAction:Constants.instance.ACTION_SUGGEST_WORD];
}


+(ServerResponse*)updateUserInfo:(User *)user {
    NSDictionary *dictionary = @{@"password": user.password, @"email": user.email, @"username": user.username};
    return [self post:dictionary forAction:Constants.instance.ACTION_UPDATE_USER];
}

+(ServerResponse*)getStatsForUser:(NSString *)username andStatsId:(NSString *) statsId{
    NSDictionary *dictionary = @{@"username": username, @"statsId": statsId};
    return [self post:dictionary forAction:Constants.instance.ACTION_GET_STATS];
}

+(ServerResponse*)getStatsForSpecifiUser:(NSString *)username andStatsId:(NSString *) statsId forUser:(NSString *)specificUsername{
    NSDictionary *dictionary = @{@"username": username, @"statsId": statsId, @"userOfInterest" : specificUsername};
    return [self post:dictionary forAction:Constants.instance.ACTION_GET_STATS];
}


+(ServerResponse*) post:(NSDictionary *)results forAction:(NSString *) action{
    NSString *post = [GameUtility preparePostForAction:action andDictionary:results];
    NSString *url = [[Constants instance] getUrlForAction:action];
    return [self postDataAndGetResults:post andPath:url forAction:action];
}


+(ServerResponse*) postDataAndGetResults: (NSString*)post andPath:(NSString*)path forAction:action
{
    [GameUtility logString:[NSString stringWithFormat:@"%@?%@", path, post]];
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:path]];

    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[post dataUsingEncoding:NSUTF8StringEncoding]];

    NSHTTPURLResponse *response;
    NSError *err;
    
    NSData *responseData =[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    return [ServerResponse objectWithResponseData:responseData response:response forAction:action];
}

@end
