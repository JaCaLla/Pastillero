//
//  UpdatePrescriptionViewController.h
//  ePills
//
//  Created by JAVIER CALATRAVA LLAVERIA on 09/07/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MIN_BOXUNITS 1
#define MAX_BOXUNITX 100

// Error messages
#define ERR_TITLE @"Error"
#define ERR_NAME_EMPTY @"Medicine name is empty."
#define ERR_BOXUNITS_EMPTY @"Box units is empty."
#define ERR_BOUXUNITS_OUTOFRANGE @"Box units must be between %d and %d."
#define ERR_DOSIS_EMPTY @"Dosis is empty."
#define ERR_DOSIS_ZERO @"Dosis must be different from zero."
#define ERR_DOSIS_GREATERTHAN_BOXUNITS @"Dosis cannot be greater box units."


@interface UpdatePrescriptionViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtBoxUnits;
@property (weak, nonatomic) IBOutlet UITextField *txtUnitsTaken;

@property (nonatomic, strong)NSString *sName;
@property (nonatomic, strong)NSString *sBoxUnits;
@property (nonatomic, strong)NSString *sUnitsTaken;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnSave;


@end
