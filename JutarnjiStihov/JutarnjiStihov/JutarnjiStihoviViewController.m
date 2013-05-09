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
    TextReader *probni;
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
    
    _datapicker.date = [NSDate date];
    
    probni = [[TextReader alloc] initWithMonth:@"Januar"];
    NSAttributedString *prob = [probni vratiFormatiranDan:2];
    
    [_tekst setAttributedText:prob];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)promeniTekst:(id)sender
{
    _dugmePromena.enabled = NO;
    _datapicker.hidden=YES;
}
- (IBAction)izaberiDatum:(id)sender
{
    _datapicker.hidden = NO;
    _dugmePromena.enabled = YES;
}

-(void)zoom:(UIPinchGestureRecognizer *)rec
{
    CGFloat scl = 2*rec.velocity;
    [_tekst setAttributedText:[probni skalirajTekst:scl]];
}

-(BOOL)shouldAutorotate
{
    return YES;
}

@end
