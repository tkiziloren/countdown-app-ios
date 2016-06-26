//
//  User.m
//  BirKelimeBirIslem
//
//  Created by Tevfik Kızılören on 5/27/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "User.h"

@implementation User
@synthesize username;
@synthesize email;
@synthesize password;
@synthesize password1;


- (id)init
{
    self = [super init];
    if (self)
        [self fillFromOPropertyFile];

    return self;
}

- (id)initWithEmptyData{
    self = [super init];
    if (self) {
        username = @"";
        password = @"";
        password1 = @"";
        email = @"";
    }

    return self;
}


-(void)fillFromOPropertyFile{
    self.username = [GameUtility readUserName];
    self.email = [GameUtility readEmail];
    self.password = [GameUtility readPassword];
}

-(void)writeToPropertyFile{
    [GameUtility saveUserName:self.username];
    [GameUtility savePassword:self.password];
    [GameUtility saveEmail:self.email];
}

- (NSString *)validateForLogin {

    NSString *userValidateResult = [GameUtility validateUsername:self.username];
    if (NO ==[Constants.instance.DEFAULT_INTERNAL_STRING_SUCCESS_RESPONSE isEqualToString:userValidateResult])
        return userValidateResult;

    NSString *passwordValidateResult = [GameUtility validatePassword:self.password];
    if (NO ==[Constants.instance.DEFAULT_INTERNAL_STRING_SUCCESS_RESPONSE isEqualToString:passwordValidateResult])
        return passwordValidateResult;

    return Constants.instance.DEFAULT_INTERNAL_STRING_SUCCESS_RESPONSE;
}

- (NSString *)validateForSignup {

    NSString * loginResult = self.validateForLogin;
    if (![loginResult isEqualToString:Constants.instance.DEFAULT_INTERNAL_STRING_SUCCESS_RESPONSE])
         return loginResult;

    if ([self.password isEqualToString:self.password1] == NO)
        return @"Şifre ve şifre tekrarı birbiriyle uyuşmuyor! Lütfen kontrol edip tekrar deneyiniz.";

    BOOL emailValidateResult = [GameUtility validateEmail:self.email];
    if (NO == emailValidateResult)
        return @"Lütfen geçerli bir email adresi giriniz. Email adresiniz sadece şifrenizi unuttuğunuzda, şifre bilginizi güncelleyebilmeniz için kullanılacaktır.";

    return Constants.instance.DEFAULT_INTERNAL_STRING_SUCCESS_RESPONSE;
}

- (NSString *)validateForRemindPassword {

    if ([GameUtility isEmptyString:self.username] && [GameUtility isEmptyString:self.email]){
        return @"Lütfen kullanıcı adı veya email adresinizden birini giriniz!";
    }

    BOOL emailValidateResult = [GameUtility validateEmail:self.email];
    if ([GameUtility isNotEmptyString:self.email] && NO == emailValidateResult)
        return @"Lütfen geçerli bir email adresi giriniz. Email adresiniz sadece şifrenizi unuttuğunuzda, yeni şifre edinebilmeniz için kullanılacaktır.";


    NSString *userValidateResult = [GameUtility validateUsername:self.username];
    if (![GameUtility isOK:userValidateResult] && !emailValidateResult)
        return userValidateResult;


    return Constants.instance.DEFAULT_INTERNAL_STRING_SUCCESS_RESPONSE;

}


- (NSString *)validateForUpdatePassword {

    if ([self.password isEqualToString:self.password1] == NO)
        return @"Şifre ve şifre tekrarı birbiriyle uyuşmuyor! Lütfen kontrol edip tekrar deneyiniz.";

    NSString *passwordValidateResult = [GameUtility validatePassword:self.password];
    if (NO == [GameUtility isOK:passwordValidateResult])
        return passwordValidateResult;

    return Constants.instance.DEFAULT_INTERNAL_STRING_SUCCESS_RESPONSE;

}

- (NSString *)validateForUpdateEmail {

    BOOL emailValidateResult = [GameUtility validateEmail:self.email];
    if ([GameUtility isNotEmptyString:self.email ]== NO || emailValidateResult == NO)
        return @"Lütfen geçerli bir email adresi giriniz. Email adresiniz sadece şifrenizi unuttuğunuzda, yeni şifre edinebilmeniz için kullanılacaktır.";

    return Constants.instance.DEFAULT_INTERNAL_STRING_SUCCESS_RESPONSE;
}



@end
