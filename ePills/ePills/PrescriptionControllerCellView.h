//
//  PrescriptionControllerCellView.h
//  ePills
//
//  Created by JAVIER CALATRAVA LLAVERIA on 08/07/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrescriptionControllerCellView : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblNextDose;
@property (weak, nonatomic) IBOutlet UILabel *txtName;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
