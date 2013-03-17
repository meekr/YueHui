//
//  YHStoreTableViewCell.m
//  YueHui
//
//  Created by Lei Perry on 3/17/13.
//  Copyright (c) 2013 BitRice. All rights reserved.
//

#import "YHStoreTableViewCell.h"
#import "UIColor+Ext.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImage+Ext.h"


@implementation YHStoreTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
        self.textLabel.textColor = [UIColor colorWithHex:0xd4cfc2];
        self.textLabel.shadowColor = [UIColor lightGrayColor];
        self.textLabel.shadowOffset = CGSizeMake(0, .5);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"store-cell-bg"]];
        self.backgroundView.clipsToBounds = NO;
        self.backgroundView = bgView;
        
        UIImageView *flag = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"store-cell-flag"]];
        flag.tag = kStoreCellFlagTag;
        flag.layer.masksToBounds = NO;
        flag.layer.shadowRadius = .0;
        flag.layer.shadowColor = [UIColor blackColor].CGColor;
        flag.layer.shadowOffset = CGSizeMake(.5, .5);
        flag.layer.shadowOpacity = .4f;
        [self.backgroundView addSubview:flag];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    UIImageView *bgView = (UIImageView *)self.backgroundView;
    if (selected) {
        self.textLabel.textColor = [UIColor whiteColor];
        bgView.image = [bgView.image imageTintedWithColor:[UIColor colorWithHex:0x499dba]];
    }
    else {
        self.textLabel.textColor = [UIColor colorWithHex:0xd4cfc2];
        bgView.image = [UIImage imageNamed:@"store-cell-bg"];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect rect = self.textLabel.frame;
    rect.origin.x = 40;
    self.textLabel.frame = rect;
}

@end