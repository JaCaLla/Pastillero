//
//  DosisTableViewController.h
//  ePills
//
//  Created by JAVIER CALATRAVA LLAVERIA on 07/07/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Prescription.h"

@protocol ModalViewDelegate;

@interface DosisTableViewController : UITableViewController<UITableViewDelegate, UITableViewDataSource> {
    
    id<ModalViewDelegate> delegate;
    
    NSArray *arrDosis;
}

@property (strong, nonatomic) IBOutlet UITableView *tbvDoses;

@property id<ModalViewDelegate> delegate;
@property NSArray *arrDosis;

@property enum DosisType tDosis;

@end