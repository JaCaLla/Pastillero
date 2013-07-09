//
//  ViewController.m
//  ePills
//
//  Created by JAVIER CALATRAVA LLAVERIA on 06/07/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "PrescriptionControllerCellView.h"

static ViewController *sharedInstance;

@interface ViewController ()

@end

@implementation ViewController

@synthesize arrPrescriptions;
@synthesize idxPrescriptions;

-(id) init{
    if(sharedInstance){
        NSLog(@"Error: You are creating a second AppDelegate. Bad Panda!");
    }
    
    self=[super init];
    
    //Initialize singleton class
    sharedInstance=self;
    

    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //Link collection view to this class
    [self.clvPrescriptions setDataSource:self];
    [self.clvPrescriptions setDelegate:self];
    
    sharedInstance=self;
    
    AppDelegate *appDelegate = [AppDelegate sharedAppDelegate];
    NSArray *arrCoreTimers = [appDelegate allPrescriptions];

    arrPrescriptions = [arrCoreTimers mutableCopy];
    NSLog(@"Timers: %d",[arrPrescriptions count]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)updatePrescription:(id)sender {
}

// BEGIN: Methods to implement for fulfill CollectionView Interface
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView {
    // _data is a class member variable that contains one array per section.
    return 1;
}

- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [arrPrescriptions count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CellPrescriptionId";
    
    
    PrescriptionControllerCellView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.txtName.text = [NSString stringWithFormat:@"Section:%d, Item:%d", indexPath.section, indexPath.item];
    
    return cell;

}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{


    //Set the current seleted index timer
    idxPrescriptions=indexPath.item;
    

    
}
//end: Methods to implement for fulfill CollectionView Interface

@end
