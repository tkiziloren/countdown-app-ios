//
// Created by tkiziloren on 03.02.2013.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "StatisticsDetailTableViewController.h"


@implementation StatisticsDetailTableViewController
@synthesize dictionaryArray;
@synthesize cellType;
@synthesize imageName;
@synthesize tableTitle;




-(void)viewDidLoad{
    [super viewDidLoad];

    // İstatistik detaylarında navigation header'ın içeriğini doldurur.
    UIFont * font = [UIFont fontWithName:@"Helvetica" size:17.0f];
    CGRect frame = CGRectMake(0, 0, [tableTitle sizeWithFont:font].width, 42);
    UILabel *label = [[UILabel alloc] initWithFrame:frame] ;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:17.0];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = tableTitle;
    label.numberOfLines =0;
    self.navigationItem.titleView = label;

    self.tableView.tableFooterView = [[UIView alloc] init];
    //self.title = [NSString stringWithFormat:@"%d.", headerArray.count];

  
   
    /*
    [self.tableView setBackgroundColor: [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg5.png"]]];
    */
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (self.dictionaryArray == nil)
        return 0;

    return [self.dictionaryArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"Cell";
    
    // title + "Cell"
    if(self.title == nil && cellType != nil){
        cellIdentifier = cellType;
    }
    else if ([self.title isEqualToString:@"kelime"] || [self.title isEqualToString:@"islem"] || [self.title isEqualToString:@"genel"]){
        cellIdentifier = [self.title stringByAppendingString:@"Cell"];
    }


    StatsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[StatsTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
              reuseIdentifier:cellIdentifier];
    }

    // Configure the cell...

    if (self.dictionaryArray != nil && self.dictionaryArray.count > 0){
        cell.tableCellHeaderText.text = [((NSDictionary *)[self.dictionaryArray objectAtIndex:indexPath.row]) objectForKey:@"kullaniciAdi"];
        cell.tableCellDetailText.text = [((NSDictionary *)[self.dictionaryArray objectAtIndex:indexPath.row]) objectForKey:@"detay"];
        cell.tableCellPointText.text  = [((NSDictionary *)[self.dictionaryArray objectAtIndex:indexPath.row]) objectForKey:@"puan"];
        cell.tableCellOrderText.text = [NSString stringWithFormat:@"%d.", indexPath.row+1];
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if(self.cellType != nil && [self.cellType isEqualToString:@"cellTypeGeneralResults"]){
       return 32;
    }
    if(self.cellType != nil && [self.cellType isEqualToString:@"cellTypeUserStats"]){
        return 48;
    }
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}


- (void)viewDidUnload {
 
    [super viewDidUnload];
}
@end