//
//  MainScreenTableViewCell.m
//  CITASK
//
//  Created by Atit Modi on 11/18/14.
//  Copyright (c) 2014 Atit. All rights reserved.
//

#import "MainScreenTableViewCell.h"

@implementation MainScreenTableViewCell

#pragma mark main

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // Initialization code
        
        [self loadRestaurantPage];
        [self addConstraintsToForm];
        
    }
    return self;
}


#pragma mark setting view for Table Contents

-(void) loadRestaurantPage
{
    //initiliazing all the required Contents on screen if they are nil
    
    /* translatesAutoresizingMaskIntoConstraints is UIView property which is default Yes, by setting it to No we can use auto layout constraints */
    
    if (!_imageForLogo) {
        
        self.imageForLogo = [[UIImageView alloc]init];
        self.imageForLogo.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.imageForLogo];
    }
    
    
    if (!_labelOutletName) {
        
        self.labelOutletName = [UILabel new];
        self.labelOutletName.text = @"";
        self.labelOutletName.textColor = [UIColor blackColor];
        self.labelOutletName.font = [UIFont boldSystemFontOfSize:18.0];
        self.labelDistance.minimumScaleFactor = 0.4;
        
        self.labelOutletName.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.labelOutletName];
    }
    
    
    if (!_labelOffers) {
        
        self.labelOffers = [UILabel new];
        self.labelOffers.text = @"";
        self.labelOffers.textColor = [UIColor grayColor];
        self.labelOffers.font = [UIFont boldSystemFontOfSize:15.0];
        self.labelOffers.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.labelOffers];
    }
    
    if (!_labelCategoryNameOne) {
        
        self.labelCategoryNameOne = [UILabel new];
        self.labelCategoryNameOne.text = @"";
        self.labelCategoryNameOne.textColor = [UIColor grayColor];
        self.labelCategoryNameOne.font = [UIFont boldSystemFontOfSize:15.0];
        self.labelCategoryNameOne.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.labelCategoryNameOne];
    }
    
    
    if (!_imageForDistance) {
        
        self.imageForDistance = [[UIImageView alloc]init];
        self.imageForDistance.image = [UIImage imageNamed:@"locationpin"];
        self.imageForDistance.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.imageForDistance];
    }
    
    if (!_labelDistance) {
        
        self.labelDistance = [UILabel new];
        self.labelDistance.text = @"";
        self.labelDistance.textColor = [UIColor grayColor];
        self.labelDistance.font = [UIFont boldSystemFontOfSize:15.0];
        self.labelDistance.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.labelDistance];
    }
    
    if (!_labelNeighbourhoodName) {
        
        self.labelNeighbourhoodName = [UILabel new];
        self.labelNeighbourhoodName.text = @"";
        self.labelNeighbourhoodName.textColor = [UIColor grayColor];
        self.labelNeighbourhoodName.font = [UIFont boldSystemFontOfSize:15.0];
        self.labelNeighbourhoodName.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.labelNeighbourhoodName];
    }
    
}

#pragma mark Constraints Declaration

-(void) addConstraintsToForm{
    
    if(viewsDictionary == nil)
    {
        viewsDictionary = [[NSMutableDictionary alloc] init];
        [viewsDictionary setObject:_imageForLogo forKey:@"_imageForLogo"];
        [viewsDictionary setObject:_labelOutletName forKey:@"_labelOutletName"];
        [viewsDictionary setObject:_labelOffers forKey:@"_labelOffers"];
        [viewsDictionary setObject:_labelCategoryNameOne forKey:@"_labelCategoryNameOne"];
        [viewsDictionary setObject:_imageForDistance forKey:@"_imageForDistance"];
        [viewsDictionary setObject:_labelDistance forKey:@"_labelDistance"];
        [viewsDictionary setObject:_labelNeighbourhoodName forKey:@"_labelNeighbourhoodName"];
        
    }
    
    if(metricsDictionary == nil)
    {
        metricsDictionary = @{
                              @"verticalpaddingforimage":@(10),
                              @"horizontalpadding":@(10),
                              @"verticalpadding":@(20),
                              @"imageheight":@(45),
                              @"imagewidth":@(100),
                              @"verticalpaddingfordistance":@(4),
                              @"imagefordistanceheight":@(20),
                              @"imagefordistancewidth":@(20),
                              @"verticalpaddingforlabeloffer":@(5)
                              };
        
    }
    
    //horizontal contraints of contents
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-horizontalpadding-[_imageForLogo(imagewidth)]-horizontalpadding-[_labelOutletName]-horizontalpadding-|" options:0 metrics:metricsDictionary views:viewsDictionary]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-horizontalpadding-[_imageForLogo(imagewidth)]-horizontalpadding-[_labelOffers]-horizontalpadding-|" options:0 metrics:metricsDictionary views:viewsDictionary]];
    
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-horizontalpadding-[_labelCategoryNameOne]|" options:0 metrics:metricsDictionary views:viewsDictionary]];
    
    
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-horizontalpadding-[_imageForDistance(imagefordistancewidth)][_labelDistance]-horizontalpadding-[_labelNeighbourhoodName]|" options:0 metrics:metricsDictionary views:viewsDictionary]];
    
    
    //vertical constraints of contents
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-verticalpaddingforimage-[_imageForLogo(imageheight)]-verticalpaddingforimage-[_labelCategoryNameOne]" options:0 metrics:metricsDictionary views:viewsDictionary]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-verticalpaddingforimage-[_labelOutletName]-verticalpaddingforlabeloffer-[_labelOffers]" options:0 metrics:metricsDictionary views:viewsDictionary]];
    
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-verticalpaddingforimage-[_imageForLogo(imageheight)]-verticalpaddingforimage-[_labelCategoryNameOne]-verticalpaddingfordistance-[_labelDistance]" options:0 metrics:metricsDictionary views:viewsDictionary]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-verticalpaddingforimage-[_imageForLogo(imageheight)]-verticalpaddingforimage-[_labelCategoryNameOne]-verticalpaddingfordistance-[_labelNeighbourhoodName]" options:0 metrics:metricsDictionary views:viewsDictionary]];
    
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-verticalpaddingforimage-[_imageForLogo(imageheight)]-verticalpaddingforimage-[_labelCategoryNameOne][_imageForDistance(imagefordistanceheight)]" options:0 metrics:metricsDictionary views:viewsDictionary]];
    
    
}

- (void)dealloc
{
    viewsDictionary = nil;
    metricsDictionary = nil;
}


- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
