//
//  GameUtility.m
//  BirKelimeBirIslem
//
//  Created by Tevfik Kızılören on 7/27/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameUtility.h"
#import "ServerInformer.h"


@implementation GameUtility

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

+(void) checkPropertyFile{
    
    /* bkbi.plist isimli bir dosya ara. yoksa olustur */
	NSString* plistName=@"bkbi";
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = paths[0];

    NSString* myPlistPath = [documentsDirectory stringByAppendingPathComponent: [NSString stringWithFormat: @"%@.plist", plistName] ];

    [self logString:[NSString stringWithFormat:@"log: %@ ", myPlistPath]];

    NSFileManager *fileManager = [NSFileManager defaultManager];
	if ( ![fileManager fileExistsAtPath:myPlistPath] ) 
	{
		NSError *error;
		NSString *pathToSettingsInBundle = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
        [self logString:pathToSettingsInBundle];
        [fileManager copyItemAtPath:pathToSettingsInBundle toPath: myPlistPath error:&error];
	}
}

+(void)saveUserName:(NSString *)username{
    [self setPropertyToFileValue:username forKey:@"username"];
}

+(NSString*)readUserName{
    return [self getValueFromPropertyFileForKey:@"username"];
}

+(void)saveEmail:(NSString *)email{
    [self setPropertyToFileValue:email forKey:@"email"];
}

+(NSString*)readEmail{
    return [self getValueFromPropertyFileForKey:@"email"];
}

+ (void)savePassword:(NSString *)password {
    [self setPropertyToFileValue:password forKey:@"password"];
}

+ (NSString *)readPassword {
    return [self getValueFromPropertyFileForKey:@"password"];
}

+ (void)saveGeneralStats:(NSArray *)generalStats{
    [self setPropertyToFileValue:[self getTodaysDateAsString] forKey:@"generalStatsUpdateDate"];
    [self setPropertyToFileValue:generalStats forKey:@"generalStats"];
}

+ (void)saveUserStats:(NSArray *)userStats{
    [self setPropertyToFileValue:[self getTodaysDateAsString] forKey:@"userStatsUpdateDate"];
    [self setPropertyToFileValue:userStats forKey:@"userStats"];
}

+(NSString *) getTodaysDateAsString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"ddMMyyyy"];
    return [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:[NSDate date]]];
}


+ (void)setPropertyToFileValue:(id)value forKey:(NSString *)key {

    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = paths[0];
    NSString *path = [documentsDirectoryPath stringByAppendingPathComponent:@"bkbi.plist"];
    NSMutableDictionary *plist = [NSMutableDictionary dictionaryWithContentsOfFile: path];
    [plist setValue:value forKey:key];
    [plist writeToFile:path atomically:YES];
}

+ (id)getValueFromPropertyFileForKey:(NSString *)key {
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = paths[0];
    NSString *path = [documentsDirectoryPath stringByAppendingPathComponent:@"bkbi.plist"];
    NSMutableDictionary *plist = [NSMutableDictionary dictionaryWithContentsOfFile: path];
    return [plist valueForKey:key];
}


+(NSString*)convertDictionaryToJSONString:(NSDictionary*) dictionary{
    
    SBJsonWriter *jsonWriter = [[SBJsonWriter alloc] init];
   
    NSString *jsonString = [jsonWriter stringWithObject:dictionary];  

    return jsonString;
}

+(NSString*)obtainBase64CipherFromDictionary:(NSDictionary*) dictionary{
  
    NSString* jsonResult = [self convertDictionaryToJSONString:dictionary];
    NSData *cipher = [[jsonResult dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:Constants.instance.AES_KEY];
    NSString *cipherBase64 = [Base64 encode:cipher];
    return cipherBase64;
    
}

+(void)logString:(NSString*) stringToBeLogged{

    NSLog(@"%@", stringToBeLogged);
}


+(BOOL)isEmptyString:(NSString*) stringToBeChecked{
    return stringToBeChecked == nil || stringToBeChecked.length == 0;
}

+(BOOL)isNotEmptyString:(NSString*) stringToBeChecked{
    return ![self isEmptyString:stringToBeChecked];
}
+ (void)showAlertViewWithTwoOption:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc]
            initWithTitle:@"Uyarı"
                  message:message
                 delegate:self
        cancelButtonTitle:@"Hayır"
        otherButtonTitles:@"Evet", nil];
    [alert show];
}


+(void)showAlertView:(NSString*) message{
    UIAlertView *alert = [[UIAlertView alloc] 
                          initWithTitle:@"Uyarı" 
                          message:message
                          delegate:self 
                          cancelButtonTitle:nil
                          otherButtonTitles:@"OK", nil];
    alert.cancelButtonIndex = 1;
    
    [alert show];
}

+(int) generateRandomNumberForWordGame:(int)maximum{
    return arc4random() % maximum;
}

+(NSString*)getRandomVowel{
    
    int index = [GameUtility generateRandomNumberForWordGame:Constants.instance.SESLI_HARFLER.length];
    return [NSString stringWithFormat: @"%C", [Constants.instance.SESLI_HARFLER characterAtIndex: index]];
    
}

+(NSString*)getRandomConsonant{

    int index = [GameUtility generateRandomNumberForWordGame:Constants.instance.SESSIZ_HARFLER.length];
    return [NSString stringWithFormat: @"%C", [Constants.instance.SESSIZ_HARFLER characterAtIndex: index]];
    
}

+(int) getRemainingTimeForWordGame:(Levels) level{
    switch (level) {
        case easy:
            return 75;             
        case medium:
            return 60;
        case hard:
            return 45;
        default:
            return 60;             
    }
}

+(int) getRemainingTimeForNumberGame:(Levels) level{
    switch (level) {
        case easy:
            return 90;             
        case medium:
            return 75;
        case hard:
            return 60;
        default:
            return 75;             
    }

}

+(BOOL)isJokerCharacterUsedFor:(NSString *)word{

    if ([word rangeOfString:Constants.instance.JOKER_KARAKTERI].location == NSNotFound)
        return NO;

    return YES;

}

+(NSString *)preparePostForAction:(NSString *) action andDictionary:(NSDictionary *) dictionary{
    NSString *post = [NSString stringWithFormat:@"%@=%@&%@=%@",Constants.instance.URL_PARAM_ACTION, action, Constants.instance.URL_PARAM_CIPHER_TEXT, [self obtainBase64CipherFromDictionary:dictionary]];
    return post;
}

+ (BOOL) validateEmail: (NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];

    return [emailTest evaluateWithObject:candidate];
}

+ (NSString *)validateUsername:(NSString *)candidate {
    if(candidate == nil || candidate.length == 0)
        return @"Lütfen geçerli bir kullanıcı adı giriniz!";

    if ([candidate isEqualToString:Constants.instance.DEFAULT_USERNAME])
        return @"Lütfen farklı bir kullanıcı adı belirleyiniz!";

    if (candidate.length <  Constants.instance.MIN_USERNAME_LENGTH)
        return [NSString stringWithFormat:@"Kullanıcı adınız en az %d karakterden oluşmalıdır!", Constants.instance.MIN_USERNAME_LENGTH];


    if (candidate.length >  Constants.instance.MAX_USERNAME_LENGTH)
        return [NSString stringWithFormat:@"Kullanıcı adınız en çok %d karakterden oluşmalıdır!", Constants.instance.MAX_USERNAME_LENGTH];

    return Constants.instance.DEFAULT_INTERNAL_STRING_SUCCESS_RESPONSE;
}

+ (NSString *)validatePassword:(NSString *)candidate {
    NSString *myRegex = @"[A-Z0-9a-z_]*";
    NSPredicate *myTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", myRegex];

    if ([myTest evaluateWithObject:candidate] == NO)
        return @"Kullanıcı adınız sadece harf ve rakam ve alt çizgi(_) karakteri içerebilir. Kullanıcı adınızda boşluk ve türkçe karakter bulunmamalıdır.";

    if(candidate == nil || candidate.length == 0)
        return @"Lütfen bir şifre giriniz!";

    if (candidate.length <  Constants.instance.MIN_PASSWORD_LENGTH)
        return [NSString stringWithFormat:@"Şifreniz en az %d karakterden oluşmalıdır!", Constants.instance.MIN_PASSWORD_LENGTH];

    if (candidate.length >  Constants.instance.MAX_PASSWORD_LENGTH)
        return [NSString stringWithFormat:@"Şifreniz en çok %d karakterden oluşmalıdır!", Constants.instance.MAX_PASSWORD_LENGTH];

    if ([myTest evaluateWithObject:candidate] == NO)
        return @"Şifreniz sadece harf ve rakam ve alt çizgi(_) karakteri içerebilir. Kullanıcı adınızda boşluk ve türkçe karakter bulunmamalıdır.";

    return Constants.instance.DEFAULT_INTERNAL_STRING_SUCCESS_RESPONSE;
}

+ (NSString *)validateSuggestedWord:(NSString *)candidate {
    //NSString *myRegex = @"[A-Za-z]*";
    NSString *myRegex = @"[A-Za-zşŞıİçÇöÖüÜĞğ]*";
    NSPredicate *myTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", myRegex];

    if(candidate == nil || candidate.length == 0)
        return @"Bir kelime önermelisiniz!!";

    if(candidate.length < 3)
        return @"Önerdiğiniz kelime 3 harften daha kısa olamaz";

    if(candidate.length > 10)
        return @"Önerdiğiniz kelime 10 harften daha uzun olamaz";

    if ([myTest evaluateWithObject:candidate] == NO)
        return @"Gönderdiğiniz kelime sadece karakterlerden oluşmalıdır ve boşluk içermemelidir";

    return Constants.instance.DEFAULT_INTERNAL_STRING_SUCCESS_RESPONSE;
}
+(BOOL)isOK:(NSString *)candidate{

    return [Constants.instance.DEFAULT_INTERNAL_STRING_SUCCESS_RESPONSE isEqualToString:candidate];
}

+(void)notifyUser: (NotificationType) type message:(NSString *)message;
{
    if (type == NOTIFY_SUCCESS){
        JSNotifier *notify = [[JSNotifier alloc]initWithTitle:message];
        notify.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"NotifyCheck.png"]];
        [notify showFor:4.0];
    }
    if (type == NOTIFY_FAIL){
        JSNotifier *notify = [[JSNotifier alloc]initWithTitle:message];
        notify.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"NotifyX.png"]];
        [notify showFor:4.0];
    }
}


+(NSArray *)getStatsTableCellHeadersForTable:(NSString*) tableName{

    if ([tableName isEqualToString:@"islem"]){

        return [[NSArray alloc]
            initWithObjects:
                    @"Ortalama Puana Göre",
                    @"Toplam Puana Göre",
                    @"Tam Sonuca Ulaşma Sayısına Göre",
                    @"Tam Sonuca Ulaşma Yüzdesine Göre",
                    @"Tam Sonuca Ulaşma Hızına Göre",
                    @"Sonuca Ulaşma Hızına Göre",
                    @"Sorudan Puan Alma Yüzdesine Göre",
                    @"Oyun Sayısına Göre",
                    nil];
    }

    if ([tableName isEqualToString:@"kelime"]){
        return [[NSArray alloc]
                initWithObjects:
                        @"Ortalama Puana Göre",
                        @"Toplam Puana Göre",
                        @"Tam Sonuca Ulaşma Sayısına Göre",
                        @"Sorudan Puan Alma Yüzdesine Göre",
                        @"Ortalama Harf Sayısına Göre",
                        @"Kelime Önerme Sayısına Göre",
                        @"Kelime Öneri Kabul Oranına Göre",
                        @"Oyun Sayısına Göre",
                        nil];
    }

    if ([tableName isEqualToString:@"genel"]){
        return [[NSArray alloc]
                initWithObjects:
                        @"Toplam Oyuncu Sayısı",
                        @"Toplam İşlem Oyunu Sayısı",
                        @"Toplam Kelime Oyunu Sayısı",
                        @"Günlük Ortalama İşlem Oyunu Sayısı",
                        @"Günlük Ortalama Kelime Oyunu Sayısı",
                        @"Kullanıcı Başına Ortalama Kelime Oyunu Sayısı",
                        @"Kullanıcı Başına Ortalama İşlem Oyunu Sayısı",
                        @"Kullanıcı Başına Ortalama Oyun Sayısı",
                nil];
    }

    if ([tableName isEqualToString:@"ben"]){
        return [[NSArray alloc]
                initWithObjects:
                        @"Genel Sıralama",
                        @"Kelime Oyunu",
                        @"İşlem Oyunu",
                        nil];
    }

    return nil;

}

+(NSArray *)getStatsTableCellDetailsForTable:(NSString*) tableName{

    if ([tableName isEqualToString:@"islem"]){

        return [[NSArray alloc]
                initWithObjects:
                        @"İşlem oyunu için ortalama puana göre sıralamadır.",
                        @"İşlem oyunu için toplam puana göre sıralamadır.",
                        @"Tam sonuca en fazla ulaşan oyuncuların sıralı listesini verir.",
                        @"Tam sonuca en yüzdeli ulaşan oyuncuların sıralı listesini verir.",
                        @"Tam sonuca en hızlı ulaşan oyuncuların sıralı listesini verir.",
                        @"Puan alınan herhangi bir sonuca en hızlı ulaşan oyuncuların sıralı listesini verir.",
                        @"Puan alınan herhangi bir sonuca en yüzdeli ulaşan oyuncuların sıralı listesini verir.",
                        @"İşlem oyununu en fazla oynan oyuncuların sıralı listesini verir.",
                        nil];
    }

    if ([tableName isEqualToString:@"kelime"]){
        return [[NSArray alloc]
                initWithObjects:
                        @"Kelime yarışması için ortalama puana göre sıralamadır.",
                        @"Kelime yarışması için toplam puana göre sıralamadır.",
                        @"Jokersiz 8 veya daha fazla harfe sahip sonuç bulan oyuncular tam sonuç bulmuş sayılırlar",
                        @"Puan alınan oyunların oynanan oyun sayısına oranına göre yapılmış bir sıralamadır.",
                        @"Oyuncuların oynadıkları kelime oyunlarında ortalama harf sayılarına göre sıralamasıdır.",
                        @"En fazla yeni kelime öneren oyuncuların listesini verir.",
                        @"Oyuncuların önerdiği kelimelerin sisteme kabul edilme oranına göre sıralamadır.",
                        @"Kelime oyununu en fazla oynan oyuncuların listesini verir.",
                        nil];
    }

    if ([tableName isEqualToString:@"genel"]){
        return [self getGeneralStats];
    }

    if ([tableName isEqualToString:@"ben"]){
        return @[
                @"Genel Sıralama",
                @"İşlem Oyunu",
                @"Kelime Oyunu"
        ];
    }
    return nil;
}

+(NSString *)getNumberOfPlayedGamesString:(NSString*) numberOfPlayedGames{
    return [NSString stringWithFormat:@"[Toplam Oyun Sayısı: %@]", numberOfPlayedGames];
}

+(NSString *)getNumberOfSuggestedWordsString:(NSString*) numberOfSuggestedWords{
    return [NSString stringWithFormat:@"[Toplam Kelime Sayısı: %@]", numberOfSuggestedWords];
}

+(NSArray *)getGeneralStats{

    NSString *todaysDate = [self getTodaysDateAsString];
    NSString *latestUpdated = [self getValueFromPropertyFileForKey:@"generalStatsUpdateDate"];

    if ([todaysDate isEqualToString:latestUpdated]){
        return [self getValueFromPropertyFileForKey:@"generalStats"];
    }
    else{
        NSArray *generalStatsFromServer= [self getGeneralStatsFromServer];
        [self saveGeneralStats:generalStatsFromServer];
        return generalStatsFromServer;
    }
}


+(NSArray *)getGeneralStatsFromServer{
    NSString *username = [GameUtility readUserName];
    NSString *statsId = @"genel";

    ServerResponse * serverResponse = [ServerInformer getStatsForUser:username andStatsId:statsId];
    int count = ((NSArray *)((NSArray *) [serverResponse.responseAsDictionary valueForKey:@"responseDetails"])[1]).count;

    if (count != 1)
        return @[ @"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0"];

    NSMutableArray *results = [NSMutableArray new];
    [results addObject:[((NSDictionary *) ((NSArray *) ((NSArray *) [serverResponse.responseAsDictionary valueForKey:@"responseDetails"])[1])[0]) valueForKey:@"toplamOyuncuSayisi"]];
    [results addObject:[((NSDictionary *) ((NSArray *) ((NSArray *) [serverResponse.responseAsDictionary valueForKey:@"responseDetails"])[1])[0]) valueForKey:@"toplamIslemOyunuSayisi"]];
    [results addObject:[((NSDictionary *) ((NSArray *) ((NSArray *) [serverResponse.responseAsDictionary valueForKey:@"responseDetails"])[1])[0]) valueForKey:@"toplamKelimeOyunuSayisi"]];
    [results addObject:[((NSDictionary *) ((NSArray *) ((NSArray *) [serverResponse.responseAsDictionary valueForKey:@"responseDetails"])[1])[0]) valueForKey:@"gunlukOrtalamaIslemOyunuSayisi"]];
    [results addObject:[((NSDictionary *) ((NSArray *) ((NSArray *) [serverResponse.responseAsDictionary valueForKey:@"responseDetails"])[1])[0]) valueForKey:@"gunlukOrtalamaKelimeOyunuSayisi"]];
    [results addObject:[((NSDictionary *) ((NSArray *) ((NSArray *) [serverResponse.responseAsDictionary valueForKey:@"responseDetails"])[1])[0]) valueForKey:@"kullaniciBasinaIslemOyunSayisi"]];
    [results addObject:[((NSDictionary *) ((NSArray *) ((NSArray *) [serverResponse.responseAsDictionary valueForKey:@"responseDetails"])[1])[0]) valueForKey:@"kullaniciBasinaKelimeOyunSayisi"]];
    [results addObject:[((NSDictionary *) ((NSArray *) ((NSArray *) [serverResponse.responseAsDictionary valueForKey:@"responseDetails"])[1])[0]) valueForKey:@"kullaniciBasinaOyunSayisi"]];
    return results;

}

+(NSArray *)getUserStatsForUsername:(NSString *)userOfInterest{

    NSString *todaysDate = [self getTodaysDateAsString];
    NSString *latestUpdated = [self getValueFromPropertyFileForKey:@"userStatsUpdateDate"];

    if ([todaysDate isEqualToString:latestUpdated]){
        return [self getValueFromPropertyFileForKey:@"userStats"];
    }
    else{
        NSArray *userStatsFromServer= [self getUserStatsFromServerForUserName:userOfInterest];
        [self saveUserStats:userStatsFromServer];
        return userStatsFromServer;
    }
}

+(NSArray *)getUserStatsFromServerForUserName:(NSString *)userOfInterest{
    NSString *playerName = [GameUtility readUserName];
    NSString *statsId = @"ben";

    ServerResponse * serverResponse = [ServerInformer getStatsForSpecifiUser:playerName andStatsId:statsId forUser:userOfInterest];
    int count = ((NSArray *)((NSArray *) [serverResponse.responseAsDictionary valueForKey:@"responseDetails"])[1]).count;


    NSMutableArray *results = [NSMutableArray new];
        for (NSString *key in Constants.instance.statsNames){
            NSString *istatistikAdi = [[Constants instance].statsNames objectForKey:key];
            if (count == 1){
                NSString *deger = [((NSDictionary *) ((NSArray *) ((NSArray *) [serverResponse.responseAsDictionary valueForKey:@"responseDetails"])[1])[0]) valueForKey:key];
                [results addObject:@{@"istatistikAdi" : istatistikAdi, @"deger": deger}];
            }
            else{
                [results addObject:@{@"istatistikAdi" : istatistikAdi, @"deger": @"0"}];
            }
        }
    return results;
}



@end
