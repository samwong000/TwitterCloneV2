//
//  TweetCell.m
//  TwitterCloneV2
//
//  Created by Sam Wong on 17/12/2014.
//  Copyright (c) 2014 sam wong. All rights reserved.
//

#import "TweetCell.h"

@interface TweetCell()

@end

@implementation TweetCell

- (void)awakeFromNib {
    // Initialization code
    
    _avatar.layer.masksToBounds = true;
    _avatar.layer.cornerRadius = 7;

    
    UIView *bgColorView = (UIView *)[[UIColor alloc]initWithWhite:0 alpha:0.07];
    self.selectedBackgroundView = bgColorView;
    self.layoutMargins = UIEdgeInsetsZero;
    self.backgroundColor = [UIColor clearColor];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [tapRecognizer setNumberOfTapsRequired: 1];
    [tapRecognizer setDelegate:self];
    [_avatar addGestureRecognizer:tapRecognizer];
    [_userName addGestureRecognizer:tapRecognizer];
    [_alias addGestureRecognizer:tapRecognizer];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)tapAction:(id) sender {
    NSLog(@"Testing Tap");
    UITapGestureRecognizer *tapRecognizer = (UITapGestureRecognizer *)sender;
    NSLog(@"%ld", (long)[tapRecognizer.view tag]);
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"userInfoTapped" object:self];
}

@end
