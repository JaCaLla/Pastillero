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
#import "DosisUpdateTableViewController.h"
#import "Constants.h"

static UpdatePrescriptionViewController *sharedInstance;

@interface UpdatePrescriptionViewController ()

@end

@implementation UpdatePrescriptionViewController

@synthesize btnSave;
@synthesize btnDeletePrescription;
@synthesize txtName;
@synthesize txtBoxUnits;
@synthesize txtUnitsTaken;
@synthesize lblDose;
@synthesize lblLastDosis;
@synthesize lblRemaining;
@synthesize lblNextDose;



@synthesize sName;
@synthesize sBoxUnits;
@synthesize sUnitsTaken;
@synthesize sDosis;
@synthesize arrDosis;
@synthesize uiImageView;



- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        if(sharedInstance){
            NSLog(@"Error: You are creating a second AppDelegate!");
        }
        
        //Initialize singleton class
        sharedInstance=self;

    }
    return self;
}

//Return a reference of this class
+(UpdatePrescriptionViewController *) sharedViewController{
    
    return sharedInstance;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    //Initialize navigation bar buttons
    btnSave.enabled=FALSE;
    lblDose.enabled=FALSE;
    
    //Get current prescription from delegate (Model)
    AppDelegate *appDelegate = [AppDelegate sharedAppDelegate];
    Prescription *currPrescription = [appDelegate getCurrentPrescription];
    
    sName= currPrescription.sName;
    sBoxUnits=[NSString stringWithFormat:@"%d", currPrescription.iBoxUnits];
    sUnitsTaken=[NSString stringWithFormat:@"%d", currPrescription.iUnitsTaken];
    
    
    //Initialize dosis array
    arrDosis = [NSArray arrayWithObjects:@"1 hour", @"2 hours", @"4 hours", @"8 hours", @"12 hours", @"1 day", @"2 days", @"4 days", @"1 week", @"2 weeks", @"1 month",@"60",@"120",@"240", nil];
    sDosis=[NSString stringWithFormat:@"Every %@", [arrDosis objectAtIndex:currPrescription.tDosis]];
        

    //Initialize fields
    txtName.text= sName;
    txtBoxUnits.text=sBoxUnits;
    txtUnitsTaken.text=sUnitsTaken;
    lblDose.text=sDosis;
    lblLastDosis.text = [currPrescription getStringLastDosisTaken:nil];
    lblRemaining.text = [NSString stringWithFormat:@"%d", currPrescription.iRemaining];
    lblNextDose.text=[currPrescription getStringNextDose];
    
    //Image
    if(currPrescription.dChosenImage==nil){
        self.uiImageView.image=nil;
    }
    else{
        //NSData *nsData=[self dataWithBase64EncodedString:currPrescription.dChosenImage];
        NSData *nsData=currPrescription.dChosenImage;
        self.uiImageView.image =[UIImage imageWithData:nsData];
        //self.uiImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    uiImageView.hidden=true;
    
    // Assign our own backgroud for the view
    UIView* bview = [[UIView alloc] init];
    bview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"common_bg.png"]];
    [self.tbvUpdatePrescription setBackgroundView:bview];
    
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

-(void) viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];

}

//BEGIN:ModelViewDelegat callbacks
- (void)setDosis:(int)p_iDose {
    //Check if there were changes with dosis
    if([sDosis integerValue]!=p_iDose){//txtDosis.text){
        lblDose.text=[NSString stringWithFormat:@"%d", p_iDose];
        sDosis=lblDose.text;
        
        btnSave.enabled=TRUE;
    }
}
//END:ModelViewDelegat callbacks



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
    //Check if dosis is greater than box units
    else if([txtUnitsTaken.text integerValue]>[txtBoxUnits.text integerValue]){
        
        UIAlertView* msgAlert=[[UIAlertView alloc] initWithTitle:ERR_TITLE
                                                         message:ERR_UNITSTAKEN_GREATERTHAN_BOXUNITS delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [msgAlert show];
        
        //Recover old value
        txtUnitsTaken.text= sUnitsTaken;
    }
    else{
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
        Prescription *p1;
        if (uiImageView.image==nil) {//There is no image
            p1 = [[Prescription alloc] initWithName:txtName.text BoxUnits:[txtBoxUnits.text integerValue] UnitsTaken:[txtUnitsTaken.text integerValue] Dosis:[lblDose.text integerValue]];
        }
        else{
           // UIImage *i=uiImageView.image;
            p1 = [[Prescription alloc] initWithName:txtName.text BoxUnits:[txtBoxUnits.text integerValue] UnitsTaken:[txtUnitsTaken.text integerValue] Dosis:[lblDose.text integerValue] Image:uiImageView.image];
        }
        
        
        
        //Notify the model
        AppDelegate *appDelegate = [AppDelegate sharedAppDelegate];
        [appDelegate updatePrescription:p1];
        
    }
    else if([segue.identifier isEqualToString:@"showUpdateDosisTable"]){
        
        NSLog(@"prepareForSegue:showUpdateDosisTable");
        
        // Get destination view
        DosisUpdateTableViewController *vc = [segue destinationViewController];
        vc.delegate = self;
        
        //Update view fields        
        vc.tDosis=[sDosis integerValue];
    } //Remove a prescription
    else if ([segue.identifier isEqualToString:@"backFromUpdateDelete"]){
        //Notify the model
        AppDelegate *appDelegate = [AppDelegate sharedAppDelegate];
        [appDelegate deleteCurrentPrescription];
    }
    
    
}

- (IBAction)btnDose:(id)sender {
    //Notify model
    AppDelegate *appDelegate = [AppDelegate sharedAppDelegate];
    [appDelegate doseCurrentPrescription];
    
    Prescription *currPrescription = [appDelegate getCurrentPrescription];
    lblRemaining.text = [NSString stringWithFormat:@"%d", [currPrescription doseCurrentPrescription]];
    
    
    lblNextDose.text = [currPrescription getStringNextDose];
    
    
}

- (IBAction)btnRefill:(id)sender {
    
    AppDelegate *appDelegate = [AppDelegate sharedAppDelegate];
    Prescription *currPrescription = [appDelegate getCurrentPrescription];
    [currPrescription refillBox];
    lblRemaining.text = [NSString stringWithFormat:@"%d", currPrescription.iRemaining];
    
}

//Camera and picture album:BEGIN
//http://www.appcoda.com/ios-programming-camera-iphone-app/
-(IBAction)takePhoto:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}


- (IBAction)selectPhoto:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.uiImageView.image = chosenImage;
    
    //Manage save button status
    if (!btnSave.enabled){
        //Enable Save button if the value is different from previous one
        btnSave.enabled=TRUE;
    }
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

//Camera and picture album:END




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
