//
//  MainScreenTableViewCell.h
//  CITASK
//
//  Created by Atit Modi on 11/18/14.
//  Copyright (c) 2014 Atit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainScreenTableViewCell : UITableViewCell

{
    //this dictinary will contain all the views which needs contraints
    NSMutableDictionary     *viewsDictionary;
    
    //this dictinary will contain calculation required according to view
    NSDictionary            *metricsDictionary;
}

@property(strong, nonatomic) UIImageView *imageForLogo;
@property(strong, nonatomic) UILabel *labelOutletName;
@property(strong, nonatomic) UILabel *labelOffers;
@property(strong, nonatomic) UILabel *labelCategoryNameOne;
@property(strong, nonatomic) UILabel *labelDistance;
@property(strong, nonatomic) UIImageView *imageForDistance;
@property(strong, nonatomic) UILabel *labelNeighbourhoodName;


@end
