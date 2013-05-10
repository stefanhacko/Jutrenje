//
//  JutarnjiStihoviViewController.m
//  JutarnjiStihov
//
//  Created by Stefan Hacko on 5/8/13.
//  Copyright (c) 2013 Stefan Hacko. All rights reserved.
//

#import "JutarnjiStihoviViewController.h"

@interface JutarnjiStihoviViewController ()
{
    @private
    float lastSize;
    float minSize;
    float maxSize;
    TextReader *readerTeksta;
}
@end

@implementation JutarnjiStihoviViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIPinchGestureRecognizer *recognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(zoom:)];
    
    [self.view addGestureRecognizer:recognizer];
    
    lastSize = 22;
    minSize = 22;
    maxSize = 45;
    
    NSDate *danasnjiDatum = [NSDate date];
    
    
    _datapicker.date = danasnjiDatum;
    _dugmePromena.hidden = YES;
    
    NSDateFormatter *mesec = [[NSDateFormatter alloc] init];
    [mesec setDateFormat:@"MM"];
    int mesecBroj = [[mesec stringFromDate:danasnjiDatum] intValue];
    
    NSDateFormatter *dan = [[NSDateFormatter alloc] init];
    [dan setDateFormat:@"dd"];
    int danBroj = [[dan stringFromDate:danasnjiDatum] intValue];
    
    readerTeksta = [[TextReader alloc] initWithMonth:mesecBroj];
    
    NSAttributedString *pocetniTekst = [readerTeksta vratiFormatiranDan: danBroj];
    
    [_tekst setAttributedText:pocetniTekst];
    
    
}

-(void)pormeniNaDatum:(NSDate *)dat
{
    NSDateFormatter *mesec = [[NSDateFormatter alloc] init];
    [mesec setDateFormat:@"MM"];
    int mesecBroj = [[mesec stringFromDate:dat] intValue];
    
    NSDateFormatter *dan = [[NSDateFormatter alloc] init];
    [dan setDateFormat:@"dd"];
    int danBroj = [[dan stringFromDate:dat] intValue];
    
    [readerTeksta promeniMesec:mesecBroj];
    [readerTeksta promeniDan:danBroj];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)promeniTekst:(id)sender
{
    NSDate *datumZaMenjanje = [sender date];
    [self pormeniNaDatum:datumZaMenjanje];
    
    _tekst.attributedText = [readerTeksta trenutanTekst];
    
}

- (IBAction)skloniKalendar:(id)sender {
    _dugmePromena.hidden = YES;
    _datapicker.hidden = YES;
}
- (IBAction)izaberiDatum:(id)sender
{
    _datapicker.hidden = NO;
    _dugmePromena.hidden = NO;
}

-(void)zoom:(UIPinchGestureRecognizer *)rec
{
    CGFloat scl = 2*rec.velocity;
    [_tekst setAttributedText:[readerTeksta skalirajTekst:scl]];
}

-(BOOL)shouldAutorotate
{
    return YES;
}

@end
