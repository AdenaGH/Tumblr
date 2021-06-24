//
//  PhotoCellTableViewCell.m
//  Tumblr
//
//  Created by Adena Rowana Ninvalle on 6/24/21.
//

#import "PhotoCellTableViewCell.h"



@implementation PhotoCellTableViewCell

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PhotoCellTableViewCell" forIndexPath:indexPath];
    
    
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
// Download the image


@end
