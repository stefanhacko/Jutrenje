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
    CGFloat scl = rec.velocity;
    
    if (lastSize<minSize)
    {
        lastSize=minSize;
        return;
    }
    
    else if (lastSize >maxSize)
    {
        lastSize=maxSize;
        return;
    }
    
    else
    {
        
        if (lastSize+scl>maxSize) {
            [_tekst setFont:[UIFont fontWithName:@"Arial" size:maxSize]];
            
        }
        
        else if (lastSize+scl<minSize)
        {
            [_tekst setFont:[UIFont fontWithName:@"Arial" size:minSize]];
        }
        
        else
        {
            [_tekst setFont:[UIFont fontWithName:@"Arial" size:lastSize+scl]];
        }
        
        lastSize+=scl;
    }
    
    
}

-(BOOL)shouldAutorotate
{
    return YES;
}

@end
