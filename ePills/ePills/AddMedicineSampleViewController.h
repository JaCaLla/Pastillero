//
//  AddMedicineSampleViewController.h
//  ePills
//
//  Created by JAVIER CALATRAVA LLAVERIA on 17/09/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Prescription.h"

@protocol ModalViewDelegate;

@interface AddMedicineSampleViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>{
    
    
    
    NSArray *arrSampleMedicines;
    
    
}

@property id<ModalViewDelegate> delegate;

@property (strong, nonatomic) IBOutlet UITableView *tbvSampleMedicines;

@property NSString *sMedicineName;

@end
