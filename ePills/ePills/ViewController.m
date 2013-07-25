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
#import "UpdatePrescriptionViewController.h"

static ViewController *sharedInstance;

@interface ViewController ()

@end

@implementation ViewController

@synthesize arrPrescriptions;

@synthesize tDosis;



-(id) init{
    if(sharedInstance){
        NSLog(@"Error: You are creating a second AppDelegate. Bad Panda!");
    }
    
    self=[super init];
    
    //Initialize singleton class
    sharedInstance=self;
    

    
    return self;
}

//Return a reference of this class
+(ViewController *) sharedViewController{
    
    return sharedInstance;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //Hide Segue update button
    [self.btnSegueUpdate setHidden:YES];
    
    //Link collection view to this class
    [self.tbvPrescriptions setDataSource:self];
    [self.tbvPrescriptions setDelegate:self];
    
    //???
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


// BEGIN: Methods to implement for fulfill CollectionView Interface
/*
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


-(IBAction)myClickEvent:(id)sender event:(id)event {
    
    
    NSLog(@"myClickEvent");
    
}


-(void)buttonAction:(UIButton*)button {

     NSLog(@"buttonUpdatePrescription");   
    
}


-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{


    //Set the current seleted index timer
    idxPrescriptions=indexPath.item;
    

    
}
 */
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [arrPrescriptions count];
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"CellPrescriptionId";
//    PrescriptionControllerCellView *tmrCurrent;
    
    PrescriptionControllerCellView *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[PrescriptionControllerCellView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
   
    Prescription* tmrCurrent=[arrPrescriptions objectAtIndex:[indexPath row]];
    
    //[[cell textLabel]setText:[NSString stringWithFormat:@"Section:%d, Item:%d", indexPath.section, indexPath.item]];
    
    //[cell.txtName setText:tmrCurrent.sName];
    [cell.txtName setText:[NSString stringWithFormat:@"%@[%d] UT:%d D:%d",tmrCurrent.sName,tmrCurrent.iBoxUnits,tmrCurrent.iUnitsTaken,tmrCurrent.tDosis]];
    //cell.txtDosis.text=[NSString stringWithFormat:@"%d",tmrCurrent.iDosis];
    
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    //Set the current seleted index timer
    //idxPrescriptions=indexPath.item;
    
    //Notify the model
    AppDelegate *appDelegate = [AppDelegate sharedAppDelegate];
    appDelegate.idxPrescriptions=indexPath.item;
    
    NSLog(@"Row Selected = %i",appDelegate.idxPrescriptions);
    
    [self performSegueWithIdentifier:@"updatePrescription" sender:self.view];

    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"updatePrescription"]){
        
            NSLog(@"prepareForSegue");
        
        //Notify the model
        AppDelegate *appDelegate = [AppDelegate sharedAppDelegate];
        
        //Get se
        Prescription *currPrescription =[arrPrescriptions objectAtIndex:appDelegate.idxPrescriptions];

        
        // Get destination view
        UpdatePrescriptionViewController *vc = [segue destinationViewController];
        
        //Update view fields
        vc.sName= currPrescription.sName;
        vc.sBoxUnits=[NSString stringWithFormat:@"%d", currPrescription.iBoxUnits];
        vc.sUnitsTaken=[NSString stringWithFormat:@"%d", currPrescription.iUnitsTaken];
        


    }
}

//end: Methods to implement for fulfill CollectionView Interface

- (IBAction)btnUpdatePrescription:(id)sender {
  
    //ViewController *viewController=[ViewController sharedViewController];
    
    //NSIndexPath *indPath=[viewController.clvPrescriptions indexPathForCell:self];
    
    //NSLog(@"Cell:%d",indPath.row);
    NSLog(@"buttonUpdatePrescription");
}





@end
