//
//  AddMedicineSampleViewCell.h
//  ePills
//
//  Created by JAVIER CALATRAVA LLAVERIA on 17/09/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddMedicineSampleViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *lblNameMedicine;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewMedicine;

@end

/*
 #import <UIKit/UIKit.h>
 
 @interface PrescriptionControllerCellView : UITableViewCell
 
 @property (weak, nonatomic) IBOutlet UILabel *lblNextDose;
 @property (weak, nonatomic) IBOutlet UILabel *lblName;
 @property (weak, nonatomic) IBOutlet UILabel *lblNeedRefill;
 @property (weak, nonatomic) IBOutlet UIImageView *imageView;
 
 @end

*/