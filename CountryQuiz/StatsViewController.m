//
//  StatsViewController.m
//  CountryQuiz
//
//  Created by Afsheen Ghorashy on 2015-06-23.
//  Copyright (c) 2015 Afsheen Ghorashy. All rights reserved.
//

#import "StatsViewController.h"

@interface StatsViewController ()

@property (nonatomic, weak) IBOutlet MCBarChartView *barChart;

@property (nonatomic) NSMutableArray *chartValues;
@property (nonatomic) UIColor *mainColor;
@property (strong, nonatomic) UIFont *xAxisLabelFont;

@property (nonatomic) Profile *profile;
@property (nonatomic) NSMutableDictionary *profileSummary;
@property (nonatomic) NSArray *continents;
@property (nonatomic) NSMutableArray *successPercentages;

@end

@implementation StatsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self updateBarChart];
}

- (void)viewWillAppear:(BOOL)animated
{
    //[super viewDidAppear:true];
    
    [self updateBarChart];
}

- (void)updateBarChart
{
    // set the interface main color
    self.mainColor = [UIColor grayColor];
    
    // starts with the first column selected
    //selectedIndex = 0;
    
    self.profileSummary = [self.profile generateSummary];
    
    // Both indexed the same way
    self.chartValues = [[NSMutableArray alloc] init];
    self.continents = [[self.profileSummary allKeys]
                       sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];

    for (NSString *continent in self.continents)
    {
        float success = [[self.profileSummary valueForKeyPath:
                          [NSString stringWithFormat:@"%@.success", continent]] floatValue];
        float fail = [[self.profileSummary valueForKeyPath:
                       [NSString stringWithFormat:@"%@.fail", continent]] floatValue];
        
        float successPercentage;
        if (success + fail == 0)
        {
            successPercentage = 0;
        }
        else
        {
            successPercentage = (success / (success + fail)) * 100;
            
        }
        [self.chartValues addObject:[NSNumber numberWithFloat:successPercentage]];
    }
    
    // set data source and delegate
    self.barChart.dataSource = self;
    self.barChart.delegate = self;
    
    // customization properties
    self.barChart.cornerRadiusPercentage = 0.5;
    self.barChart.showXAxisLabels = YES;
    self.barChart.backBarColor = [[UIColor redColor] colorWithAlphaComponent:0.03];
    self.barChart.interBarSpace = 5; // in pixels.
    //    self.barChart.showXAxisDecorationElement = NO;
    
    
    // This property will be ignored, since the data source is
    // implementing the method barCharView: colorForBarAtIndex:
    // The yellow color will apply if the data source doesn't
    // implement the color method.
    self.barChart.barColor = [UIColor blueColor];
    
    [self.barChart setNeedsDisplay];
}

#pragma mark - Bar Chart View data source

- (NSInteger)numberOfBarsInBarChartView:(MCBarChartView*)barChartView
{
    return self.chartValues.count;
}

- (CGFloat)barCharView:(MCBarChartView*)barChartView valueForBarAtIndex:(NSInteger)index
{
    return [[self.chartValues objectAtIndex:index] floatValue];
}

- (NSString*)barCharView:(MCBarChartView*)barChartView textForXAxisAtIndex:(NSInteger)index
{
    return self.continents[index];
}

- (NSString*)barCharView:(MCBarChartView*)barChartView textForYAxisAtIndex:(NSInteger)index
{
    return [NSString stringWithFormat:@"%d%%", [self.chartValues[index] integerValue]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-  (instancetype)initWithNibName:(NSString *)nibname
                          bundle:(NSBundle *)bundle
                         profile:(Profile *)p
{
    self = [super initWithNibName:nibname
                           bundle:bundle];
    
    if (self) {
        self.profile = p;
        
        // Get the tab bar item
        UITabBarItem *tbi = self.tabBarItem;
        
        // Give it a label
        tbi.title = @"Stats";
        
        // Give it an image
        UIImage *i = [UIImage imageNamed:@"Pie.png"];
        tbi.image = i;
    }
    
    return self;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
