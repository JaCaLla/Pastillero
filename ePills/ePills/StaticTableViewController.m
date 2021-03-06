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
@synthesize btnSampleMedicines;
@synthesize arrDosis;
@synthesize arrSampleMedicines;
@synthesize arrSampleMedicinesPng;

@synthesize sName;
@synthesize sBoxUnits;
@synthesize sUnitsTaken;
@synthesize tDosis;
@synthesize sNameMedicine;

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
    tDosis= EightHours;
    

    //Hide uiImage control
    //Image
    self.uiImageView.image=[UIImage imageNamed:@"SampleMedicine.png"];
    uiImageView.hidden=true;

    
    
    //Initialize fields
    txtName.text= sName;
    txtBoxUnits.text=sBoxUnits;
    txtUnitsTaken.text=sUnitsTaken;
    //Initialize dosis array
    arrDosis = [NSArray arrayWithObjects:NSLocalizedString(@"1_HOUR", nil),
                NSLocalizedString(@"2_HOURS", nil),
                NSLocalizedString(@"4_HOURS", nil),
                NSLocalizedString(@"8_HOURS", nil),
                NSLocalizedString(@"12_HOURS", nil),
                NSLocalizedString(@"1_DAY", nil),
                NSLocalizedString(@"2_DAYS", nil),
                NSLocalizedString(@"4_DAYS", nil),
                NSLocalizedString(@"1_WEEK", nil),
                NSLocalizedString(@"2_WEEKS", nil),
                NSLocalizedString(@"1_MONTH", nil),
                @"60",@"120",@"240",nil];
    lblDose.text=[NSString stringWithFormat:NSLocalizedString(@"EVERY", nil), [arrDosis objectAtIndex:3]];;//By default 8 hours, idx=3
    
    //Initialize medicine array
    //arrSampleMedicines = [NSArray arrayWithObjects:@"MNA",@"MNB",@"MNC",nil];
    
    

    // Detect country
    NSLocale *locale = [NSLocale currentLocale];
    NSString *countryCode = [locale objectForKey: NSLocaleCountryCode];
    btnSampleMedicines.enabled=([countryCode isEqualToString:@"ES"]);
    
    // Assign our own backgroud for the view    
    UIView* bview = [[UIView alloc] init];
    bview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"common_bg.png"]];
    [self.tbvNewPrescription setBackgroundView:bview];
    
    //BEGIN:Number pad removal handling
    // Define a Cancel and Apply button because it does not exists in the numeric pad for Box Units
    UIToolbar* numberToolbarBoxUnits = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbarBoxUnits.barStyle = UIBarStyleBlackTranslucent;
    numberToolbarBoxUnits.items = [NSArray arrayWithObjects:
                                   [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"CANCEL", nil) style:UIBarButtonItemStyleBordered target:self action:@selector(cancelBoxUnits)],
                                   [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                   [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"APPLY", nil) style:UIBarButtonItemStyleDone target:self action:@selector(doneWithBoxUnits)],
                                   nil];
    [numberToolbarBoxUnits sizeToFit];
    txtBoxUnits.inputAccessoryView = numberToolbarBoxUnits;
    
    // Define a Cancel and Apply button because it does not exists in the numeric pad for Box Units
    UIToolbar* numberToolbarDosis = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbarDosis.barStyle = UIBarStyleBlackTranslucent;
    numberToolbarDosis.items = [NSArray arrayWithObjects:
                                [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"CANCEL", nil) style:UIBarButtonItemStyleBordered target:self action:@selector(cancelUnitsTaken)],
                                [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"APPLY", nil) style:UIBarButtonItemStyleDone target:self action:@selector(doneWithUnitsTaken)],
                                nil];
    [numberToolbarDosis sizeToFit];
    txtUnitsTaken.inputAccessoryView = numberToolbarDosis;
    //END:Number pad removal handling
}

//BEGIN:ModelViewDelegat callbacks
- (void)setDosis:(int)p_iDose {
    //Check if there were changes with dosis
    if(tDosis!=p_iDose){//txtDosis.text){
        
        lblDose.text=[NSString stringWithFormat:NSLocalizedString(@"EVERY", nil), [arrDosis objectAtIndex:p_iDose]];
        tDosis= p_iDose;
        
        //Validate form
        [self validateForm];

    }
}

- (void)setName:(NSString*)p_sName {


    [txtName setText:p_sName];
    
    //Validate form
    [self validateForm];
    
}

- (void)setNamePng:(NSString*)p_sNamePng {
    
    self.uiImageView.image = [UIImage imageNamed:p_sNamePng];
    
    //Validate form
    [self validateForm];
    
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
        UIAlertView* msgAlert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ERR_TITLE", nil)
                                                         message:NSLocalizedString(@"ERR_BOXUNITS_EMPTY", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
        
        [msgAlert show];
        
        //Recover old value
        txtBoxUnits.text= sBoxUnits;
        
        //Disable Save button
        btnSave.enabled=FALSE;
    }
    //Check if Box units value is greater than 0
    else if([txtBoxUnits.text integerValue]<MIN_BOXUNITS
            || [txtBoxUnits.text integerValue]>MAX_BOXUNITX){
        
        NSString *sErrMessage = [NSString stringWithFormat:NSLocalizedString(@"ERR_BOUXUNITS_OUTOFRANGE", nil),MIN_BOXUNITS,MAX_BOXUNITX];
        UIAlertView* msgAlert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ERR_TITLE", nil)
                                                         message:sErrMessage delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
        
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

- (IBAction)txtBoxUnitsEditingDidEnd:(id)sender {
    
    if(txtBoxUnits.text!= sBoxUnits)
        [self doneWithBoxUnits];
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
        UIAlertView* msgAlert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ERR_TITLE", nil)
                                                         message:NSLocalizedString(@"ERR_UNITSTAKEN_EMPTY", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
        
        [msgAlert show];
        
        //Recover old value
        txtUnitsTaken.text= sBoxUnits;
        
        //Disable Save button
        btnSave.enabled=FALSE;
    }
    //Check if Box units value is 0
    else if([txtUnitsTaken.text integerValue]==0){
        
        UIAlertView* msgAlert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ERR_TITLE", nil)
                                                         message:NSLocalizedString(@"ERR_UNITSTAKEN_ZERO", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
        
        [msgAlert show];
        
        //Recover old value
        txtUnitsTaken.text= sUnitsTaken;
        
    }
    //Check Box units text field is filled
    else if([txtBoxUnits.text integerValue]==0){
        
        UIAlertView* msgAlert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ERR_TITLE", nil)
                                                         message:NSLocalizedString(@"ERR_BOXUNITS_EMPTY", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
        
        [msgAlert show];
        
        //Recover old value
        txtUnitsTaken.text= sUnitsTaken;
        
    }
    //Check if dosis is greater than box units
    else if([txtUnitsTaken.text integerValue]>[txtBoxUnits.text integerValue]){
        
        UIAlertView* msgAlert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ERR_TITLE", nil)
                                                         message:NSLocalizedString(@"ERR_UNITSTAKEN_GREATERTHAN_BOXUNITS", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
        
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
- (IBAction)txtUnitsTakenEditingDidEnd:(id)sender {
    if(txtUnitsTaken.text!= sUnitsTaken)
        [self doneWithUnitsTaken];
}
//BEGIN:Number pad removal handling


//BEGIN:Keyboard removal handling
-(void) validateTxtName{
    //Check if medicine name is not emty
    if([txtName.text length]==0){
        // Show messagebox
        UIAlertView* msgAlert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ERR_TITLE", nil)
                                                         message:NSLocalizedString(@"ERR_NAME_EMPTY", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
        
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
        }
        // Store the value for future recover
        sName=txtName.text;
    }
}

- (IBAction)btnNameDidEndOnExit:(id)sender {
    
    if(sName!=txtName.text)
        [self validateTxtName];
    
    // Hide keyboard
    [sender resignFirstResponder];
}

- (IBAction)txtNameValueChanged:(id)sender {
    if(sName!=txtName.text)
        [self validateTxtName];
    
    // Hide keyboard
    [sender resignFirstResponder];
    
}


//END:Keyboard removal handling

-(void)  validateForm{
    
    btnSave.enabled=([txtName.text length]>0) && ([txtBoxUnits.text length]>0) && ([txtUnitsTaken .text length]>0);
    
    //Update next dosis
    if([txtBoxUnits.text length]>0){
        //Update last dosis
        Prescription *prescription = [[Prescription alloc] initWithName:txtName.text BoxUnits:[txtBoxUnits.text integerValue] UnitsTaken:[txtUnitsTaken.text integerValue] Dosis:tDosis];
        lblLastDosis.text = [prescription getStringLastDosisTaken:nil];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"backFromAddSave"]){

        //Create a new prescription object
        Prescription *prescription;
        prescription = [[Prescription alloc] initWithName:txtName.text BoxUnits:[txtBoxUnits.text integerValue] UnitsTaken:[txtUnitsTaken.text integerValue] Dosis:tDosis Image:uiImageView.image];
       
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
        vc.tDosis=tDosis;
    }
    else if([segue.identifier isEqualToString:@"showSampleMedicines"]){
        
        NSLog(@"prepareForSegue:showSampleMedicines");
        
        // Get destination view
        DosisUpdateTableViewController *vc = [segue destinationViewController];
        vc.delegate = self;
        
        //Update view fields
        //vc.tDosis=tDosis;
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
