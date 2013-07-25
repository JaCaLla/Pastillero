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
    
    int idxSelecteDose;
}

@end


@implementation DosisTableViewController

@synthesize arrDosis;


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
    arrDosis = [NSArray arrayWithObjects:@"1 hour", @"2 hours", @"4 hours", @"8 hours", @"12 hours", @"1 day", @"2 days", @"4 days", @"1 week", @"2 weeks", @"1 month", nil];
    
    // Default initialization
    idxSelecteDose=EightHours;
    

  /*
    self.navigationItem.title = @"Recipe Book";

    self.navigationItem.hidesBackButton = YES;
    
    UIImage* image = [UIImage imageNamed:@"button_back.png"];
    CGRect frame = CGRectMake(0, 0, image.size.width, image.size.height);
    UIButton* backbtn = [[UIButton alloc] initWithFrame:frame];
    [backbtn setBackgroundImage:image forState:UIControlStateNormal];
    [backbtn setShowsTouchWhenHighlighted:YES];
    [backbtn setFrame:frame];
    backbtn.titleLabel.text = @"back";
    [backbtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backbtn];
    [self.navigationItem setLeftBarButtonItem:backButtonItem];
    
   */
    
    //UIBarButtonItem *btnDone = [[UIBarButtonItem alloc] initWithTitle:@"I am done" style:UIBarButtonItemStyleBordered target:self action:nil];
    //UIImage *stretchable = [[UIImage imageNamed:@"StretchableImage.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:16];
    //UIImage* image = [UIImage imageNamed:@"button_back.png"];
    //CGRect frame = CGRectMake(0, 0, image.size.width, image.size.height);

    //[btnDone setBackgroundImage:image forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    //[self.navigationItem setRightBarButtonItem:btnDone];
   
    //WORKS BUT FAILS THE FORM BUTTON
    //UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style: UIBarButtonItemStyleBordered target:self action:@selector(Back)];
    //self.navigationItem.leftBarButtonItem = backButton;
/*
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backBtnImage = [UIImage imageNamed:@"button_back.png"]  ;
    [backBtn setBackgroundImage:backBtnImage forState:UIControlStateNormal];
    //[backBtn addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame = CGRectMake(0, 0, backBtnImage.size.width, backBtnImage.size.height);
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn] ;
    self.navigationItem.leftBarButtonItem = backButton;
    
*/
}

- (IBAction)Back
{
    [self dismissViewControllerAnimated:YES completion:nil]; // ios 6
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
    /*
    static NSString *CellIdentifier = @"CellDosisId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    */
    static NSString *CellIdentifier = @"CellDosisId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
    
    // Configure the cell...
    // Cell mark
    if(indexPath.row == idxSelecteDose)
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
    // <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    
    idxSelecteDose = indexPath.row;
    [tableView reloadData];
    
    NSLog(@"Cell selected:%d",indexPath.row);
    
    StaticTableViewController *viewController = [StaticTableViewController sharedViewController];
    viewController.tDosis=indexPath.row;

    
}

@end
