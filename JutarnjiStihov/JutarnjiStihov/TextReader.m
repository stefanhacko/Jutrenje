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
    NSUInteger mesec;
    NSString *ulazniFajl;
    NSArray *listaDana;
    NSArray *listaMeseci;
    NSMutableAttributedString *trenutniTekst;
    
    int minNaslov;
    int maxNaslov;
    int minStih;
    int maxStih;
    int minTekst;
    int maxTekst;
    
    float lastNaslov;
    float lastStih;
    float lastTekst;
    
    int trenutnaDuzinaNaslova;
    int trenutnaDuzinaStiha;
    int trenutnaDuzinaTeksta;
    
    int trenutanMesec;
    int trenutanDan;
   
}
-(void)setujParametre;
-(void)napraviMesece;
-(void)postaviTrenutanDan:(int)d;

@end

@implementation TextReader

-(void)napraviMesece
{
    listaMeseci = [NSArray arrayWithObjects:@"Januar",@"Februar",@"Mart",@"April",@"Maj",
                   @"Jun",@"Jul",@"Avgust",@"Septembar",@"Oktobar",@"Novembar",@"Decembar", nil];
}

-(void)setujParametre
{
    minNaslov = 20;
    maxNaslov = 50;
    minStih = 18;
    maxStih = 48;
    minTekst = 16;
    maxTekst = 46;
    
    lastNaslov = minNaslov;
    lastTekst = minTekst;
    lastStih = minStih;
}
-(void) postaviTrenutanDan:(int)d
{
    NSArray *neFormatiranTekst = [self vratiDan:d];
    
    trenutniTekst = [[NSMutableAttributedString alloc] initWithString:[[neFormatiranTekst objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(1, 3)]] componentsJoinedByString:@"\n\n"]];
    
    NSDictionary *formtNaslova = @{NSFontAttributeName: [UIFont fontWithName:@"Helvetica-Bold" size:lastNaslov]};
    NSDictionary *formatStiha = @{NSFontAttributeName: [UIFont fontWithName:@"Helvetica-Oblique" size:lastStih]};
    NSDictionary *formatTeksta = @{NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:lastTekst]};
    
    trenutnaDuzinaNaslova = [[neFormatiranTekst objectAtIndex:1] length];
    trenutnaDuzinaStiha = [[neFormatiranTekst objectAtIndex:2] length];
    trenutnaDuzinaTeksta = [[neFormatiranTekst objectAtIndex: 3] length];
    
    [trenutniTekst setAttributes:formtNaslova range:NSMakeRange(0, trenutnaDuzinaNaslova)];
    [trenutniTekst setAttributes:formatStiha range:NSMakeRange(trenutnaDuzinaNaslova+2, trenutnaDuzinaStiha)];
    [trenutniTekst setAttributes:formatTeksta range:NSMakeRange(trenutnaDuzinaNaslova+trenutnaDuzinaStiha+4, trenutnaDuzinaTeksta)];
}

-(void)promeniDan:(int)d
{
    [self postaviTrenutanDan:d];
}

-(TextReader *)initWithMonth:(int)m
{
    self = [super init];
    [self napraviMesece];
    
    trenutanMesec = m;
    
    NSString *putanja = [[NSBundle mainBundle] pathForResource:[listaMeseci objectAtIndex: m-1] ofType:@"txt"];
    
    ulazniFajl = [NSString stringWithContentsOfFile:putanja encoding:NSUTF8StringEncoding error:nil];
    
    listaDana = [ulazniFajl componentsSeparatedByString:@"**********"];
    
    [self setujParametre];
    
    return self;
}

- (TextReader *)init
{
    self = [super init];
    [self setujParametre];
    
    return self;
}

- (void)promeniMesec:(int)m
{
    if (trenutanMesec!=m) {
        NSString *putanja = [[NSBundle mainBundle] pathForResource:[listaMeseci objectAtIndex: m-1] ofType:@"txt"];
        
        ulazniFajl = [NSString stringWithContentsOfFile:putanja encoding:NSUTF8StringEncoding error:nil];
        
        listaDana = [ulazniFajl componentsSeparatedByString:@"**********"];
        
        trenutanMesec = m;
    }

}

-(NSArray *)vratiDan:(int)d
{
    NSString *dan = [listaDana objectAtIndex:d];
    NSArray *rastavljenDan = [dan componentsSeparatedByString:@"\n\n\n"];
    
    return rastavljenDan;
}
- (NSAttributedString *)trenutanTekst
{
    return trenutniTekst;
}

- (NSAttributedString *)vratiFormatiranDan:(int)d
{
    [self postaviTrenutanDan:d];
    return trenutniTekst;
}

- (NSAttributedString *)skalirajTekst:(float) scl
{
    
    if (lastNaslov < minNaslov)
    {
        lastTekst = minTekst;
        lastStih = minStih;
        lastNaslov = minNaslov;
        return trenutniTekst;
    }
    else if (lastNaslov > maxNaslov)
    {
        lastTekst = maxTekst;
        lastStih = maxStih;
        lastNaslov = maxNaslov;
        return trenutniTekst;
    }
    else
    {
     
        if(lastNaslov+scl > maxNaslov)
        {
            NSDictionary *formtNaslova = @{NSFontAttributeName: [UIFont fontWithName:@"Helvetica-Bold" size:maxNaslov]};
            NSDictionary *formatStiha = @{NSFontAttributeName: [UIFont fontWithName:@"Helvetica-Oblique" size:maxStih]};
            NSDictionary *formatTeksta = @{NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:maxTekst]};
            
            [trenutniTekst setAttributes:formtNaslova range:NSMakeRange(0, trenutnaDuzinaNaslova)];
            [trenutniTekst setAttributes:formatStiha range:NSMakeRange(trenutnaDuzinaNaslova+2, trenutnaDuzinaStiha)];
            [trenutniTekst setAttributes:formatTeksta range:NSMakeRange(trenutnaDuzinaNaslova+trenutnaDuzinaStiha+4, trenutnaDuzinaTeksta)];
            
            lastNaslov+=scl;
            lastStih+=scl;
            lastTekst+=scl;
            
            return trenutniTekst;
        }
        else if (lastNaslov+scl<minNaslov)
        {
            NSDictionary *formtNaslova = @{NSFontAttributeName: [UIFont fontWithName:@"Helvetica-Bold" size:minNaslov]};
            NSDictionary *formatStiha = @{NSFontAttributeName: [UIFont fontWithName:@"Helvetica-Oblique" size:minStih]};
            NSDictionary *formatTeksta = @{NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:minTekst]};
            
            [trenutniTekst setAttributes:formtNaslova range:NSMakeRange(0, trenutnaDuzinaNaslova)];
            [trenutniTekst setAttributes:formatStiha range:NSMakeRange(trenutnaDuzinaNaslova+2, trenutnaDuzinaStiha)];
            [trenutniTekst setAttributes:formatTeksta range:NSMakeRange(trenutnaDuzinaNaslova+trenutnaDuzinaStiha+4, trenutnaDuzinaTeksta)];
            
            lastNaslov+=scl;
            lastStih+=scl;
            lastTekst+=scl;
            
            return trenutniTekst;
        }
        else
        {
            NSDictionary *formtNaslova = @{NSFontAttributeName: [UIFont fontWithName:@"Helvetica-Bold" size:lastNaslov+scl]};
            NSDictionary *formatStiha = @{NSFontAttributeName: [UIFont fontWithName:@"Helvetica-Oblique" size:lastStih +scl]};
            NSDictionary *formatTeksta = @{NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:lastTekst +scl]};
            
            [trenutniTekst setAttributes:formtNaslova range:NSMakeRange(0, trenutnaDuzinaNaslova)];
            [trenutniTekst setAttributes:formatStiha range:NSMakeRange(trenutnaDuzinaNaslova+2, trenutnaDuzinaStiha)];
            [trenutniTekst setAttributes:formatTeksta range:NSMakeRange(trenutnaDuzinaNaslova+trenutnaDuzinaStiha+4, trenutnaDuzinaTeksta)];
            
            lastNaslov+=scl;
            lastStih+=scl;
            lastTekst+=scl;
            
            return trenutniTekst;
        }
    }
}
@end
