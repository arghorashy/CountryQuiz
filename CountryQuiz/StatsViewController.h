//
//  StatsViewController.h
//  CountryQuiz
//
//  Created by Afsheen Ghorashy on 2015-06-23.
//  Copyright (c) 2015 Afsheen Ghorashy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCBarChartView.h"
#import "Profile.h"

@interface StatsViewController : UIViewController <MCBarChartViewDataSource, MCBarChartViewDelegate>

-  (instancetype)initWithNibName:(NSString *)nibname
                          bundle:(NSBundle *)bundle
                         profile:(Profile *)p;

@end
