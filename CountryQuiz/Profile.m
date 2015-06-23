//
//  CountryList.m
//  CountryQuiz
//
//  Created by Afsheen Ghorashy on 2015-06-22.
//  Copyright (c) 2015 Afsheen Ghorashy. All rights reserved.
//

#import "Profile.h"

@implementation Profile

- (instancetype)init
{
    // Load saved data
        // NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        // NSString *filePathDictionary = [documents[0] stringByAppendingPathComponent:@"profile.plist"];
        //self.clist = [NSMutableDictionary dictionaryWithContentsOfFile:filePathDictionary];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.clist = [[userDefaults dictionaryForKey:@"clist"] mutableCopy];
    
    // If no saved data, init with empty object.
    if (!self.clist)
    {
        self.clist = [[NSMutableDictionary alloc] init];
    }
    
    NSLog(@"%@", self.clist);
    
    // Update missing countries
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"csv"];
    NSString *fileContents = [NSString stringWithContentsOfFile:filePath];
    
    for (NSString *line in [fileContents componentsSeparatedByString: @"\n"])
    {
        NSArray *items = [line componentsSeparatedByString:@","];
        if ([items count] < 2) break;
        if ([self.clist objectForKey:items[0]] == nil)
        {
            NSMutableDictionary *c = [[NSMutableDictionary alloc] init];
            [c setValue:items[1] forKey:@"continent"];
            [c setValue:[NSNumber numberWithInt:0] forKey:@"tries"];
            [c setValue:[NSNumber numberWithInt:0] forKey:@"wins"];
            [c setValue:[NSNumber numberWithInt:0] forKey:@"losses"];
            [c setValue:[NSNumber numberWithInt:0] forKey:@"skips"];

            [self.clist setValue:c forKey:items[0]];
        }
    }
    
    
    // Save data
    [[NSUserDefaults standardUserDefaults] setObject:self.clist forKey:@"clist"];

    

    

    
    return self;
    
}





// assume a filename of file.txt. Update as needed

//NSLog(filePath);

@end
