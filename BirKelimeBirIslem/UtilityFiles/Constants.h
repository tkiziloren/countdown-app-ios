//
//  Constants.h
//  BirKelimeBirIslem
//
//  Created by Tevfik Kızılören on 7/16/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Constants : NSObject  {



}

@property(nonatomic) BOOL logEnabled;
@property(nonatomic, strong) NSDictionary * returnCodes;
@property(nonatomic, strong) NSDictionary *errorMessages;
@property(nonatomic, strong) NSDictionary *statsNames;
@property(nonatomic, strong) NSDictionary *urls;


@property(nonatomic, strong) NSString *const DEFAULT_INTERNAL_STRING_SUCCESS_RESPONSE;
@property(nonatomic, strong) NSString *const AES_KEY;
@property(nonatomic, strong) NSString *const URL_FOR_SENDING_NUMBER_GAME_RESULT;
@property(nonatomic, strong) NSString *const URL_FOR_SENDING_WORD_GAME_RESULT;
@property(nonatomic, strong) NSString *const URL_FOR_USER_OPERATIONS;
@property(nonatomic, strong) NSString *const URL_FOR_STATISTICS;
@property(nonatomic, strong) NSString *const DEFAULT_USERNAME;


@property(nonatomic, strong) NSString *const SUCCESS_GENERAL_SUCCESS_CODE;
@property(nonatomic, strong) NSString *const SUCCESS_GAME_RESULT_INSERTED;
@property(nonatomic, strong) NSString *const SUCCESS_USER_INSERTED;

@property(nonatomic, strong) NSString *const ERROR_INVALID_JSON;
@property(nonatomic, strong) NSString *const ERROR_WHEN_INSERTING_GAME_RESULT;
@property(nonatomic, strong) NSString *const ERROR_WHEN_INSERTING_USER;

@property(nonatomic, strong) NSString *const RESULT_USERNAME_EXISTS;
@property(nonatomic, strong) NSString *const RESULT_USERNAME_DOESNT_EXIST;
@property(nonatomic, strong) NSString *const RESULT_WORD_IS_CORRECT;
@property(nonatomic, strong) NSString *const RESULT_WORD_IS_INCORRECT;



@property(nonatomic, strong) NSString *const URL_PARAM_ACTION;
@property(nonatomic, strong) NSString *const URL_PARAM_CIPHER_TEXT;
@property(nonatomic, strong) NSString *const ACTION_LOGIN_USER;
@property(nonatomic, strong) NSString *const ACTION_SIGNUP_USER;
@property(nonatomic, strong) NSString *const ACTION_CHECK_FOR_WORD;
@property(nonatomic, strong) NSString *const ACTION_SUGGEST_WORD;
@property(nonatomic, strong) NSString *const ACTION_SAVE_NUMBER_GAME_RESULTS;
@property(nonatomic, strong) NSString *const ACTION_REMIND_PASSWORD;
@property(nonatomic, strong) NSString *const ACTION_UPDATE_USER;
@property(nonatomic, strong) NSString *const ACTION_GET_STATS ;

@property(nonatomic, strong) NSString *const SESLI_HARFLER;
@property(nonatomic, strong) NSString *const SESSIZ_HARFLER;
@property(nonatomic, strong) NSString *const JOKER_KARAKTERI;
@property(nonatomic) int const MIN_USERNAME_LENGTH;
@property(nonatomic) int const MAX_USERNAME_LENGTH;
@property(nonatomic) int const MIN_PASSWORD_LENGTH;
@property(nonatomic) int const MAX_PASSWORD_LENGTH;
@property(nonatomic, strong) NSString *const RESULT_LOGIN_SUCCESS;
@property(nonatomic, strong) NSString *const RESULT_LOGIN_FAIL;
@property(nonatomic, strong) NSString *const RESULT_SIGNUP_SUCCESS;
@property(nonatomic, strong) NSString *const RESULT_SIGNUP_FAIL;
@property(nonatomic, strong) NSString *const RESULT_REMIND_PASSWORD_SUCCESS;
@property(nonatomic, strong) NSString *const RESULT_REMIND_PASSWORD_FAIL;
@property(nonatomic, strong) NSString *const RESULT_SUGGEST_WORD_FAIL;
@property(nonatomic, strong) NSString *const RESULT_SUGGEST_WORD_SUCCESS;
@property(nonatomic, strong) NSString *const RESULT_SUGGEST_WORD_EXISTS;
@property(nonatomic, strong) NSString *const RESULT_UPDATE_USER_SUCCESS;
@property(nonatomic, strong) NSString *const RESULT_UPDATE_USER_FAIL;


+(Constants*)instance;
-(NSString *)getDescriptionForCode:(NSString *) code;
-(NSString *)getDefaultErrorMessageForAction:(NSString *) action;
-(NSString *)getUrlForAction:(NSString *) action;

-(BOOL)isResultCodeValid:(NSString *) code;
-(BOOL)isActionValid:(NSString *)action;


- (void)fillStatsNames;
@end
