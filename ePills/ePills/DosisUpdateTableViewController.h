//
//  DosisUpdateTableViewController.h
//  ePills
//
//  Created by JAVIER CALATRAVA LLAVERIA on 26/07/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Prescription.h"

@protocol ModalViewDelegate;

@interface DosisUpdateTableViewController : UITableViewController<UITableViewDelegate, UITableViewDataSource> {
    
    id<ModalViewDelegate> delegate;
    
    NSArray *arrDosis;
}

@property id<ModalViewDelegate> delegate;
@property NSArray *arrDosis;

@property enum DosisType tDosis;

@end

