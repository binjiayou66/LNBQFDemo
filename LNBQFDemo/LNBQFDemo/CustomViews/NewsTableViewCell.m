//
//  NewsTableViewCell.m
//  
//
//  Created by Naibin on 15/11/30.
//
//

#import "NewsTableViewCell.h"
#import <UIImageView+WebCache.h>

@implementation NewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.newsImageView.layer.masksToBounds = YES;
    self.newsImageView.layer.cornerRadius = 5.0;
}

- (void)loadDataWithNewsModel:(NewsModel *)model
{
    self.mainLabel.text = model.title;
    [self.newsImageView sd_setImageWithURL:[NSURL URLWithString:model.thumb[0][@"img_url"]]];
    self.subLabel.text = model.descrip;
    self.dateLabel.text = model.add_time;
    self.readCountLabel.text = [NSString stringWithFormat:@"阅读量: %@", model.view];
}

@end
