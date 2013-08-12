//
//  UpdatePrescriptionViewController.h
//  ePills
//
//  Created by JAVIER CALATRAVA LLAVERIA on 09/07/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Prescription.h"


//Callback method declaration
@protocol ModalViewDelegate
 
 - (void)setDosis:(int)p_iDose;
 
@end

//Implements ModalViewDelegate bacause another view calls one of its methods
@interface UpdatePrescriptionViewController : UITableViewController <ModalViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{


    
}

@property (strong, nonatomic) IBOutlet UITableView *tbvUpdatePrescription;

@property (weak, nonatomic) IBOutlet UIImageView *uiImageView;

@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtBoxUnits;
@property (weak, nonatomic) IBOutlet UITextField *txtUnitsTaken;
@property (weak, nonatomic) IBOutlet UILabel *lblDose;
@property (weak, nonatomic) IBOutlet UILabel *lblLastDosis;
@property (weak, nonatomic) IBOutlet UILabel *lblRemaining;
@property (weak, nonatomic) IBOutlet UILabel *lblNextDose;



@property (nonatomic, strong) NSString *sName;
@property (nonatomic, strong) NSString *sBoxUnits;
@property (nonatomic, strong) NSString *sUnitsTaken;
@property (nonatomic, strong) NSString *sDosis;
@property NSArray *arrDosis;


//@property enum DosisType tDosis;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnSave;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnDeletePrescription;

//Returns the instance of AppDelegate, in that way the ViewController has access to this class
+(UpdatePrescriptionViewController *) sharedViewController;

//Camera and picture album:BEGIN
-(IBAction)takePhoto:(UIButton *)sender ;
-(IBAction)selectPhoto:(UIButton *)sender;
//Camera and picture album:END

@end
