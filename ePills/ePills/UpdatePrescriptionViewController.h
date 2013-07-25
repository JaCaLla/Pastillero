//
//  UpdatePrescriptionViewController.h
//  ePills
//
//  Created by JAVIER CALATRAVA LLAVERIA on 09/07/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdatePrescriptionViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtBoxUnits;
@property (weak, nonatomic) IBOutlet UITextField *txtDosis;

@property (nonatomic, strong)NSString *sName;
@property (nonatomic, strong)NSString *sBoxUnits;
@property (nonatomic, strong)NSString *sDosis;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnSave;


@end
