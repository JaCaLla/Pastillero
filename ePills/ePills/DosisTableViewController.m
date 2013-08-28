//
//  DosisTableViewController.m
//  ePills
//
//  Created by JAVIER CALATRAVA LLAVERIA on 07/07/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import "DosisTableViewController.h"
#import "Prescription.h"
#import "StaticTableViewController.h"

@interface DosisTableViewController (){
    
    //int idxSelecteDose;
}

@end


@implementation DosisTableViewController

@synthesize delegate;
@synthesize arrDosis;
@synthesize tDosis;


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
    
    //Initialize dosis array
    //arrDosis = [NSArray arrayWithObjects:@"1 hour", @"2 hours", @"4 hours", @"8 hours", @"12 hours", @"1 day", @"2 days", @"4 days", @"1 week", @"2 weeks", @"1 month",@"1 min",@"2 min",@"4 min", nil];
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
                NSLocalizedString(@"1_MINUTE", nil),
                NSLocalizedString(@"2_MINUTES", nil),
                NSLocalizedString(@"4_MINUTES", nil),
                nil];
    

    
    
    // Assign our own backgroud for the view
    UIView* bview = [[UIView alloc] init];
    bview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"common_bg.png"]];    
    [self.tbvDoses setBackgroundView:bview];
}

//Capture when Update navigation back key is pressed
-(void) viewWillDisappear:(BOOL)animated {
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
        // back button was pressed.  We know this is true because self is no longer
        // in the navigation stack.
    }
    
    //Provive dosis to delegated view (UpdatePrescriptionViewController)
    [delegate setDosis:tDosis];
    
    [super viewWillDisappear:tDosis];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [arrDosis count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellDosisId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
    
    // Configure the cell...
    // Cell mark
    if(indexPath.row == tDosis)// idxSelecteDose)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    // Cell text
    cell.textLabel.text = [arrDosis objectAtIndex:indexPath.row];
    
    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tDosis!=indexPath.row){
        
        // Mark the cell
        //idxSelecteDose=indexPath.row;
        tDosis=indexPath.row;
        //Refresh whole table
        [self.tableView reloadData];
        
        //Notify UpdatePrescriptionViewController
        // UpdatePrescriptionViewController *vc = [UpdatePrescriptionViewController sharedViewController];
        // vc.sDosis=[NSString stringWithFormat:@"%d", indexPath.item];
        
        NSLog(@"Row Selected = %i",indexPath.item);
    }

    
}

@end
