//
//  StatsTableViewCell.h
//  BirKelimeBirIslem
//
//  Created by tkiziloren on 03.02.2013.
//
//

#import <UIKit/UIKit.h>

@interface StatsTableViewCell : UITableViewCell{
    
}

@property (weak, nonatomic) IBOutlet UIImageView *tableCellImage;
@property (weak, nonatomic) IBOutlet UILabel *tableCellHeaderText;
@property (weak, nonatomic) IBOutlet UILabel *tableCellDetailText;
@property (weak, nonatomic) IBOutlet UILabel *tableCellPointText;
@property (weak, nonatomic) IBOutlet UILabel *tableCellOrderText;
@end
