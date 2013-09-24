//
//  UpdateMedicineSampleViewController.m
//  ePills
//
//  Created by JAVIER CALATRAVA LLAVERIA on 24/09/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import "UpdateMedicineSampleViewController.h"
#import "UpdateMedicineSampleViewCell.h"
#import "StaticTableViewController.h"
#import "Constants.h"

@interface UpdateMedicineSampleViewController (){
    
}

@end

@implementation UpdateMedicineSampleViewController

@synthesize delegate;
@synthesize sMedicineName;
@synthesize sMedicineNamePng;

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
    
    //Link collection view to this class
    [self.tbvSampleMedicines setDataSource:self];
    [self.tbvSampleMedicines setDelegate:self];
	
    //Initialize medicine array
    // Detect country
    NSLocale *locale = [NSLocale currentLocale];
    NSString *countryCode = [locale objectForKey: NSLocaleCountryCode];
    
    //NSString *countryName = [locale displayNameForKey: NSLocaleCountryCode value: countryCode];
    
    if([countryCode isEqualToString:@"ES"])
    {
        arrSampleMedicines = [NSArray arrayWithObjects:SPANISH_MEDICINES,nil];
        arrSampleMedicinesPng = [NSArray arrayWithObjects:SPANISH_MEDICINES_PNG,nil];
        
    }
    else{
        arrSampleMedicines = [NSArray arrayWithObjects:nil];
        arrSampleMedicinesPng = [NSArray arrayWithObjects:nil];
    }
    
    
    
    // Assign our own backgroud for the view
    UIView* bview = [[UIView alloc] init];
    bview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"common_bg.png"]];
    [self.tbvSampleMedicines setBackgroundView:bview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// BEGIN: Methods to implement for fulfill CollectionView Interface
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [arrSampleMedicines count];
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *CellIdentifier = @"CellUpdateSampleMedicineId";
    
    
    UpdateMedicineSampleViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UpdateMedicineSampleViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    cell.lblNameMedicine.hidden=FALSE;
    [cell.lblNameMedicine setText:[arrSampleMedicines objectAtIndex:indexPath.row]];
    
    cell.imageViewMedicine.image = [UIImage imageNamed:[arrSampleMedicinesPng objectAtIndex:indexPath.row]];
    
    
    
    /*
     
     .image = [UIImage imageNamed:@"firstPicure.png"];
     UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
     self.uiImageView.image = chosenImage;
     
     */
    
    return cell;
    
}

- (UIImage *)cellBackgroundForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSInteger rowCount = [self tableView:[self tableView] numberOfRowsInSection:0];
    NSInteger rowCount = [arrSampleMedicines count];
    NSInteger rowIndex = indexPath.row;
    UIImage *background = nil;
    
    if(rowCount==1){
        background = [UIImage imageNamed:@"cell_unique.png"];
    }
    else{
        if (rowIndex == 0) {
            background = [UIImage imageNamed:@"cell_top.png"];
        } else if (rowIndex == rowCount - 1) {
            background = [UIImage imageNamed:@"cell_bottom.png"];
        } else {
            background = [UIImage imageNamed:@"cell_middle.png"];
        }
    }
    
    return background;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    // Get the medicine name
    sMedicineName=[arrSampleMedicines objectAtIndex:indexPath.row];
    sMedicineNamePng=[arrSampleMedicinesPng objectAtIndex:indexPath.row];
    
    
    //Force to close view (-> -(void) viewWillDisappear:(BOOL)animated)
    [self.navigationController popViewControllerAnimated:YES];
    
}

//end: Methods to implement for fulfill CollectionView Interface

//Capture when Update navigation back key is pressed
-(void) viewWillDisappear:(BOOL)animated {
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
        // back button was pressed.  We know this is true because self is no longer
        // in the navigation stack.
    }
    
    //Provive dosis to delegated view (UpdatePrescriptionViewController)
    [delegate setName:sMedicineName];
    [delegate setNamePng:sMedicineNamePng];
    
    
    [super viewWillDisappear:YES];
}


@end
