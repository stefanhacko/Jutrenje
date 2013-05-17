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
    NSArray *listaMeseci;
    TextReader *readerTeksta;
}
@end

@implementation JutarnjiStihoviViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    listaMeseci = [NSArray arrayWithObjects:@"Januar",@"Februar",@"Mart",@"April",@"Maj",
                   @"Jun",@"Jul",@"Avgust",@"Septembar",@"Oktobar",@"Novembar",@"Decembar", nil];
    
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
    
     NSString *naslov = [NSString stringWithFormat:@"%d. %@",danBroj,[listaMeseci objectAtIndex:mesecBroj-1]];
    [[_navBar.items objectAtIndex:0] setTitle:naslov];
    
    
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
    
    NSDateFormatter *mesec = [[NSDateFormatter alloc] init];
    [mesec setDateFormat:@"MM"];
    int mesecBroj = [[mesec stringFromDate:datumZaMenjanje] intValue];
    
    NSDateFormatter *dan = [[NSDateFormatter alloc] init];
    [dan setDateFormat:@"dd"];
    int danBroj = [[dan stringFromDate:datumZaMenjanje] intValue];
    
    _tekst.attributedText = [readerTeksta trenutanTekst];
    NSString *naslov = [NSString stringWithFormat:@"%d. %@",danBroj,[listaMeseci objectAtIndex:mesecBroj-1]];
    
    [[_navBar.items objectAtIndex:0] setTitle:naslov];
}

- (IBAction)skloniKalendar:(id)sender {
    _dugmePromena.hidden = YES;
    _datapicker.hidden = YES;
}
- (IBAction)izaberiDatum:(id)sender
{

    if (_datapicker.hidden == NO)
    {
        _datapicker.hidden = YES;
        _dugmePromena.hidden = YES;
    }
    else
    {
        _datapicker.hidden = NO;
        _dugmePromena.hidden = NO;
    }
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
