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
    self.countries = [[userDefaults dictionaryForKey:@"clist"] mutableCopy];
    
    // If no saved data, init with empty object.
    if (!self.countries)
    {
        self.countries = [[NSMutableDictionary alloc] init];
    }
    
    NSLog(@"%@", self.countries);
    
    // Update missing countries in self.countries
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"csv"];
    NSString *fileContents = [NSString stringWithContentsOfFile:filePath];
    
    for (NSString *line in [fileContents componentsSeparatedByString: @"\n"])
    {
        NSArray *items = [line componentsSeparatedByString:@","];
        if ([items count] < 2) break;
        if ([self.countries objectForKey:items[0]] == nil)
        {
            NSMutableDictionary *c = [[NSMutableDictionary alloc] init];
            [c setValue:items[1] forKey:@"continent"];
            [c setValue:[NSNumber numberWithInt:0] forKey:@"wins"];
            [c setValue:[NSNumber numberWithInt:0] forKey:@"losses"];
            [c setValue:[NSNumber numberWithInt:0] forKey:@"skips"];

            [self.countries setValue:c forKey:items[0]];
        }
    }
    
    // Construct countryList and numOfCountries
    self.countryList = [[NSMutableArray alloc] init];
    for (NSString *key in self.countries)
    {
        NSLog(@"essai: %@", key);
        [self.countryList addObject:key];
        self.numOfCountries++;
    }
    
    // Save data
    [self saveData];

    return self;
}

- (NSMutableDictionary*)generateSummary
{
    NSMutableDictionary *summary = [[NSMutableDictionary alloc ] init];
    
    for (NSString *country in self.countries)
    {
        NSDictionary *countryDict = [self.countries objectForKey:country];
        NSString *continent =[countryDict objectForKey:@"continent"];
        
        if ([summary objectForKey:country] == nil)
        {
            [summary setValue:[[NSMutableDictionary alloc] init] forKeyPath:continent];
        }
        
        // Update success for continent
        int success = [[summary valueForKeyPath:[NSString stringWithFormat:@"%@.success", continent]] integerValue];
        success += [[countryDict objectForKey:@"wins"] integerValue];
        [summary setValue:[NSNumber numberWithInt:success]
               forKeyPath:[NSString stringWithFormat:@"%@.success", continent]];
        
        // Update fail for continent
        int fail = [[summary valueForKeyPath:[NSString stringWithFormat:@"%@.fail", continent]] integerValue];
        fail += [[countryDict objectForKey:@"losses"] integerValue];
        [summary setValue:[NSNumber numberWithInt:fail]
               forKeyPath:[NSString stringWithFormat:@"%@.fail", continent]];
        
        // Update number of countries for continent
        int numOfCountries = [[summary valueForKeyPath:[NSString stringWithFormat:@"%@.numOfCountries", continent]] integerValue];
        [summary setValue:[NSNumber numberWithInt:numOfCountries + 1]
               forKeyPath:[NSString stringWithFormat:@"%@.numOfCountries", continent]]; 
    }
        
    
    return summary;
    
}

- (void)saveData
{
    [[NSUserDefaults standardUserDefaults] setObject:self.countries forKey:@"clist"];
}

- (NSString *)getNextQuestion
{
    
    //NSLog(@"essai: %d", arc4random() % self.numOfCountries);
    //NSLog(@"essai: %@", self.countryList[1]);
    return self.countryList[arc4random() % self.numOfCountries];
}

- (void)skipped:(NSString *)country
{
    if (country == nil) return;
    NSInteger number = [[[self.countries objectForKey:country] objectForKey:@"skips"] integerValue];
    number+=1;
    [self.countries[country] setValue:[NSNumber numberWithInt:number] forKey:@"skips"];
    
    [self saveData];

}

- (void)answeredRight:(NSString *)country
{
    if (country == nil) return;
    NSInteger number = [[[self.countries objectForKey:country] objectForKey:@"wins"] integerValue];
    number+=1;
    [self.countries[country] setValue:[NSNumber numberWithInt:number] forKey:@"wins"];
    
    [self saveData];
    
}

- (void)answeredWrong:(NSString *)country
{

    if (country == nil) return;
    NSInteger number = [[[self.countries objectForKey:country] objectForKey:@"losses"] integerValue];
    number+=1;
    [self.countries[country] setValue:[NSNumber numberWithInt:number] forKey:@"losses"];
    
    [self saveData];
    
}





// assume a filename of file.txt. Update as needed

//NSLog(filePath);

@end
