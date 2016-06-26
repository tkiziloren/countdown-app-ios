//
//  NSString+AESCrypt.h
//
//  AES128Encryption + Base64Encoding
//

#import <Foundation/Foundation.h>
#import "NSData+AES.h"

@interface NSString (AESCrypt)
- (NSData*) encryptString:(NSString*)plaintext withKey:(NSString*)key;
- (NSString*) decryptData:(NSData*)ciphertext withKey:(NSString*)key;
@end
