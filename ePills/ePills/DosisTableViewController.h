//
//  DosisTableViewController.h
//  ePills
//
//  Created by JAVIER CALATRAVA LLAVERIA on 07/07/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Prescription.h"

@interface DosisTableViewController : UITableViewController<UITableViewDelegate, UITableViewDataSource> {
    
   NSArray *arrDosis;
}

@property NSArray *arrDosis;
@property enum DosisType tDosis;


@end
