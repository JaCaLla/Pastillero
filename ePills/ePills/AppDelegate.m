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
#import "Constants.h"
#import "GAI.h"



// Defining this object as a singleton View controllers can call its methods
static AppDelegate *sharedInstance;

@implementation AppDelegate{
    
}

@synthesize arrPrescriptions;
@synthesize idxPrescriptions;
@synthesize tmr1SecTimer;
@synthesize avAudioPlayer;

//Insert new prescription


//Application routines:Begin
-(id) init{
    
    if(sharedInstance){
        NSLog(@"Error: You are creating a second AppDelegate!");
    }
    
    self=[super init];
    sharedInstance=self;
    
    
    //Store prescriptions in a file
    [self loadState];
    //Update prescription remaining secs for next dose
    [self updatePrescriptionTimers];
    //Start the timer
    [self startTimer];
    
    return self;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    
    //Google Analytics stuff:BEGIN
    // Optional: automatically send uncaught exceptions to Google Analytics.
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    
    // Optional: set Google Analytics dispatch interval to e.g. 20 seconds.
    [GAI sharedInstance].dispatchInterval = 20;
    
    // Optional: set Logger to VERBOSE for debug information.
    [[[GAI sharedInstance] logger] setLogLevel:kGAILogLevelVerbose];
    
    // Initialize tracker.
    [[GAI sharedInstance] trackerWithTrackingId:@"UA-43230251-2"];    
    //Google Analytics stuff:END
    
    return YES;
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
       NSLog(@"");
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
       NSLog(@"");
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    NSLog(@"");

}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    int iCurrTimer;
    int iMinSecsRemaining=2147483647;
    //Prescription *prescription=nil;
   
    //Look for the next time that is going to expire
    iCurrTimer=0;
    for(Prescription *currPrescription in arrPrescriptions){

        if(currPrescription.bPrescriptionHasStarted){
            UILocalNotification *scheduledAlert;
        
            iMinSecsRemaining=currPrescription.iSecsRemainingNextDose;
        
            //[[UIApplication sharedApplication] cancelAllLocalNotifications];
            scheduledAlert = [[UILocalNotification alloc] init] ;
            scheduledAlert.applicationIconBadgeNumber=1;
            scheduledAlert.fireDate = [NSDate dateWithTimeIntervalSinceNow:iMinSecsRemaining];
            scheduledAlert.timeZone = [NSTimeZone defaultTimeZone];
            scheduledAlert.repeatInterval =  NSDayCalendarUnit;
            scheduledAlert.soundName=@"bells.wav";
            scheduledAlert.alertBody = [NSString stringWithFormat:NSLocalizedString(@"UNITS_AT", nil),currPrescription.sName,currPrescription.iUnitsTaken,[currPrescription getStringNextDose]];
        
        
            [[UIApplication sharedApplication] scheduleLocalNotification:scheduledAlert];
        }
    }
  

    //Invalidate Timer
    [self stopTimer];
    
    //Keep the timestamp when app went to Background
    dteEnteredInBackground=[NSDate date];
    
    //Store prescriptions in a file
    [self saveState];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    //Remove notifications from the icon
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    
    //Update prescription remaining secs for next dose
    [self updatePrescriptionTimers];
    //Start the timer
    [self startTimer];
}
//Application routines:End

-(void) updatePrescriptionTimers{
    //Cancel all local notifications
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    //Calculate new iSecsRemaining
    NSDate *dteNow=[NSDate date];
    
    //Look for the next time that is going to expire
    for(Prescription *CurrPrescription in arrPrescriptions){
        NSTimeInterval secondsBetween = [CurrPrescription.dteNextDose timeIntervalSinceDate:dteNow];
        //if(secondsBetween<=0)
        //    secondsBetween=0;
        CurrPrescription.iSecsRemainingNextDose=secondsBetween;
    }
    

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
-(void) updatePrescription:(Prescription*)p_Prescription{

    Prescription *prescription=[arrPrescriptions objectAtIndex:idxPrescriptions];
    prescription.sName=p_Prescription.sName;
    prescription.iBoxUnits=p_Prescription.iBoxUnits;
    prescription.iUnitsTaken=p_Prescription.iUnitsTaken;
    prescription.dChosenImage=p_Prescription.dChosenImage;
    prescription.tDosis=p_Prescription.tDosis;
    
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

    if(arrPrescriptions==nil){
        arrPrescriptions = [[NSMutableArray alloc]init];
    }
        
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
                /*
                    NSURL *url=[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/bells.wav",[NSBundle mainBundle]]];
                    
                    NSError *error;
                    avAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
                    avAudioPlayer.numberOfLoops=0;
                    
                    [avAudioPlayer play];
                  */
                     NSError *error;
                    NSString *soundPath =[[NSBundle mainBundle] pathForResource:@"bells" ofType:@"wav"];

                    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:soundPath] error:&error];
                   // player.numberOfLoops=1;
                   // [player prepareToPlay];
                    [player play];
                    
                    
                    
                    
                    NSString *cellText =  [NSString stringWithFormat:NSLocalizedString(@"UNITS", nil),tmrCurr.sName,tmrCurr.iUnitsTaken];
                    NSString *cellText2 = [NSString stringWithFormat:NSLocalizedString(@"PRESS_PRESCRIPTION", nil)];
              
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:cellText
                                                                message:cellText2
                                                               delegate:nil
                                                      cancelButtonTitle:NSLocalizedString(@"OK", nil)
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



#pragma mark -
#pragma mark Saving Methods

-(NSString*) prescriptionsFilename{
 /*   NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    
    //2) Create the full file path by appending the desired file name
   return [documentsDirectory stringByAppendingPathComponent:@"presc.dat"];
 */
    
    NSString *applicationDocumentsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return  [applicationDocumentsDir stringByAppendingPathComponent:@"prescriptions.txt"];
    
    
}
- (void)saveState{
    NSError *error;

    //NSLog(@"saveState:%@",[self prescriptionsFilename]);
    
    //Write array into a file
    NSData * myData = [NSKeyedArchiver archivedDataWithRootObject:arrPrescriptions];
    //BOOL result = [myData writeToFile:[self prescriptionsFilename] atomically:YES];
    if (![myData writeToFile:[self prescriptionsFilename] atomically:YES]) {
        NSLog(@"There was an error saving: %@", error);
    }

}

-(void) loadState{
    
    arrPrescriptions = [[NSMutableArray alloc]init];
 
    NSLog(@"loadState:%@",[self prescriptionsFilename]);
 
    NSData * myData = [NSData dataWithContentsOfFile:[self prescriptionsFilename]];
    
    if(myData!=NULL){
        arrPrescriptions = [NSKeyedUnarchiver unarchiveObjectWithData:myData];
    }
    else{
        //Add a sample prescription when there are not any prescription
        if([arrPrescriptions count]==0){
            // Create a sample prescription
            Prescription *prescription = [[Prescription alloc] initWithName:NSLocalizedString(@"MEDICINE_SAMPLE_NAME", nil) BoxUnits:20 UnitsTaken:1 Dosis:3 Image:[UIImage imageNamed:@"SampleMedicine.png"]];
            [arrPrescriptions addObject:prescription];
        
            //Save state
            [self saveState];
            //Load state
            myData = [NSData dataWithContentsOfFile:[self prescriptionsFilename]];
            arrPrescriptions = [NSKeyedUnarchiver unarchiveObjectWithData:myData];
        
            // Show an informational message
            NSString *cellText1 =  [NSString stringWithFormat:NSLocalizedString(@"MSG_NO_PRESCRIPTIONS1", nil)];
            NSString *cellText2 = [NSString stringWithFormat:NSLocalizedString(@"MSG_NO_PRESCRIPTIONS2", nil)];
        
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:cellText1
                                                        message:cellText2
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                              otherButtonTitles:nil];
            [alert show];        
        }
    }
 

}

@end
