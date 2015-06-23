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
@property (nonatomic, weak) IBOutlet UITextField *answerText;
@property (nonatomic, weak) IBOutlet UILabel *feedbackLabel;
@property (nonatomic) Profile *profile;

@end

@implementation QuizViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // N.B. Added here to intercept enter press in UITextField
    self.answerText.delegate = self;
    
    // [self loadQuestion];
}

// N.B. Added here to intercept enter press in UITextField
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    if (theTextField == self.answerText)
    {
        [theTextField resignFirstResponder];
        [self validateAnswer];
    }
    return YES;
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
        name = [self.profile getNextQuestion];
    }
    
    self.last = name;
    self.countryImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", name]];
    
    
}

- (IBAction)skipQuestion:(id)sender
{
    [self.profile skipped:self.last];
    [self loadQuestion];
}

- (void)resetAfterQuestion
{
    self.feedbackLabel.text = @"";
    self.feedbackLabel.backgroundColor = [UIColor clearColor];
    self.feedbackLabel.textColor = [UIColor clearColor];
    
    self.answerText.text = @"";
}

- (void)validateAnswer
{
    NSLog([self.answerText.text lowercaseString]);
    NSLog([self.last lowercaseString]);
    if ([[self.answerText.text lowercaseString] isEqualToString:[self.last lowercaseString]])
    {
        [self.profile answeredRight:self.last];
        
        self.feedbackLabel.text = @"Correct!";
        self.feedbackLabel.backgroundColor = [UIColor greenColor];
        self.feedbackLabel.textColor = [UIColor whiteColor];
        
        [self performSelector:@selector(resetAfterQuestion) withObject:nil afterDelay:2.0];
        
    }
    else
    {
        [self.profile answeredWrong:self.last];
        
        self.feedbackLabel.text = [NSString stringWithFormat:@"The right answer is %@.", self.last];
        self.feedbackLabel.backgroundColor = [UIColor redColor];
        self.feedbackLabel.textColor = [UIColor whiteColor];
        
        [self performSelector:@selector(resetAfterQuestion) withObject:nil afterDelay:2.0];
        
        
    }

    [self performSelector:@selector(loadQuestion) withObject:nil afterDelay:2.0];
    
}



-  (instancetype)initWithNibName:(NSString *)nibname
                          bundle:(NSBundle *)bundle
                         profile:(Profile *)p
{
    self = [super initWithNibName:nibname
                           bundle:bundle];
    
    self.profile = p;
    
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
