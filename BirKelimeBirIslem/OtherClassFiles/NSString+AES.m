//
//  NSString+AESCrypt.h
//
//  AES128Encryption + Base64Encoding
//

#import "NSString+AES.h"

@implementation NSString (AESCrypt)

- (NSData*) encryptString:(NSString*)plaintext withKey:(NSString*)key {
    return [[plaintext dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:key];
}

- (NSString*) decryptData:(NSData*)ciphertext withKey:(NSString*)key {
    return [[NSString alloc] initWithData:[ciphertext AES256DecryptWithKey:key]
                                  encoding:NSUTF8StringEncoding];
}

@end
