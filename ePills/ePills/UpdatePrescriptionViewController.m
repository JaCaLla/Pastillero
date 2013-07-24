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
    [txtBoxUnits resignFirstResponder];
    txtBoxUnits.text = @"";
}

-(void)doneWithBoxUnits{
    //NSString *numberFromTheKeyboard = txtBoxUnits.text;
    [txtBoxUnits resignFirstResponder];
}

-(void)cancelDosis{
    [txtDosis resignFirstResponder];
    txtDosis.text = @"";
}

-(void)doneWithDosis{
    //NSString *numberFromTheKeyboard = txtBoxUnits.text;
    [txtDosis resignFirstResponder];
}
//BEGIN:Number pad removal handling

//BEGIN:Keyboard removal handling
- (IBAction)textFieldReturn:(id)sender {
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
        Prescription *p1 = [[Prescription alloc] initWithName:@"Clamoxil" BoxUnits:50 Dosis:1];
        
        // Get destination view
        //ViewController *vc = [segue destinationViewController];
        
        //Update view fields
        //[vc updatePrescription:p1];
        
        //Notify the model
        AppDelegate *appDelegate = [AppDelegate sharedAppDelegate];
        [appDelegate updatePrescription:p1];
        
        //Create a view
        
        //Set the new prescription
/*
        //Get se
        UITableViewCell *cell = (UITableViewCell *) sender;
        NSIndexPath *indexPath = [self.tbvPrescriptions indexPathForCell:cell];
        Prescription *currPrescription =[arrPrescriptions objectAtIndex:idxPrescriptions];
        
        
        // Get destination view
        UpdatePrescriptionViewController *vc = [segue destinationViewController];
        
        //Update view fields
        vc.sName= currPrescription.sName;
        vc.sBoxUnits=[NSString stringWithFormat:@"%d", currPrescription.iBoxUnits];
        vc.sDosis=[NSString stringWithFormat:@"%d", currPrescription.iDosis];
*/       
        
        
    }
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
