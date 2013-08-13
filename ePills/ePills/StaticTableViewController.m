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
@synthesize uiImageView;
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
    
    sName=@""; //currPrescription.sName;
    sBoxUnits=@"";//[NSString stringWithFormat:@"%d", currPrescription.iBoxUnits];
    sUnitsTaken=@"1";//[NSString stringWithFormat:@"%d", currPrescription.iUnitsTaken];
    sDosis=[NSString stringWithFormat:@"%d", EightHours];
    

    //Hide uiImage control
    uiImageView.hidden=true;
    
    
    //Initialize fields
    txtName.text= sName;
    txtBoxUnits.text=sBoxUnits;
    txtUnitsTaken.text=sUnitsTaken;
    //Initialize dosis array
    arrDosis = [NSArray arrayWithObjects:@"1 hour", @"2 hours", @"4 hours", @"8 hours", @"12 hours", @"1 day", @"2 days", @"4 days", @"1 week", @"2 weeks", @"1 month",@"1 min",@"2 min",@"4 min", nil];
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
    else{
        //Validate form
        [self validateForm];
        
        if (!btnSave.enabled){
            //Enable Save button if the value is different from previous one
            btnSave.enabled=(txtName.text!= sName);
            /* TO EWMOCW
            //Update last dosis
            if(btnSave.enabled){
                Prescription *prescription = [[Prescription alloc] initWithName:txtName.text BoxUnits:[txtBoxUnits.text integerValue] UnitsTaken:[txtUnitsTaken.text integerValue] Dosis:[sDosis integerValue]];
                //lblLastDosis.text = [prescription getStringLastDosisTaken:nil];
            }
             */
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

        //Create a new prescription object
        Prescription *prescription;
        if (uiImageView.image==nil) {//There is no image
            prescription = [[Prescription alloc] initWithName:txtName.text BoxUnits:[txtBoxUnits.text integerValue] UnitsTaken:[txtUnitsTaken.text integerValue] Dosis:[sDosis integerValue]];
        }
        else{
            // UIImage *i=uiImageView.image;
            prescription = [[Prescription alloc] initWithName:txtName.text BoxUnits:[txtBoxUnits.text integerValue] UnitsTaken:[txtUnitsTaken.text integerValue] Dosis:[sDosis integerValue] Image:uiImageView.image];
        }
        
        
        
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
        vc.tDosis=[sDosis integerValue];
    }
    
    
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


@end
