//
//  StaticTableViewController.h
//  ePills
//
//  Created by JAVIER CALATRAVA LLAVERIA on 07/07/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "StaticTableViewController.h"
#import "Prescription.h"

//Callback method declaration
@protocol ModalViewDelegate

- (void)setDosis:(int)p_iDose;

@end

//Implements ModalViewDelegate bacause another view calls one of its methods
@interface StaticTableViewController : UITableViewController <ModalViewDelegate>{
    
}

@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtBoxUnits;
@property (weak, nonatomic) IBOutlet UITextField *txtUnitsTaken;
@property (weak, nonatomic) IBOutlet UILabel *lblLastDosis;


@property (nonatomic, strong) NSString *sName;
@property (nonatomic, strong) NSString *sBoxUnits;
@property (nonatomic, strong) NSString *sUnitsTaken;
@property (nonatomic, strong) NSString *sDosis;
//@property enum DosisType tDosis;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnSave;

//Returns the instance of AppDelegate, in that way the ViewController has access to this class
+(StaticTableViewController *) sharedViewController;

@end
