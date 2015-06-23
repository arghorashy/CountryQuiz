//
//  QuizViewController.h
//  CountryQuiz
//
//  Created by Afsheen Ghorashy on 2015-06-22.
//  Copyright (c) 2015 Afsheen Ghorashy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Profile.h"

@interface QuizViewController : UIViewController <UITextFieldDelegate>
// N.B. Added delegate to intercept enter press in UITextField



-  (instancetype)initWithNibName:(NSString *)nibname
                          bundle:(NSBundle *)bundle
                         profile:(Profile *)p;

- (void)resetAfterQuestion;

@end
