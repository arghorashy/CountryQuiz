//
//  CountryList.h
//  CountryQuiz
//
//  Created by Afsheen Ghorashy on 2015-06-22.
//  Copyright (c) 2015 Afsheen Ghorashy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Profile : NSObject

@property (nonatomic, strong) NSMutableDictionary *countries;
@property (nonatomic, strong) NSMutableArray *countryList;
@property (nonatomic) int numOfCountries;

- (void)saveData;

- (NSString *)getNextQuestion;

- (void)skipped:(NSString *)country;

- (void)answeredRight:(NSString *)country;

- (void)answeredWrong:(NSString *)country;

- (NSMutableDictionary*)generateSummary;

@end
