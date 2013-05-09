//
//  JutarnjiStihoviViewController.h
//  JutarnjiStihov
//
//  Created by Stefan Hacko on 5/8/13.
//  Copyright (c) 2013 Stefan Hacko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JutarnjiStihoviViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *tekst;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *datum;
@property (weak, nonatomic) IBOutlet UIDatePicker *datapicker;
@property (weak, nonatomic) IBOutlet UIButton *dugmePromena;


- (IBAction)izaberiDatum:(id)sender;
- (IBAction)promeniTekst:(id)sender;
- (void)zoom:(UIPinchGestureRecognizer *)rec;

@end
