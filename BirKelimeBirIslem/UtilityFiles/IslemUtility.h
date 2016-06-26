//
//  IslemUtility.h
//  BirKelimeBirIslem
//
//  Created by Tevfik Kızılören on 5/31/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSData+AES.h"
#import "GameUtility.h"

@interface IslemUtility : NSObject



+(int) getTargetNumber:(Levels)level;
+(int) getNumber;
+(int) getLastNumber;
+(NSString*) convertNumberToString:(int) number;
+(int) generateRandomNumber:(int)maximum;



@end
