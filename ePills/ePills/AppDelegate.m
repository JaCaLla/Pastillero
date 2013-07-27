//
//  AppDelegate.m
//  ePills
//
//  Created by JAVIER CALATRAVA LLAVERIA on 06/07/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import "AppDelegate.h"
#import "Prescription.h"

// Defining this object as a singleton View controllers can call its methods
static AppDelegate *sharedInstance;

@implementation AppDelegate{
    
}

@synthesize arrPrescriptions;
@synthesize idxPrescriptions;



-(id) init{
    if(sharedInstance){
        NSLog(@"Error: You are creating a second AppDelegate. Bad Panda!");
    }
    
    self=[super init];
    sharedInstance=self;
    
    
    arrPrescriptions = [[NSMutableArray alloc]init];
    Prescription *p1 = [[Prescription alloc] initWithName:@"Frenadol" BoxUnits:20 UnitsTaken:1];
    [arrPrescriptions addObject:p1];
    Prescription *p2 = [[Prescription alloc] initWithName:@"Culdina" BoxUnits:30 UnitsTaken:2];
    [arrPrescriptions addObject:p2];
    Prescription *p3 = [[Prescription alloc] initWithName:@"Licipaina" BoxUnits:10 UnitsTaken:3 Dosis:1];
    [arrPrescriptions addObject:p3];
    
    return self;
}

// Return an instance of this class, in that way the ViewController can access to this class
+(AppDelegate*) sharedAppDelegate{
    return sharedInstance;
}

-(NSArray*) allPrescriptions{
    
    return arrPrescriptions;
}

// Returns the current selected prescription
-(Prescription*) getCurrentPrescription{
    
    return [arrPrescriptions objectAtIndex:idxPrescriptions];
}

//Update one item of the prescription list
-(void) updatePrescription:Prescription{
    NSLog(@"updatePrescription:%d",idxPrescriptions);
    
    //Remove old prescription
    [arrPrescriptions removeObjectAtIndex:idxPrescriptions];
    //Insert new prescription
    [arrPrescriptions insertObject:Prescription atIndex:idxPrescriptions];
    
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
