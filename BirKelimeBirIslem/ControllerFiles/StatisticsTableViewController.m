//
// Created by tkiziloren on 03.02.2013.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "StatisticsTableViewController.h"

@implementation StatisticsTableViewController
@synthesize headerArray;
@synthesize detailArray;
@synthesize dictionaryArray;
@synthesize imageName;


-(void)viewDidLoad{
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] init];
    /* [self.tableView setBackgroundColor: [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg5.png"]]]; */
    if ([@"ben" isEqualToString:self.title]){
        self.dictionaryArray = [GameUtility getUserStatsForUsername:[GameUtility readUserName]];
    }
    else{
        self.headerArray = [GameUtility getStatsTableCellHeadersForTable:self.title];
        self.detailArray = [GameUtility getStatsTableCellDetailsForTable:self.title];
    }

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([@"ben" isEqualToString:self.title]){
        return dictionaryArray.count;
    }
    return [self.headerArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // title + "Cell"
    NSString *cellIdentifier = [self.title stringByAppendingString:@"Cell"];

    StatsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
        cell = [[StatsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];


    if ([@"ben" isEqualToString:self.title])
    {
        NSString *istatistikAdi = [((NSDictionary *) [self.dictionaryArray objectAtIndex:indexPath.row]) objectForKey:@"istatistikAdi"];
        cell.tableCellHeaderText.text = [((NSDictionary *) [self.dictionaryArray objectAtIndex:indexPath.row]) objectForKey:@"istatistikAdi"];
        cell.tableCellPointText.text = [((NSDictionary *) [self.dictionaryArray objectAtIndex:indexPath.row]) objectForKey:@"deger"];
    }
    else
    {
        // Configure the cell...
        cell.tableCellHeaderText.text = [self.headerArray objectAtIndex: [indexPath row]];
        NSObject * object = [[self detailArray] objectAtIndex:indexPath.row];

        if (object == [NSNull null] || object == nil)
            cell.tableCellPointText.text = @"---";
        else
            cell.tableCellPointText.text = [self.detailArray objectAtIndex:[indexPath row]];
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.title isEqualToString:@"islem"] == NO)
        return;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (![[segue identifier] isEqualToString:@"islemSegue"] && ![[segue identifier] isEqualToString:@"kelimeSegue"])
        return;

    NSString *username = [GameUtility readUserName];
    NSString *statsId =  [NSString stringWithFormat:@"%@%d", self.title , self.tableView.indexPathForSelectedRow.row + 1];

    ServerResponse * serverResponse = [ServerInformer getStatsForUser:username andStatsId:statsId];

    int count = ((NSArray *)((NSArray *) [serverResponse.responseAsDictionary valueForKey:@"responseDetails"])[1]).count;
    NSMutableArray *statsArray = [NSMutableArray new];

    for (int i = 0; i < count; i++) {
        NSString *detay = [((NSDictionary *) ((NSArray *) ((NSArray *) [serverResponse.responseAsDictionary valueForKey:@"responseDetails"])[1])[i]) valueForKey:@"sayi"];
        NSString *kullaniciAdi = [((NSDictionary *) ((NSArray *) ((NSArray *) [serverResponse.responseAsDictionary valueForKey:@"responseDetails"])[1])[i]) valueForKey:@"kullaniciAdi"];
        NSString *puan = [((NSDictionary *) ((NSArray *) ((NSArray *) [serverResponse.responseAsDictionary valueForKey:@"responseDetails"])[1])[i]) valueForKey:@"deger"];

        if ([statsId isEqualToString:@"kelime6"] || [statsId isEqualToString:@"kelime8"])
            detay = [GameUtility getNumberOfSuggestedWordsString:detay];
        else
            detay = [GameUtility getNumberOfPlayedGamesString:detay];

        [statsArray addObject:@{ @"detay" : detay, @"kullaniciAdi" : kullaniciAdi, @"puan" : puan }];
    }

    StatisticsDetailTableViewController *vc = [segue destinationViewController];

    vc.dictionaryArray = statsArray;
    vc.tableTitle = [self.headerArray objectAtIndex:self.tableView.indexPathForSelectedRow.row];

    if ([[segue identifier] isEqualToString:@"islemSegue"])
        vc.cellType = (self.tableView.indexPathForSelectedRow.row == 7) ? @"cellTypeGeneralResults" : @"cellTypeUserStats";
    else // kelimeSegue
        vc.cellType = (self.tableView.indexPathForSelectedRow.row == 7 || self.tableView.indexPathForSelectedRow.row == 5) ? @"cellTypeGeneralResults" : @"cellTypeUserStats";

}

- (void)viewDidUnload {
    [super viewDidUnload];
}
@end