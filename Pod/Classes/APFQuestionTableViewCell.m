//
//  APFQuestionTableViewCell.m
//  Pods
//
//  Created by Matt Sencenbaugh on 8/5/15.
//
//

#import "APFQuestionTableViewCell.h"

@implementation APFQuestionTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // configure control(s)
        self.questionLabel = [[UILabel alloc] init];
        self.questionLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.questionLabel.numberOfLines = 0;
        self.questionLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
        [self.contentView addSubview:self.questionLabel];
        
        NSDictionary *views = @{@"questionLabel": self.questionLabel};
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[questionLabel]-8-|" options:0 metrics:nil views:views]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-16-[questionLabel]-16-|" options:0 metrics:nil views:views]];
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
