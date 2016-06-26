//
// Created by tkiziloren on 03.02.2013.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "StatisticsDetailTableViewController.h"
#import "ServerInformer.h"
#import "StatsTableViewCell.h"
#import "GameUtility.h"


@interface StatisticsTableViewController :  UITableViewController  {

}

@property (nonatomic, strong) NSArray *headerArray;
@property (nonatomic, strong) NSArray *detailArray;
@property (nonatomic, strong) NSArray *dictionaryArray;
@property (nonatomic, strong) NSString *imageName;

@end