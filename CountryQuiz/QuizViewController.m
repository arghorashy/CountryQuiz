//
//  QuizViewController.m
//  CountryQuiz
//
//  Created by Afsheen Ghorashy on 2015-06-22.
//  Copyright (c) 2015 Afsheen Ghorashy. All rights reserved.
//

#import "QuizViewController.h"

@interface QuizViewController ()

@property (nonatomic) NSString *last;
@property (nonatomic, weak) IBOutlet UIImageView *countryImage;
@property (nonatomic) Profile *p;

@end

@implementation QuizViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // [self loadQuestion];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadQuestion
{
    
    NSString *name;
    
    while (name == nil || name == self.last)
    {
        name = [self.p getNextQuestion];
    }
    
    self.last = name;
    self.countryImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", name]];
    
    
}

- (IBAction)skipQuestion:(id)sender
{
    [self.p skipped:self.last];
    [self loadQuestion];
}

-  (instancetype)initWithNibName:(NSString *)nibname
                          bundle:(NSBundle *)bundle
                         profile:(Profile *)p
{
    self = [super initWithNibName:nibname
                           bundle:bundle];
    
    self.p = p;
    
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
