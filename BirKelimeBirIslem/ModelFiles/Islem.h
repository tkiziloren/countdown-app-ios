//
//  Islem.h
//  BirKelimeBirIslem
//
//  Created by Tevfik Kızılören on 6/2/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum{addition=0, substraction, multiplication, division} Operations;
@interface Islem : NSObject{
    int firstNumber;
    int secondNumber;
    int result;
    Operations operation;
}

@property(nonatomic, assign) int firstNumber;
@property(nonatomic, assign) int secondNumber;
@property(nonatomic, assign) int result;
@property(nonatomic, assign) Operations operation;

-(int)performOperation;
-(void)clear;
-(NSString*)obtainResultText;
-(NSString*)obtainPartialResultText;
-(NSString*)obtainOperationText;
-(int)injectOperand:(int)operand;
-(BOOL)injectOperation:(Operations)op;
-(BOOL)isOperationValid:(Operations)op;

@end
