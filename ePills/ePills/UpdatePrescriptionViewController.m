//
//  UpdatePrescriptionViewController.m
//  ePills
//
//  Created by JAVIER CALATRAVA LLAVERIA on 09/07/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import "UpdatePrescriptionViewController.h"
#import "Prescription.h"
#import "AppDelegate.h"

@interface UpdatePrescriptionViewController ()

@end

@implementation UpdatePrescriptionViewController

@synthesize btnSave;
@synthesize txtName;
@synthesize txtBoxUnits;
@synthesize txtDosis;

@synthesize sName;
@synthesize sBoxUnits;
@synthesize sDosis;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    //Initialize navigation bar buttons
    btnSave.enabled=FALSE;
    
    //Initialize fields
    txtName.text= sName;
    txtBoxUnits.text=sBoxUnits;
    txtDosis.text=sDosis;
    
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
                                [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelDosis)],
                                [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                [[UIBarButtonItem alloc]initWithTitle:@"Apply" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithDosis)],
                                nil];
    [numberToolbarDosis sizeToFit];
    txtDosis.inputAccessoryView = numberToolbarDosis;
    //END:Number pad removal handling
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
    else{
        if (!btnSave.enabled){
            //Enable Save button if the value is different from previous one
            btnSave.enabled=(txtBoxUnits.text!= sBoxUnits);
        }
        // Store the value for future recover
        sBoxUnits=txtBoxUnits.text;
    }
    
}

-(void)cancelDosis{
    //Restore old value
    txtDosis.text = sBoxUnits;
    
    // Hide keypad
    [txtDosis resignFirstResponder];
}

-(void)doneWithDosis{
    // Hide keyboard
    [txtDosis resignFirstResponder];
    
    //Check if Box units is empty
    if([txtDosis.text length]==0){
        // Show messagebox
        UIAlertView* msgAlert=[[UIAlertView alloc] initWithTitle:ERR_TITLE
                                                         message:ERR_DOSIS_EMPTY delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [msgAlert show];
        
        //Recover old value
        txtDosis.text= sBoxUnits;
        
        //Disable Save button
        btnSave.enabled=FALSE;
    }
    //Check if Box units value is 0
    else if([txtDosis.text integerValue]==0){
        
        UIAlertView* msgAlert=[[UIAlertView alloc] initWithTitle:ERR_TITLE
                                                         message:ERR_DOSIS_ZERO delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [msgAlert show];
        
        //Recover old value
        txtDosis.text= sDosis;
      
    }
    //Check if dosis is greater than box units
    else if([txtDosis.text integerValue]>[txtBoxUnits.text integerValue]){
        
        UIAlertView* msgAlert=[[UIAlertView alloc] initWithTitle:ERR_TITLE
                                                         message:ERR_DOSIS_GREATERTHAN_BOXUNITS delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [msgAlert show];
        
        //Recover old value
        txtDosis.text= sDosis;
    }
    else{
        if (!btnSave.enabled){
            //Enable Save button if the value is different from previous one
            btnSave.enabled=(txtDosis.text!= sDosis);
        }
        // Store the value for future recover
        sDosis=txtDosis.text;
        
    }
}
//BEGIN:Number pad removal handling


//BEGIN:Keyboard removal handling
- (IBAction)btnNameEditingDidEd:(id)sender {
    //Check if medicine name is not emty
    if([txtName.text length]==0){
        // Show messagebox
        UIAlertView* msgAlert=[[UIAlertView alloc] initWithTitle:ERR_TITLE
                                                    message:ERR_NAME_EMPTY delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [msgAlert show];
        
        //Recover old value
        txtName.text= sName;
        
    }
    else{
        if (!btnSave.enabled){
            //Enable Save button if the value is different from previous one
            btnSave.enabled=(txtName.text!= sName);
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
    if([segue.identifier isEqualToString:@"backFromUpdateSave"]){
        
        NSLog(@"prepareForSegue:backFromUpdateSave");
        
        //Create a new prescription object
        Prescription *p1 = [[Prescription alloc] initWithName:txtName.text BoxUnits:[txtBoxUnits.text integerValue] Dosis:[txtDosis.text integerValue]];
        
        //Notify the model
        AppDelegate *appDelegate = [AppDelegate sharedAppDelegate];
        [appDelegate updatePrescription:p1];
        
    }
}


// This method is
-(Boolean) validateForm{
    Boolean bValidForm=TRUE;
    
    
    
    return bValidForm;
}

#pragma mark - Table view data source
/* Not necessary because is a static table
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
