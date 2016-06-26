//
//  NSMutableData+AES.h
//  BirKelimeBirIslem
//
//  Created by Tevfik Kızılören on 7/14/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData(AES)
- (NSData*)AES256EncryptWithKey:(NSString*)key;
- (NSData*)AES256DecryptWithKey:(NSString*)key;
- (NSString *)base64Encoding;
@end
