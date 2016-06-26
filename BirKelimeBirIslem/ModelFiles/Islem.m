//
//  Islem.m
//  BirKelimeBirIslem
//
//  Created by Tevfik Kızılören on 6/2/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Islem.h"

@implementation Islem
@synthesize firstNumber,secondNumber, result, operation;
- (id)init
{
    self = [super init];
    if (self) 
        [self clear];
      
    return self;
}

-(NSString*)obtainResultText{
    [self performOperation];       
    if(firstNumber <= secondNumber || operation == division || operation == substraction)
        return (result < 0) ? nil : [NSString stringWithFormat:@"%d%@%d=%d", firstNumber, [self obtainOperationText], secondNumber, result];
    else
        return (result < 0) ? nil : [NSString stringWithFormat:@"%d%@%d=%d", secondNumber, [self obtainOperationText], firstNumber, result];
        
}

-(NSString*)obtainPartialResultText{
    if(firstNumber < 0 && [self isOperationValid:operation] == NO && secondNumber < 0)
        return @"";

    if(firstNumber > 0 && secondNumber > 0 && [self isOperationValid:operation] && result < 0)
        return @"";
    
    if(firstNumber > 0 && secondNumber > 0 && [self isOperationValid:operation] && result > 0)
        return [self obtainResultText];
    
    if(firstNumber > 0 && [self isOperationValid:operation] == NO)
        return [NSString stringWithFormat:@"%d", firstNumber];
    
    if(firstNumber > 0 && [self isOperationValid:operation] == YES)
        return [NSString stringWithFormat:@"%d%@", firstNumber, [self obtainOperationText]];
            
    return @"";
}

-(void) clear{
    firstNumber = -1;
    secondNumber = -1;
    result = -1;
    operation= -1;
}

-(NSString*)obtainOperationText{
    if ([self isOperationValid:operation] == NO) 
        return nil;
    
    switch ([self operation]) {
        case addition:
            return @"+";
        case substraction:
            return @"-";
        case multiplication:
            return @"x";
        case division:
            return @"/";
        default:
            return nil;
    }
}

-(int)performOperation{
    if(firstNumber > 0 && secondNumber > 0 && [self isOperationValid:operation] == YES){
        switch ([self operation]) {
            case addition:
                result = firstNumber + secondNumber;
                break;
            case substraction:
                result = firstNumber - secondNumber;
                if(result <= 0){
                    result = -1;
                    secondNumber = -1;
                }
                break;
            case multiplication:
                result = firstNumber * secondNumber;
                break;
            case division:
                if(secondNumber != 0 && (firstNumber%secondNumber)==0){
                    result= firstNumber / secondNumber;
                }
                else{
                    secondNumber = -1;
                    result = -1;
                }
                break;
            default:
                result = -1;
                break;            
        }
    }
    else
    {
        result = -1;
    }
    return result;
}

-(int)injectOperand:(int)operand{
    if(secondNumber < 0 && [self isOperationValid:operation] == NO){
        firstNumber = operand;
        return 1;
    }
    else if(firstNumber > 0 && [self isOperationValid:operation]){
        secondNumber = operand;    
        return 2;
    }
    return -1;
}

-(BOOL)injectOperation:(Operations)op{
    if(firstNumber > 0 && [self isOperationValid:op] == YES && secondNumber < 0){
        operation = op;
        return YES;
    }
    return NO;
}

-(BOOL)isOperationValid:(Operations)op{
    if(op == addition || op == substraction || op == multiplication || op == division)
        return YES;
    
    return NO;
}
@end
