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
- (void)setName:(NSString*)p_sName;
- (void)setNamePng:(NSString*)p_sNamePng;

@end

//Implements ModalViewDelegate bacause another view calls one of its methods
@interface StaticTableViewController : UITableViewController <ModalViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    
}
@property (strong, nonatomic) IBOutlet UITableView *tbvNewPrescription;
@property (weak, nonatomic) IBOutlet UIButton *btnDisclosure;
@property (weak, nonatomic) IBOutlet UIImageView *uiImageView;

@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtBoxUnits;
@property (weak, nonatomic) IBOutlet UITextField *txtUnitsTaken;
@property (weak, nonatomic) IBOutlet UILabel *lblLastDosis;
@property (weak, nonatomic) IBOutlet UILabel *lblDose;
@property NSArray *arrDosis;
@property NSArray *arrSampleMedicines;
@property NSArray *arrSampleMedicinesPng;

@property (nonatomic, strong) NSString *sName;
@property (nonatomic, strong) NSString *sBoxUnits;
@property (nonatomic, strong) NSString *sUnitsTaken;
@property enum DosisType tDosis;
@property NSString *sNameMedicine;

//@property enum DosisType tDosis;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnSave;

//Returns the instance of AppDelegate, in that way the ViewController has access to this class
+(StaticTableViewController *) sharedViewController;

//Camera and picture album:BEGIN
-(IBAction)takePhoto:(UIButton *)sender ;
-(IBAction)selectPhoto:(UIButton *)sender;
//Camera and picture album:END

@end
