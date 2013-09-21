//
//  AddMedicineSampleViewController.m
//  ePills
//
//  Created by JAVIER CALATRAVA LLAVERIA on 17/09/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import "AddMedicineSampleViewController.h"
#import "AddMedicineSampleViewCell.h"
#import "StaticTableViewController.h"

@interface AddMedicineSampleViewController (){
    
    
}

@end


@implementation AddMedicineSampleViewController

@synthesize delegate;
@synthesize sMedicineName;

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
    arrSampleMedicines = [NSArray arrayWithObjects:@"MNA",@"MNB",@"MNC",nil];
    
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
    

    static NSString *CellIdentifier = @"CellSampleMedicineId";
    
    
    AddMedicineSampleViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[AddMedicineSampleViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    cell.lblNameMedicine.hidden=FALSE;
    [cell.lblNameMedicine setText:[arrSampleMedicines objectAtIndex:indexPath.row]];
    
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
    
    
    [super viewWillDisappear:YES];
}



@end
