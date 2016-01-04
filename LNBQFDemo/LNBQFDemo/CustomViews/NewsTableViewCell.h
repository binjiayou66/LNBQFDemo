//
//  NewsTableViewCell.h
//  
//
//  Created by Naibin on 15/11/30.
//
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"

@interface NewsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView * newsImageView;
@property (weak, nonatomic) IBOutlet UILabel * mainLabel;
@property (weak, nonatomic) IBOutlet UILabel * subLabel;
@property (weak, nonatomic) IBOutlet UILabel * dateLabel;
@property (weak, nonatomic) IBOutlet UILabel * readCountLabel;

- (void)loadDataWithNewsModel:(NewsModel *)model;

@end
