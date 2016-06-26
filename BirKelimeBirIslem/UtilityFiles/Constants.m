//
//  Constants.m
//  BirKelimeBirIslem
//
//  Created by Tevfik Kızılören on 7/16/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Constants.h"

@implementation Constants {

}


+ (Constants *)instance {
    static Constants *sharedInstance = nil;

    @synchronized (self) {
        if (sharedInstance == nil) {
            sharedInstance = [[self alloc] init];

            sharedInstance.logEnabled = YES;

            sharedInstance.DEFAULT_INTERNAL_STRING_SUCCESS_RESPONSE = @"OK";
            sharedInstance.AES_KEY = @"!1905GALATASARAYGALATASARAY1905!";
            sharedInstance.URL_FOR_SENDING_NUMBER_GAME_RESULT = @"http://localhost/bkbi/number.php";
            sharedInstance.URL_FOR_SENDING_WORD_GAME_RESULT = @"http://localhost/bkbi/word.php";
            sharedInstance.URL_FOR_USER_OPERATIONS = @"http://localhost/bkbi/user.php";
            sharedInstance.URL_FOR_STATISTICS = @"http://localhost/bkbi/stats.php";
            sharedInstance.DEFAULT_USERNAME = @"kullanici";

            sharedInstance.SUCCESS_GENERAL_SUCCESS_CODE = @"200";
            sharedInstance.SUCCESS_GAME_RESULT_INSERTED = @"201";
            sharedInstance.SUCCESS_USER_INSERTED = @"202";

            sharedInstance.ERROR_INVALID_JSON = @"901";
            sharedInstance.ERROR_WHEN_INSERTING_GAME_RESULT = @"902";
            sharedInstance.ERROR_WHEN_INSERTING_USER = @"903";

            sharedInstance.RESULT_USERNAME_EXISTS = @"951";
            sharedInstance.RESULT_USERNAME_DOESNT_EXIST = @"952";

            sharedInstance.RESULT_WORD_IS_CORRECT = @"953";
            sharedInstance.RESULT_WORD_IS_INCORRECT = @"954";
            sharedInstance.RESULT_LOGIN_SUCCESS = @"955";
            sharedInstance.RESULT_LOGIN_FAIL = @"956";
            sharedInstance.RESULT_SIGNUP_SUCCESS = @"957";
            sharedInstance.RESULT_SIGNUP_FAIL = @"958";
            sharedInstance.RESULT_REMIND_PASSWORD_SUCCESS = @"959";
            sharedInstance.RESULT_REMIND_PASSWORD_FAIL = @"960";
            sharedInstance.RESULT_SUGGEST_WORD_SUCCESS = @"961";
            sharedInstance.RESULT_SUGGEST_WORD_FAIL = @"962";
            sharedInstance.RESULT_SUGGEST_WORD_EXISTS = @"963";

            sharedInstance.RESULT_UPDATE_USER_SUCCESS = @"964";
            sharedInstance.RESULT_UPDATE_USER_FAIL = @"965";

            sharedInstance.URL_PARAM_ACTION = @"a";
            sharedInstance.URL_PARAM_CIPHER_TEXT = @"ct";

            sharedInstance.ACTION_LOGIN_USER = @"lu";
            sharedInstance.ACTION_SIGNUP_USER = @"su";
            sharedInstance.ACTION_CHECK_FOR_WORD = @"cfw";
            sharedInstance.ACTION_SUGGEST_WORD = @"sw";
            sharedInstance.ACTION_SAVE_NUMBER_GAME_RESULTS = @"snr";
            sharedInstance.ACTION_REMIND_PASSWORD = @"rp";
            sharedInstance.ACTION_UPDATE_USER = @"uu";
            sharedInstance.ACTION_GET_STATS = @"gs";

            sharedInstance.SESLI_HARFLER = @"AEIİOÖUÜ";
            sharedInstance.SESSIZ_HARFLER = @"BCÇDFGĞHJKLMNPRSŞTVYZ";
            sharedInstance.JOKER_KARAKTERI = @"?";

            sharedInstance.MIN_USERNAME_LENGTH = 5;
            sharedInstance.MAX_USERNAME_LENGTH = 20;
            sharedInstance.MIN_PASSWORD_LENGTH = 5;
            sharedInstance.MAX_PASSWORD_LENGTH = 10;

            [sharedInstance fillReturnCodes];
            [sharedInstance fillErrorMessages];
            [sharedInstance fillUrls];
            [sharedInstance fillStatsNames];

        }
    }

    return sharedInstance;
}

- (void)fillStatsNames {
    if (self.statsNames != nil)
        return;


    self.statsNames = @{
            @"kayitTarihi" : @"-",
            @"toplamIslemOyunuSayisi" : @"Toplam İşlem Oyunu Sayısı",
            @"toplamKelimeOyunuSayisi" : @"Toplam Kelime Oyunu Sayısı",
            @"gunlukOrtalamaIslemOyunuSayisi" : @"Günlük Ortalama İşlem Oyunu Sayısı",
            @"gunlukOrtalamaKelimeOyunuSayisi" : @"Günlük Ortalama Kelime Oyunu Sayısı",
            @"islemPuanAlmaYuzdesi" : @"İşlem Puan Alma Yüzdesi",
            @"islemTamSonucaUlasmaYuzdesi" : @"İşlem Tam Sonuca Ulaşma Yüzdesi",
            @"islemOrtalamaKalanSure" : @"İşlem Ortalama Artırılan Süre",
            @"islemTamSonucOrtalamaKalanSure" : @"İşlem Ortalama Artırılan Süre(Tam Sonuç)",
            @"islemToplamPuan" : @"İşlem Toplam Puan",
            @"islemOrtalamaPuan" : @"İşlem Ortalama Puan",
            @"kelimeToplamPuan" : @"Kelime Toplam Puan",
            @"kelimeOrtalamaPuan" : @"Kelime Ortalama Puan",
            @"kelimeTamSonucaUlasmaSayisi" : @"Kelime Tam Sonuca Ulaşma Sayısı",
            @"kelimeTamSonucaUlasmaYuzdesi" : @"Kelime Tam Sonuca Ulaşma Yüzdesi",
            @"kelimeSorudanPuanAlmaYuzdesi" : @"Kelime Puan Alma Yüzdesi",
            @"kelimeOrtalamaKalanSure" : @"Kelime Ortalama Artırılan Süre",
            @"kelimeOrtalamaHarfSayisi" : @"Kelime Cevaplarındaki Ortalama Harf Sayısı",
            @"harf3" : @"3 Harfli",
            @"harf4" : @"4 Harfli",
            @"harf5" : @"5 Harfli",
            @"harf6" : @"6 Harfli",
            @"harf7" : @"7 Harfli",
            @"harf8" : @"8 Harfli",
            @"harf9" : @"9 Harfli",
            @"harf10" : @"10 Harfli",
            @"harf11" : @"11 Harfli",
            @"kelimeSifirPuan" : @"Kelime Sıfır Puan",
            @"tamSonuc" : @"Tam Sonuç",
            @"yaklasik1" : @"1 Yaklaşık",
            @"yaklasik2" : @"2 Yaklaşık",
            @"yaklasik3" : @"3 Yaklaşık",
            @"yaklasik4" : @"4 Yaklaşık",
            @"yaklasik5" : @"5 Yaklaşık",
            @"islemSifirPuan" : @"İşlem Sıfır Puan",
    };
}

- (void)fillReturnCodes {

    if (self.returnCodes != nil)
        return;

    NSArray *keys = [NSArray arrayWithObjects:
            self.SUCCESS_GENERAL_SUCCESS_CODE,
            self.SUCCESS_GAME_RESULT_INSERTED,
            self.SUCCESS_USER_INSERTED,

            self.ERROR_INVALID_JSON,
            self.ERROR_WHEN_INSERTING_GAME_RESULT,
            self.ERROR_WHEN_INSERTING_USER,

            self.RESULT_USERNAME_EXISTS,
            self.RESULT_USERNAME_DOESNT_EXIST,

            self.RESULT_WORD_IS_CORRECT,
            self.RESULT_WORD_IS_INCORRECT,

            self.RESULT_LOGIN_SUCCESS,
            self.RESULT_LOGIN_FAIL,

            self.RESULT_SIGNUP_SUCCESS,
            self.RESULT_SIGNUP_FAIL,

            self.RESULT_REMIND_PASSWORD_SUCCESS,
            self.RESULT_REMIND_PASSWORD_FAIL,

            self.RESULT_UPDATE_USER_SUCCESS,
            self.RESULT_UPDATE_USER_FAIL,

            self.RESULT_SUGGEST_WORD_SUCCESS,
            self.RESULT_SUGGEST_WORD_FAIL,
            self.RESULT_SUGGEST_WORD_EXISTS,

            nil];


    NSArray *objects = [NSArray arrayWithObjects:
            self.DEFAULT_INTERNAL_STRING_SUCCESS_RESPONSE,
            self.DEFAULT_INTERNAL_STRING_SUCCESS_RESPONSE,
            self.DEFAULT_INTERNAL_STRING_SUCCESS_RESPONSE,

            @"Oyun sonucu sunucuya gönderilirken bir hata oluştu: Geçersiz JSON!",
            @"Oyun sonucu sunucuya gönderilirken bir hata oluştu: Gecersiz Sorgu!",
            @"Oyun sonucu sunucuya gönderilirken bir hata oluştu: Geçersiz Kullanıcı Adı!",

            @"Bu kullanıcı ismi bir başka kullanıcı tarafından kullanılmaktadır!",
            self.DEFAULT_INTERNAL_STRING_SUCCESS_RESPONSE,

            self. DEFAULT_INTERNAL_STRING_SUCCESS_RESPONSE,
            @"Kelime Geçersiz",

            self.DEFAULT_INTERNAL_STRING_SUCCESS_RESPONSE,
            @"Kullanıcı adınız veya şifreniz yanlış. Şifrenizi mi unuttunuz?",

            self.DEFAULT_INTERNAL_STRING_SUCCESS_RESPONSE,
            @"Kullanıcı bilgileriniz kaydedilirken beklenmedik bir hata oluştu. Lütfen internet bağlantınızı kontrol edip tekrar deneyiniz.",

            self.DEFAULT_INTERNAL_STRING_SUCCESS_RESPONSE,
            @"İşlem sırasında beklenmedik bir hata oluştu. Lütfen daha sonra tekrar deneyiniz.",

            self.DEFAULT_INTERNAL_STRING_SUCCESS_RESPONSE,
            @"Kullanıcı bilgileriniz güncellenirken beklenmedik bir hata oluştu. Lütfen daha sonra tekrar deneyiniz.",

            self. DEFAULT_INTERNAL_STRING_SUCCESS_RESPONSE,
            @"İşlem sırasında beklenmedik bir hata oluştu. Lütfen daha sonra tekrar deneyiniz.",
            @"Kelime veritabanında var veya daha önce başka kullanıcı tarafından önerilmiş!",

            nil];
    self.returnCodes = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
}

- (void)fillErrorMessages {

    if (self.errorMessages != nil)
        return;

    NSArray *keys = [NSArray arrayWithObjects:
            self.ACTION_LOGIN_USER,
            self.ACTION_SIGNUP_USER,
            self.ACTION_REMIND_PASSWORD,
            self.ACTION_CHECK_FOR_WORD,
            self.ACTION_SUGGEST_WORD,
            self.ACTION_SAVE_NUMBER_GAME_RESULTS,
            self.ACTION_UPDATE_USER,
            self.ACTION_GET_STATS,
            nil];


    NSArray *objects = [NSArray arrayWithObjects:
            @"Kullanıcı bilginiz sunucuya gönderilirken beklenmedik bir hata oluştu! İnternet bağlantınızı kontrol edip tekrar deneyiniz.",
            @"Kullanıcı bilginizin kaydedilmesi esnasında beklenmedik bir hata oluştu! İnternet bağlantınızı kontrol edip tekrar deneyiniz.",
            @"Şifre hatırlatma işlemi esnasında beklenmedik bir hata oluştu! İnternet bağlantınızı kontrol edip tekrar deneyiniz.",
            @"Kelime oyunu sonucunuz sunucuya gönderilirken beklenmedik bir hata oluştu! Oyun sonucunuz daha sonra gönderilmek üzere kaydedildi!",
            @"Sunucuyla bağlantıda beklenmedik bir hata oluştu, daha sonra tekrar deneyiniz!",
            @"İşlem oyunu sonuc sunucuya gönderilirken beklenmedik bir hata oluştu. Oyun sonucunuz daha sonra gönderilmek üzere kaydedildi!",
            @"Kullanıcı bilgileriniz güncellenirken bir hata oluştu! İnternet bağlantınızı kontrol edip tekrar deneyiniz.",
            @"İstatistiklere ulaşmak için sunucuya erişilirken bir hata oluştu. Lütfen daha sonra tekrar deneyiniz.",
            nil];

    self.errorMessages = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
}

- (void)fillUrls {

    if (self.urls != nil)
        return;

    NSArray *keys = [NSArray arrayWithObjects:
            self.ACTION_LOGIN_USER,
            self.ACTION_SIGNUP_USER,
            self.ACTION_REMIND_PASSWORD,
            self.ACTION_CHECK_FOR_WORD,
            self.ACTION_SUGGEST_WORD,
            self.ACTION_SAVE_NUMBER_GAME_RESULTS,
            self.ACTION_UPDATE_USER,
            self.ACTION_GET_STATS,
            nil];

    NSArray *objects = [NSArray arrayWithObjects:
            self.URL_FOR_USER_OPERATIONS,
            self.URL_FOR_USER_OPERATIONS,
            self.URL_FOR_USER_OPERATIONS,
            self.URL_FOR_SENDING_WORD_GAME_RESULT,
            self.URL_FOR_SENDING_WORD_GAME_RESULT,
            self.URL_FOR_SENDING_NUMBER_GAME_RESULT,
            self.URL_FOR_USER_OPERATIONS,
            self.URL_FOR_STATISTICS,
            nil];

    self.urls = [NSDictionary dictionaryWithObjects:objects forKeys:keys];

}


- (NSString *)getDescriptionForCode:(NSString *)code {
    return (NSString *) [self.returnCodes objectForKey:code];
}

- (NSString *)getDefaultErrorMessageForAction:(NSString *)action {
    return (NSString *) [self.errorMessages objectForKey:action];
}

- (NSString *)getUrlForAction:(NSString *)action {
    return (NSString *) [self.urls objectForKey:action];
}

- (BOOL)isResultCodeValid:(NSString *)code {
    return [self.returnCodes.allKeys containsObject:code];
}

- (BOOL)isActionValid:(NSString *)action {
    return [self.errorMessages.allKeys containsObject:action];
}


@end
