//
//  StatsTableViewCell.m
//  BirKelimeBirIslem
//
//  Created by tkiziloren on 03.02.2013.
//
//

#import "StatsTableViewCell.h"

@implementation StatsTableViewCell
@synthesize tableCellImage;
@synthesize tableCellDetailText;
@synthesize tableCellHeaderText;
@synthesize tableCellPointText;
@synthesize tableCellOrderText;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
