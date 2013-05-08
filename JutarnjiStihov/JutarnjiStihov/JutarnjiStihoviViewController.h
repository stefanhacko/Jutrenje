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

-(void)zoom:(UIPinchGestureRecognizer *)rec;

@end
