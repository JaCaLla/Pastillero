//
//  ViewController.h
//  ePills
//
//  Created by JAVIER CALATRAVA LLAVERIA on 06/07/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UICollectionViewDataSource,UICollectionViewDelegate>{
    

    NSMutableArray *arrPrescriptions;
    int idxPrescriptions;
    
}

@property (weak, nonatomic) IBOutlet UICollectionView *clvPrescriptions;

//Array of timers
@property NSMutableArray *arrPrescriptions;
@property int idxPrescriptions;

@end
