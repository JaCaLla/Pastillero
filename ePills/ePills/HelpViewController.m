//
//  HelpViewController.m
//  ePills
//
//  Created by JAVIER CALATRAVA LLAVERIA on 30/08/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController ()



@end



@implementation HelpViewController

@synthesize iCurrView;
@synthesize svwList;
@synthesize svwAdd;
@synthesize svwUpdate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    // Set the view initial state
    iCurrView=0;
    
    //Set up visible different subvews
    self.svwList.hidden=NO;
    self.svwAdd.hidden=YES;
    self.svwUpdate.hidden=YES;
    
    //Setup Swipe events:Left
    UISwipeGestureRecognizer *swapLeft =[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(viewSwipedLeft)];
    swapLeft.numberOfTouchesRequired=1;
    swapLeft.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swapLeft];
    
    //...and right
    UISwipeGestureRecognizer *swapRight =[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(viewSwipedRight)];
    swapRight.numberOfTouchesRequired=1;
    swapRight.direction=UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swapRight];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Callback called after swipe left
- (void)viewSwipedRight {
    iCurrView-=1;
    if(iCurrView<0) iCurrView=0;
    else [self showView];
    
}

//Callback called after swipe right
- (void)viewSwipedLeft {
    iCurrView+=1;
    if(iCurrView>2) iCurrView=2;
    else [self showView];
}


-(void) showView{
    
    switch (iCurrView) {
        case 0:
            self.svwList.hidden=NO;
            self.svwAdd.hidden=YES;
            self.svwUpdate.hidden=YES;
            [UIView transitionWithView:svwList
                              duration:1.0
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:^{}
                            completion:nil];
            break;
        case 1:
            self.svwList.hidden=YES;
            self.svwAdd.hidden=NO;
            self.svwUpdate.hidden=YES;
            [UIView transitionWithView:svwAdd
                              duration:1.0
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:^{}
                            completion:nil];
            
            break;
        case 2:
            self.svwList.hidden=YES;
            self.svwAdd.hidden=YES;
            self.svwUpdate.hidden=NO;
            [UIView transitionWithView:svwUpdate
                              duration:1.0
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:^{}
                            completion:nil];
            break;
        default:
            break;
    }
}


@end
