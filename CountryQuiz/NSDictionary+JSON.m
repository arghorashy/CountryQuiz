//
//  NSString+JSON.m
//  CountryQuiz
//
//  Created by Afsheen Ghorashy on 2015-06-22.
//  Copyright (c) 2015 Afsheen Ghorashy. All rights reserved.
//

// Thanks to http://stackoverflow.com/questions/6368867/generate-json-string-from-nsdictionary

#import "NSDictionary+JSON.h"

@implementation NSDictionary (JSON)

-(NSString*) jsonStringWithPrettyPrint:(BOOL) prettyPrint
{
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:(NSJSONWritingOptions)    (prettyPrint ? NSJSONWritingPrettyPrinted : 0)
                                                         error:&error];
    
    if (! jsonData)
    {
        NSLog(@"bv_jsonStringWithPrettyPrint: error: %@", error.localizedDescription);
        return @"{}";
    }
    else
    {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}
@end
