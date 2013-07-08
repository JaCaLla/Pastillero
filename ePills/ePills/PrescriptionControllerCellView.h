//
//  PrescriptionControllerCellView.h
//  ePills
//
//  Created by JAVIER CALATRAVA LLAVERIA on 08/07/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrescriptionControllerCellView : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *txtName;
@property (weak, nonatomic) IBOutlet UILabel *txtDosis;

@end
