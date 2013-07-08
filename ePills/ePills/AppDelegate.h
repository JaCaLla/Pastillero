//
//  AppDelegate.h
//  ePills
//
//  Created by JAVIER CALATRAVA LLAVERIA on 06/07/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    //Array of timers
    NSMutableArray *arrPrescriptions;
}

@property (strong, nonatomic) UIWindow *window;

//Array of timers
@property NSMutableArray *arrPrescriptions;

//Returns the instance of AppDelegate, in that way the ViewController has access to this class
+(AppDelegate *) sharedAppDelegate;

// Returns the internal array of timers
-(NSArray *) allPrescriptions;

@end
