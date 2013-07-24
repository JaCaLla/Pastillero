//
//  ViewController.h
//  ePills
//
//  Created by JAVIER CALATRAVA LLAVERIA on 06/07/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrescriptionControllerCellView.h"
#import "Prescription.h"


@interface ViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>{
    

    NSMutableArray *arrPrescriptions;
    

    
}

@property (strong, nonatomic) IBOutlet UITableView *tbvPrescriptions;

@property (weak, nonatomic) IBOutlet UIButton *btnSegueUpdate;

//Array of timers
@property NSMutableArray *arrPrescriptions;



//Returns the instance of AppDelegate, in that way the ViewController has access to this class
+(ViewController *) sharedViewController;



@end
