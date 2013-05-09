//
//  TextReader.h
//  JutarnjiStihov
//
//  Created by Stefan Hacko on 5/9/13.
//  Copyright (c) 2013 Stefan Hacko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TextReader : NSObject

- (TextReader *)initWithMonth:(NSString *)mesec;
- (NSAttributedString *) vratiFormatiranDan:(int)d;
- (NSAttributedString *)skalirajTekst:(float) scl;
- (NSArray *)vratiDan:(int)d;
@end
