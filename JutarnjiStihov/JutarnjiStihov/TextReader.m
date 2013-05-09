//
//  TextReader.m
//  JutarnjiStihov
//
//  Created by Stefan Hacko on 5/9/13.
//  Copyright (c) 2013 Stefan Hacko. All rights reserved.
//

#import "TextReader.h"
@interface TextReader()
{
    @private
    NSString *ulazniFajl;
    NSArray *listaDana;
   
}
@end

@implementation TextReader

-(TextReader *)initWithMonth:(NSString *)mesec
{
    self = [super init];
    
    NSString *putanja = [[NSBundle mainBundle] pathForResource:mesec ofType:@"txt"];
    
    ulazniFajl = [NSString stringWithContentsOfFile:putanja encoding:NSUTF8StringEncoding error:nil];
    
    listaDana = [ulazniFajl componentsSeparatedByString:@"**********"];
    return self;
}

-(NSArray *)vratiDan:(int)d
{
    NSString *dan = [listaDana objectAtIndex:d];
    NSArray *rastavljenDan = [dan componentsSeparatedByString:@"\n\n\n"];
    
    return rastavljenDan;
}

@end
