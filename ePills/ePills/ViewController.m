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
    
    //Request to AppDelegate the array of timers
    AppDelegate *appDelegate = [AppDelegate sharedAppDelegate];
    //NSArray *arrCoreTimers = [appDelegate allPrescriptions];
    arrPrescriptions = [appDelegate allPrescriptions];
    
    // Remove table cell separator
    [self.tbvPrescriptions setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    // Assign our own backgroud for the view
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"common_bg"]];
    self.tbvPrescriptions.backgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"common_bg"]];
    self.tbvPrescriptions.backgroundColor = [UIColor clearColor];
    
    // Add padding to the top of the table view
    UIEdgeInsets inset = UIEdgeInsetsMake(5, 0, 0, 0);
    self.tbvPrescriptions.contentInset = inset;
    


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
    
    PrescriptionControllerCellView *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[PrescriptionControllerCellView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
   
    Prescription* tmrCurrent=[arrPrescriptions objectAtIndex:[indexPath row]];
    
    [cell.txtName setText:[NSString stringWithFormat:@"%@[%d]",tmrCurrent.sName,tmrCurrent.iBoxUnits]];
    
    [cell.lblNextDose setText:tmrCurrent.getStringRemaining];
    if(tmrCurrent.bPrescriptionHasStarted){
        cell.lblNextDose.textColor = [UIColor blackColor];
    }
    else {
        cell.lblNextDose.textColor = [UIColor redColor];
    }
    
    //Image
    if(tmrCurrent.dChosenImage==nil){
        cell.imageView.image=nil;
    }
    else{
        //NSData *nsData=[self dataWithBase64EncodedString:currPrescription.dChosenImage];
        NSData *nsData=tmrCurrent.dChosenImage;

        
        cell.imageView.image =[UIImage imageWithData:nsData];
        cell.imageView.image =[self scaled:cell.imageView.image  toSize:CGSizeMake(70, 50)];
       // [cell.imageView sizeToFit];
       
    
    }
    
    //UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageName:@"myimage.png"]];
    //[imageView sizeToFit];
    
    //CGRect newFrame = imageView.frame;
    //if (newFrame.size.width > 100) newFrame.size.width = 100;
    //imageView.frame = newFrame;

    // Assign our own background image for the cell
    UIImage *background = [self cellBackgroundForRowAtIndexPath:indexPath];
    
    UIImageView *cellBackgroundView = [[UIImageView alloc] initWithImage:background];
    cellBackgroundView.image = background;
    cell.backgroundView = cellBackgroundView;
    
    return cell;
    
}

- (UIImage *)scaled:(UIImage *)image toSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    //Set the current seleted index timer
    //idxPrescriptions=indexPath.item;
    
    //Notify the model
    AppDelegate *appDelegate = [AppDelegate sharedAppDelegate];
    appDelegate.idxPrescriptions=indexPath.item;
    
    NSLog(@"Row Selected = %i",appDelegate.idxPrescriptions);
    
    //[self performSegueWithIdentifier:@"updatePrescription" sender:self.view];

    [self performSegueWithIdentifier:@"updatePrescription2" sender:self.view];

    
}

- (UIImage *)cellBackgroundForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSInteger rowCount = [self tableView:[self tableView] numberOfRowsInSection:0];
    NSInteger rowCount = [arrPrescriptions count];
    NSInteger rowIndex = indexPath.row;
    UIImage *background = nil;
    
    if (rowIndex == 0) {
        background = [UIImage imageNamed:@"cell_top.png"];
    } else if (rowIndex == rowCount - 1) {
        background = [UIImage imageNamed:@"cell_bottom.png"];
    } else {
        background = [UIImage imageNamed:@"cell_middle.png"];
    }
    
    return background;
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"updatePrescription"]){
        
        //??
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
   // else if([segue.identifier isEqualToString:@"updatePrescription2"]){
 
        //Notify the model
        //AppDelegate *appDelegate = [AppDelegate sharedAppDelegate];
        
        //Get se
        //Prescription *currPrescription =[arrPrescriptions objectAtIndex:appDelegate.idxPrescriptions];
        
        
        // Get destination view
        //UpdatePrescriptionViewController *vc = [segue destinationViewController];
        
        //Update view fields
        //vc.sName= currPrescription.sName;
        //vc.sBoxUnits2=[NSString stringWithFormat:@"%d", currPrescription.iBoxUnits];
        //vc.sUnitsTaken2=[NSString stringWithFormat:@"%d", currPrescription.iUnitsTaken];

 //   }
}

//end: Methods to implement for fulfill CollectionView Interface

- (IBAction)btnUpdatePrescription:(id)sender {
  
    //ViewController *viewController=[ViewController sharedViewController];
    
    //NSIndexPath *indPath=[viewController.clvPrescriptions indexPathForCell:self];
    
    //NSLog(@"Cell:%d",indPath.row);
    NSLog(@"buttonUpdatePrescription");
}

//Refresh view. Request AppDelegate for the array of prescriptions and update the view
-(void) updateView{
    
    //Request to AppDelegate the array of timers
    AppDelegate *appDelegate = [AppDelegate sharedAppDelegate];
    NSArray *arrCoreTimers = [appDelegate allPrescriptions];
    
    // Array is only copied when the differs from the amount of timers defined in the AppDelegate
    if([arrPrescriptions count]!=[arrCoreTimers count])
        arrPrescriptions = [arrCoreTimers mutableCopy];
    
    // Reload table data
    [self.tbvPrescriptions reloadData];
}




@end
