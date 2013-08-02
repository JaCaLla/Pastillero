//
//  AppDelegate.m
//  ePills
//
//  Created by JAVIER CALATRAVA LLAVERIA on 06/07/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import "AppDelegate.h"
#import "Prescription.h"
#import "ViewController.h"

// Defining this object as a singleton View controllers can call its methods
static AppDelegate *sharedInstance;

@implementation AppDelegate{
    
}

@synthesize arrPrescriptions;
@synthesize idxPrescriptions;
@synthesize tmr1SecTimer;
//@synthesize dteEnteredInBackground;



-(id) init{
    if(sharedInstance){
        NSLog(@"Error: You are creating a second AppDelegate. Bad Panda!");
    }
    
    self=[super init];
    sharedInstance=self;
    
    //Start the timer
    [self startTimer];
    
    
    arrPrescriptions = [[NSMutableArray alloc]init];
    Prescription *p1 = [[Prescription alloc] initWithName:@"Frenadol" BoxUnits:20 UnitsTaken:1 Dosis:11];
    [arrPrescriptions addObject:p1];
    Prescription *p2 = [[Prescription alloc] initWithName:@"Culdina" BoxUnits:30 UnitsTaken:2 Dosis:12];
    [arrPrescriptions addObject:p2];
    Prescription *p3 = [[Prescription alloc] initWithName:@"Licipaina" BoxUnits:10 UnitsTaken:3 Dosis:13];
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

//Remove the current prescirption
-(void) deleteCurrentPrescription{
    //Remove old prescription
    [arrPrescriptions removeObjectAtIndex:idxPrescriptions];    
}

//Update one item of the prescription list
-(void) updatePrescription:p_Prescription{
    NSLog(@"updatePrescription:%d",idxPrescriptions);
    
    //Remove old prescription
    [arrPrescriptions removeObjectAtIndex:idxPrescriptions];
    //Insert new prescription
    [arrPrescriptions insertObject:p_Prescription atIndex:idxPrescriptions];
    
}

//Take a dose
-(int) doseCurrentPrescription{
    
    Prescription *prescription=[arrPrescriptions objectAtIndex:idxPrescriptions];

    //Check start timer if necessary
    if(!bTimerStarted){
        [self startTimer];
    }
    
    return [prescription doseCurrentPrescription];
}


//Add one item of the prescription list
-(void) addPrescription:p_Prescription{

    //Insert new prescription
    [arrPrescriptions addObject:p_Prescription];
    
}

//Internal timer callback
- (void) timerFired:(NSTimer *) timer {
    
    bool stopInternalTimer=TRUE;
    int iRow=0;
    
    //Iterate throught all timers to decrease its value
    for (Prescription *tmrCurr in arrPrescriptions){
        //If timer is not still expired
        if(tmrCurr.bPrescriptionHasStarted){
            if(tmrCurr.bIsNextDoseExpired==false){

                if(tmrCurr.iSecsRemainingNextDose>0  ){
                    //Decrease timer
                    tmrCurr.iSecsRemainingNextDose--;
                    //Invalidate the internal timer stop execution
                    stopInternalTimer=FALSE;
                }
                else{
                    tmrCurr.bIsNextDoseExpired=true;
                
                    NSString *cellText =  [NSString stringWithFormat:@"%@ %d unit(s)",tmrCurr.sName,tmrCurr.iUnitsTaken];
                    NSString *cellText2 = [NSString stringWithFormat:@"Press prescritption for set up a new dose."];
              
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:cellText
                                                                message:cellText2
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                    [alert show];
                }
            }
        }
        // Next timer
        iRow++;
    }
    
    //Stop internal timer
    if(stopInternalTimer){
        [self stopTimer];
    }
    
    //Update all views
    ViewController *vewControler = [ViewController sharedViewController];
    [vewControler updateView];
    
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
        NSLog(@"applicationWillResignActive");

}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    int iCurrTimer;
    int iMinSecsRemaining=2147483647;
    Prescription *prescription=nil;
    
    //Look for the next time that is going to expire
    iCurrTimer=0;
    for(Prescription *currPrescription in arrPrescriptions){
        if(currPrescription.iSecsRemainingNextDose<iMinSecsRemaining &&
           currPrescription.iSecsRemainingNextDose>0 &&
           currPrescription.bPrescriptionHasStarted){
            iMinSecsRemaining=currPrescription.iSecsRemainingNextDose;
            prescription=currPrescription;
        }
    }
    
    if(iMinSecsRemaining>0 && iMinSecsRemaining<2147483647){
        //Programe an alert for the next timer that is going to expire
        //http://www.codeproject.com/Articles/124159/Hour-21-Building-Background-Aware-Applications
        

          UILocalNotification *scheduledAlert;
        
        /*
        UIAlertView *alertDialog;
      
        
        //todo: change message to the timer name
        alertDialog = [[UIAlertView alloc]
                       initWithTitle: @"Alert Button Selected"
                       message:@"I need your attention NOW (and in alittle bit)!"
                       delegate: nil
                       cancelButtonTitle: @"Ok"
                       otherButtonTitles: nil];
        
        [alertDialog show];
        //[alertDialog release];
*/ 
        
      //  NSString *cellText =  [NSString stringWithFormat:@"%@ %d unit(s)",prescription.sName,prescription.iUnitsTaken];
      //  NSString *cellText2 = [NSString stringWithFormat:@"Press prescritption for set up a new dose."];
        
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        scheduledAlert = [[UILocalNotification alloc] init] ;
        scheduledAlert.applicationIconBadgeNumber=1;
        scheduledAlert.fireDate = [NSDate dateWithTimeIntervalSinceNow:iMinSecsRemaining];
        scheduledAlert.timeZone = [NSTimeZone defaultTimeZone];
        scheduledAlert.repeatInterval =  NSDayCalendarUnit;
        //scheduledAlert.soundName=@"soundeffect.wav";
        scheduledAlert.alertBody = [NSString stringWithFormat:@"%@ %d unit(s) at %@",prescription.sName,prescription.iUnitsTaken,[prescription getStringNextDose]];
        
                
        [[UIApplication sharedApplication] scheduleLocalNotification:scheduledAlert];
    }
    
    //Invalidate Timer
    [self stopTimer];
    

    //Keep the timestamp when app went to Background
    dteEnteredInBackground=[NSDate date];
    
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.

    //Cancel all the notifications
    //[[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    //Calculate new iSecsRemaining
    NSDate *dteNow=[NSDate date];
    
    //Look for the next time that is going to expire
    for(Prescription *CurrPrescription in arrPrescriptions){
        NSTimeInterval secondsBetween = [CurrPrescription.dteNextDose timeIntervalSinceDate:dteNow];
        if(secondsBetween<=0)
            secondsBetween=0;
        CurrPrescription.iSecsRemainingNextDose=secondsBetween;
    }
    
    
    //Start the timer
    [self startTimer];
    
    

    
}

-(void) startTimer{
    // Restart the timer again
    tmr1SecTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                    target:self
                                                  selector:@selector(timerFired:)
                                                  userInfo:nil
                                                   repeats:YES];
    bTimerStarted=true;
}

-(void) stopTimer{
    [tmr1SecTimer invalidate];
    bTimerStarted=false;
}


- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSLog(@"applicationDidBecomeActive");
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    NSLog(@"applicationWillTerminate");
}

@end
