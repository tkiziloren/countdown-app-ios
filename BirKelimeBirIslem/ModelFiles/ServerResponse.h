//
//  ServerResponse.h
//  BirKelimeBirIslem
//
//  Created by Tevfik Kızılören on 8/4/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ServerResponse : NSObject

{
    NSData* responseData;
    NSHTTPURLResponse* response;
    NSDictionary *responseAsDictionary;
    NSNumber* responseCode;
    NSString *action;

}

@property(nonatomic, strong) NSData *responseData;
@property(nonatomic, strong) NSHTTPURLResponse *response;
@property(nonatomic, strong) NSDictionary *responseAsDictionary;
@property(nonatomic) NSNumber* responseCode;
@property(nonatomic, copy) NSString *action;


+ (id)objectWithResponseData:(NSData *)aResponseData response:(NSHTTPURLResponse *)aResponse forAction:anAction;
- (id)initWithResponseData:(NSData *)aResponseData response:(NSHTTPURLResponse *)aResponse forAction:anAction;
-(void)setDictionaryResponse;
-(NSString*) getResponseDetails;
-(NSNumber*) getResponseCode;
-(NSString *)getFoundedWordForActionCheckForWord;



@end
