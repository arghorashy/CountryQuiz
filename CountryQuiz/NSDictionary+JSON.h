//
//  NSString+JSON.h
//  CountryQuiz
//
//  Created by Afsheen Ghorashy on 2015-06-22.
//  Copyright (c) 2015 Afsheen Ghorashy. All rights reserved.
//

// Thanks to http://stackoverflow.com/questions/6368867/generate-json-string-from-nsdictionary

#import <Foundation/Foundation.h>

@interface NSDictionary (JSON)

-(NSString*) jsonStringWithPrettyPrint:(BOOL) prettyPrint;

@end
