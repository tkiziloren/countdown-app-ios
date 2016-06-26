//
//  User.h
//  BirKelimeBirIslem
//
//  Created by Tevfik Kızılören on 5/27/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameUtility.h"


@interface User : NSObject{
    NSString* username;
    NSString* email;
    NSString* password;
    NSString *password1; // only for signup validation
}
@property(nonatomic, copy) NSString *username;
@property(nonatomic, copy) NSString *email;
@property(nonatomic, copy) NSString *password;
@property(nonatomic, copy) NSString *password1;

- (id)initWithEmptyData;

- (NSString *)validateForLogin;
- (NSString *)validateForSignup;
- (NSString *)validateForRemindPassword;
- (NSString *)validateForUpdatePassword;
- (NSString *)validateForUpdateEmail;
-(void)fillFromOPropertyFile;
-(void)writeToPropertyFile;


@end
