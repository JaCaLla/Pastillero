//
//  AppDelegate.h
//  ePills
//
//  Created by JAVIER CALATRAVA LLAVERIA on 06/07/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "Prescription.h"
#import "Database.h"
#import "GAI.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    //Array of timers
    NSMutableArray *arrPrescriptions;
    
    // Current Prescription selected
    int idxPrescriptions;

    //Internal timer
    NSTimer *tmr1SecTimer;
    Boolean bTimerStarted;
    
    //Timestamp when app entered in background mode
    NSDate *dteEnteredInBackground;

    AVAudioPlayer *avAudioPlayer;
}

@property (nonatomic, strong) AVAudioPlayer *avAudioPlayer;
@property(nonatomic, strong) id<GAITracker> tracker;
@property (strong, nonatomic) UIWindow *window;

@property int idxPrescriptions;
@property NSTimer *tmr1SecTimer;
//@property NSDate *dteEnteredInBackground;


//Array of timers
@property (strong, nonatomic) NSMutableArray *arrPrescriptions;

//Returns the instance of AppDelegate, in that way the ViewController has access to this class
+(AppDelegate *) sharedAppDelegate;

// Returns the internal array of timers
-(NSArray *) allPrescriptions;

// Returns the current selected prescription
-(Prescription*) getCurrentPrescription;

//Remove the current prescirption
-(void) deleteCurrentPrescription;

//Update one item of the prescription list
-(void) updatePrescription:(Prescription*)p_Prescription;

//Update one item of the prescription list
-(void) addPrescription:(Prescription*)p_Prescription;

//Take a dose
-(int) doseCurrentPrescription;



@end
