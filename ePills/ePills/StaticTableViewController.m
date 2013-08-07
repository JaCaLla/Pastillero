//
//  StaticTableViewController.m
//  ePills
//
//  Created by JAVIER CALATRAVA LLAVERIA on 07/07/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import "StaticTableViewController.h"
#import "Prescription.h"
#import "AppDelegate.h"
#import "DosisUpdateTableViewController.h"
#import "Constants.h"

static StaticTableViewController *sharedInstance;

@interface StaticTableViewController ()

@end



@implementation StaticTableViewController

@synthesize btnSave;
@synthesize txtName;
@synthesize txtBoxUnits;
@synthesize txtUnitsTaken;
@synthesize lblLastDosis;
@synthesize lblDose;
@synthesize arrDosis;


@synthesize sName;
@synthesize sBoxUnits;
@synthesize sUnitsTaken;
@synthesize sDosis;

- (id)initWithStyle:(UITableViewStyle)style
{
    if(sharedInstance){
        NSLog(@"Error: You are creating a second AppDelegate. Bad Panda!");
    }
    
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    
    //Initialize singleton class
    sharedInstance=self;
    
    return self;

}

//Return a reference of this class
+(StaticTableViewController *) sharedViewController{
    
    return sharedInstance;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    //Initialize navigation bar buttons
    btnSave.enabled=FALSE;
    
    //Get current prescription from delegate (Model)
    //AppDelegate *appDelegate = [AppDelegate sharedAppDelegate];
    //Prescription *currPrescription = [appDelegate getCurrentPrescription];
    
    sName=@""; //currPrescription.sName;
    sBoxUnits=@"";//[NSString stringWithFormat:@"%d", currPrescription.iBoxUnits];
    sUnitsTaken=@"1";//[NSString stringWithFormat:@"%d", currPrescription.iUnitsTaken];
    sDosis=[NSString stringWithFormat:@"%d", EightHours];
    

    //sDosis=//[NSString stringWithFormat:@"Every %@", [arrDosis objectAtIndex:3]];
    
    
    //Initialize fields
    txtName.text= sName;
    txtBoxUnits.text=sBoxUnits;
    txtUnitsTaken.text=sUnitsTaken;
    //Initialize dosis array
    arrDosis = [NSArray arrayWithObjects:@"1 hour", @"2 hours", @"4 hours", @"8 hours", @"12 hours", @"1 day", @"2 days", @"4 days", @"1 week", @"2 weeks", @"1 month",@"60",@"120",@"240", nil];
    lblDose.text=[NSString stringWithFormat:@"Every %@", [arrDosis objectAtIndex:3]];;
    
    // Assign our own backgroud for the view    
    UIView* bview = [[UIView alloc] init];
    bview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"common_bg.png"]];
    [self.tbvNewPrescription setBackgroundView:bview];
    
    
    
    
    //BEGIN:Number pad removal handling
    // Define a Cancel and Apply button because it does not exists in the numeric pad for Box Units
    UIToolbar* numberToolbarBoxUnits = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbarBoxUnits.barStyle = UIBarStyleBlackTranslucent;
    numberToolbarBoxUnits.items = [NSArray arrayWithObjects:
                                   [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelBoxUnits)],
                                   [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                   [[UIBarButtonItem alloc]initWithTitle:@"Apply" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithBoxUnits)],
                                   nil];
    [numberToolbarBoxUnits sizeToFit];
    txtBoxUnits.inputAccessoryView = numberToolbarBoxUnits;
    
    // Define a Cancel and Apply button because it does not exists in the numeric pad for Box Units
    UIToolbar* numberToolbarDosis = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbarDosis.barStyle = UIBarStyleBlackTranslucent;
    numberToolbarDosis.items = [NSArray arrayWithObjects:
                                [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelUnitsTaken)],
                                [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                [[UIBarButtonItem alloc]initWithTitle:@"Apply" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithUnitsTaken)],
                                nil];
    [numberToolbarDosis sizeToFit];
    txtUnitsTaken.inputAccessoryView = numberToolbarDosis;
    //END:Number pad removal handling
}

//BEGIN:ModelViewDelegat callbacks
- (void)setDosis:(int)p_iDose {
    //Check if there were changes with dosis
    if([sDosis integerValue]!=p_iDose){//txtDosis.text){
        sDosis=[NSString stringWithFormat:@"%d", p_iDose];
        
        //Validate form
        [self validateForm];

    }
}
//END:ModelViewDelegat callbacks

-(void)  validateForm{
    
    btnSave.enabled=([sName length]>0) && ([sBoxUnits length]>0);
    
    //Update next dosis
    if([txtBoxUnits.text length]>0){
        //Update last dosis
        Prescription *prescription = [[Prescription alloc] initWithName:txtName.text BoxUnits:[txtBoxUnits.text integerValue] UnitsTaken:[txtUnitsTaken.text integerValue] Dosis:[sDosis integerValue]];
        lblLastDosis.text = [prescription getStringLastDosisTaken:nil];
    }
    
}




//BEGIN:Number pad removal handling
-(void)cancelBoxUnits{
    //Restore old value
    txtBoxUnits.text = sBoxUnits;
    
    // Hide keypad
    [txtBoxUnits resignFirstResponder];
}

-(void)doneWithBoxUnits{
    // Hide keyboard
    [txtBoxUnits resignFirstResponder];
    
    //Check if Box units is empty
    if([txtBoxUnits.text length]==0){
        // Show messagebox
        UIAlertView* msgAlert=[[UIAlertView alloc] initWithTitle:ERR_TITLE
                                                         message:ERR_BOXUNITS_EMPTY delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [msgAlert show];
        
        //Recover old value
        txtBoxUnits.text= sBoxUnits;
        
        //Disable Save button
        btnSave.enabled=FALSE;
    }
    //Check if Box units value is greater than 0
    else if([txtBoxUnits.text integerValue]<MIN_BOXUNITS
            || [txtBoxUnits.text integerValue]>MAX_BOXUNITX){
        
        NSString *sErrMessage = [NSString stringWithFormat:ERR_BOUXUNITS_OUTOFRANGE,MIN_BOXUNITS,MAX_BOXUNITX];
        UIAlertView* msgAlert=[[UIAlertView alloc] initWithTitle:ERR_TITLE
                                                         message:sErrMessage delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [msgAlert show];
        
        //Recover old value
        txtBoxUnits.text= sBoxUnits;
        
    }
//    else if([txtName.text length]==0 ||
//            [txtUnitsTaken.text length]==0){
//        // Do not do anything there are still textboxes pending to fill
//    }
    else{
        
        //Validate form
        [self validateForm];
        
        if (!btnSave.enabled){
            //Enable Save button if the value is different from previous one
            btnSave.enabled=(txtBoxUnits.text!= sBoxUnits);
            

        }
        // Store the value for future recover
        sBoxUnits=txtBoxUnits.text;
    }
    
}

-(void)cancelUnitsTaken{
    //Restore old value
    txtUnitsTaken.text = sBoxUnits;
    
    // Hide keypad
    [txtUnitsTaken resignFirstResponder];
}

-(void)doneWithUnitsTaken{
    // Hide keyboard
    [txtUnitsTaken resignFirstResponder];
    
    //Check if Box units is empty
    if([txtUnitsTaken.text length]==0){
        // Show messagebox
        UIAlertView* msgAlert=[[UIAlertView alloc] initWithTitle:ERR_TITLE
                                                         message:ERR_UNITSTAKEN_EMPTY delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [msgAlert show];
        
        //Recover old value
        txtUnitsTaken.text= sBoxUnits;
        
        //Disable Save button
        btnSave.enabled=FALSE;
    }
    //Check if Box units value is 0
    else if([txtUnitsTaken.text integerValue]==0){
        
        UIAlertView* msgAlert=[[UIAlertView alloc] initWithTitle:ERR_TITLE
                                                         message:ERR_UNITSTAKEN_ZERO delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [msgAlert show];
        
        //Recover old value
        txtUnitsTaken.text= sUnitsTaken;
        
    }
    //Check Box units text field is filled
    else if([txtBoxUnits.text integerValue]==0){
        
        UIAlertView* msgAlert=[[UIAlertView alloc] initWithTitle:ERR_TITLE
                                                         message:ERR_BOXUNITS_EMPTY delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [msgAlert show];
        
        //Recover old value
        txtUnitsTaken.text= sUnitsTaken;
        
    }
    //Check if dosis is greater than box units
    else if([txtUnitsTaken.text integerValue]>[txtBoxUnits.text integerValue]){
        
        UIAlertView* msgAlert=[[UIAlertView alloc] initWithTitle:ERR_TITLE
                                                         message:ERR_UNITSTAKEN_GREATERTHAN_BOXUNITS delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [msgAlert show];
        
        //Recover old value
        txtUnitsTaken.text= sUnitsTaken;
    }
//    else if([txtBoxUnits.text length]==0 ||
//            [txtName.text length]==0){
//        // Do not do anything there are still textboxes pending to fill
//    }
    else{
        
        //Validate form
        [self validateForm];
        
        if (!btnSave.enabled){
            //Enable Save button if the value is different from previous one
            btnSave.enabled=(txtUnitsTaken.text!= sUnitsTaken);
            
        }
        // Store the value for future recover
        sUnitsTaken=txtUnitsTaken.text;
        
    }
    

}
//BEGIN:Number pad removal handling


//BEGIN:Keyboard removal handling
- (IBAction)btnNameDidEndOnExit:(id)sender {
    //Check if medicine name is not emty
    if([txtName.text length]==0){
        // Show messagebox
        UIAlertView* msgAlert=[[UIAlertView alloc] initWithTitle:ERR_TITLE
                                                         message:ERR_NAME_EMPTY delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [msgAlert show];
        
        //Recover old value
        txtName.text= sName;
        
    }
//    else if([txtBoxUnits.text length]==0 ||
//            [txtUnitsTaken.text length]==0){
//        // Do not do anything there are still textboxes pending to fill
//    }
    else{
        //Validate form
        [self validateForm];
        
        if (!btnSave.enabled){
            //Enable Save button if the value is different from previous one
            btnSave.enabled=(txtName.text!= sName);
            
            //Update last dosis
            if(btnSave.enabled){
                Prescription *prescription = [[Prescription alloc] initWithName:txtName.text BoxUnits:[txtBoxUnits.text integerValue] UnitsTaken:[txtUnitsTaken.text integerValue] Dosis:[sDosis integerValue]];
                //lblLastDosis.text = [prescription getStringLastDosisTaken:nil];
            }
        }
        // Store the value for future recover
        sName=txtName.text;
    }
    
    // Hide keyboard
    [sender resignFirstResponder];
}
//END:Keyboard removal handling



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"backFromAddSave"]){
        
        NSLog(@"prepareForSegue:backFromAddSave");
        
        //Create a new prescription object
        Prescription *prescription = [[Prescription alloc] initWithName:txtName.text BoxUnits:[txtBoxUnits.text integerValue] UnitsTaken:[txtUnitsTaken.text integerValue] Dosis:[sDosis integerValue]];
        
        //Notify the model
        AppDelegate *appDelegate = [AppDelegate sharedAppDelegate];
        [appDelegate addPrescription:prescription];
        
    }
    else if([segue.identifier isEqualToString:@"showAddDosisTable"]){
        
        NSLog(@"prepareForSegue:showAddDosisTable");
        
        // Get destination view
        DosisUpdateTableViewController *vc = [segue destinationViewController];
        vc.delegate = self;
        
        //Update view fields
        //AppDelegate *appDelegate = [AppDelegate sharedAppDelegate];
        //Prescription *currPrescription = [appDelegate getCurrentPrescription];
        //vc.tDosis=currPrescription.tDosis;
        vc.tDosis=[sDosis integerValue];
    }
    
    
}


#pragma mark - Table view data source
/*-
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate
/*-
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.

     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     //[self.navigationController pushViewController:detailViewController animated:YES];

}
*/
@end
