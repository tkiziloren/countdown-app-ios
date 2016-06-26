//
// Created by tevfik on 29.12.2012.
//
// To change the template use AppCode | Preferences | File Templates.
//


@protocol Playable <NSObject>

@required
-(void)prepareForNewGame;
-(int)calculateTotalPoints;
-(NSString *)obtainGameResultsAsJSONString;
-(BOOL) encyptAndPostResultsForUser;

@end

