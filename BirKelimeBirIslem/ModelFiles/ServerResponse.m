//
//  ServerResponse.m
//  BirKelimeBirIslem
//
//  Created by Tevfik Kızılören on 8/4/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ServerResponse.h"

@implementation ServerResponse
@synthesize response, responseData;
@synthesize responseAsDictionary;
@synthesize responseCode;
@synthesize action;


+ (id)objectWithResponseData:(NSData *)aResponseData response:(NSHTTPURLResponse *)aResponse forAction:anAction {
    return [[ServerResponse alloc] initWithResponseData:aResponseData response:aResponse forAction:anAction];
}

- (id)initWithResponseData:(NSData *)aResponseData response:(NSHTTPURLResponse *)aResponse forAction:anAction {
    self = [super init];
    if (self) {
        responseData = aResponseData;
        response = aResponse;
        action = anAction;
        [self setDictionaryResponse];
    }

    return self;
}

-(void)setDictionaryResponse{
    if (responseData == nil){
        responseAsDictionary = nil;
        return;
    }

    NSString *result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    responseAsDictionary = [NSJSONSerialization JSONObjectWithData:[result dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];

    if (responseAsDictionary == nil)
        responseCode = nil;


    NSString * resultString = [NSString stringWithFormat:@"%@", [responseAsDictionary valueForKey:@"responseCode"]];

    if (resultString == nil)
        responseCode = nil;

    int resultCode = [[[(NSArray *) responseAsDictionary valueForKey:@"responseCode"] objectAtIndex:0] intValue];
    responseCode = [NSNumber numberWithInt:resultCode];
}

-(NSNumber*) getResponseCode
{
    return self.responseCode;
}

-(NSString*) getResponseDetails
{
     return [self stringifyServerResponse];
}

-(NSString*) stringifyServerResponse{

    if (action == nil || ![[Constants instance] isActionValid:action])
        return @"İşlem sırasında bilinmeyen bir hata oluştu: Geçersiz sunucu kodu";

    if(response.statusCode != 200 || responseAsDictionary == nil || responseCode == nil)
        return [[Constants instance] getDefaultErrorMessageForAction:action];

    if ([[Constants instance] isResultCodeValid:[responseCode stringValue]] == NO)
        return @"İşlem sırasında bilinmeyen bir hata oluştu: Geçersiz action.";

    return [[Constants instance] getDescriptionForCode:[responseCode stringValue]];
}

-(NSString *)getFoundedWordForActionCheckForWord
{

    if (responseAsDictionary == nil)
        responseCode = nil;

    if ([[[Constants instance] RESULT_WORD_IS_INCORRECT] isEqualToString:[responseCode stringValue]])
        return @"";


    NSString* wordFoundInServer = (NSString *) [[[[responseAsDictionary valueForKey:@"responseDetails"] objectAtIndex:1] valueForKey:@"wordFoundInServer"] objectAtIndex:0];
    return wordFoundInServer;
}


@end
