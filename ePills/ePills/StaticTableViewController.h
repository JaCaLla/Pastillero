//
//  StaticTableViewController.h
//  ePills
//
//  Created by JAVIER CALATRAVA LLAVERIA on 07/07/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StaticTableViewController.h"
#import "Prescription.h"

@interface StaticTableViewController : UITableViewController


@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtBoxUnits;
@property (weak, nonatomic) IBOutlet UITextField *txtDosis;

@property enum DosisType tDosis;

//Returns the instance of AppDelegate, in that way the ViewController has access to this class
+(StaticTableViewController *) sharedViewController;

@end
