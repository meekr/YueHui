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
//        self.textLabel.backgroundColor = [UIColor clearColor];
//        self.textLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
//        self.textLabel.textColor = [UIColor colorWithHex:0xd4cfc2];
//        self.textLabel.shadowColor = [UIColor lightGrayColor];
//        self.textLabel.shadowOffset = CGSizeMake(0, .5);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryNone;
        self.accessoryView.hidden = YES;
        self.textLabel.hidden = YES;
        
//        UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"store-cell-bg"]];
        UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"store_1"]];
//        self.backgroundView.clipsToBounds = NO;
        self.backgroundView = bgView;
//
        UIImageView *flag = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"store-cell-flag"]];
//        UIImageView *flag = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"store_1"]];
        flag.tag = kStoreCellFlagTag;
        flag.layer.masksToBounds = NO;
        flag.layer.shadowRadius = .0;
        flag.layer.shadowColor = [UIColor blackColor].CGColor;
        flag.layer.shadowOffset = CGSizeMake(.5, .5);
        flag.layer.shadowOpacity = .4f;
        
        flag.frame=CGRectMake(10, 0.0f, flag.frame.size.width, flag.frame.size.height);
        [self.backgroundView addSubview:flag];

        //
        UILabel *tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, -5.0f, 200.0, 20)];
        tagLabel.backgroundColor = [UIColor clearColor];
        tagLabel.font = [UIFont fontWithName:@"Helvetica" size:12];
        tagLabel.textColor = [UIColor colorWithHex:0xd4cfc2];
        tagLabel.shadowColor = [UIColor lightGrayColor];
        tagLabel.shadowOffset = CGSizeMake(0, .5);
        tagLabel.text = @"还差3次签到 获得新优惠";
        [self.contentView addSubview:tagLabel];
        
        self.contentView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        
//        UILabel *mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 220.0, 15.0)];
//        //mainLabel.tag = @"MAINLABEL_TAG";
//        mainLabel.font = [UIFont systemFontOfSize:14.0];
//        mainLabel.textAlignment = UITextAlignmentRight;
//        mainLabel.textColor = [UIColor blackColor];
//        mainLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
//        mainLabel.text=@"asdfasdf";
//        [self.contentView addSubview:mainLabel];

        self.layer.masksToBounds = NO;
        self.layer.shadowRadius = 2.3;
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(.5, .5);
        self.layer.shadowOpacity = .4f;

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    UIImageView *bgView = (UIImageView *)self.backgroundView;
    if (selected) {
//        self.textLabel.textColor = [UIColor whiteColor];
//        bgView.image = [bgView.image imageTintedWithColor:[UIColor colorWithHex:0x499dba]];
    }
    else {
        self.textLabel.textColor = [UIColor colorWithHex:0xd4cfc2];
        //bgView.image = [UIImage imageNamed:@"store-cell-bg"];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect rect = self.textLabel.frame;
    rect.origin.x = 40;
    self.textLabel.frame = rect;
}

@end