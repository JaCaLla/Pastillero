//
//  Prescription.m
//  ePills
//
//  Created by JAVIER CALATRAVA LLAVERIA on 08/07/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import "Prescription.h"

@implementation Prescription

@synthesize sName;
@synthesize iBoxUnits;
@synthesize iUnitsTaken;
@synthesize tDosis;
@synthesize iRemaining;
@synthesize dteNextDose;

// Define array of seconds depending on doses intervals
unsigned int arrSecs[] = {3600*1, 3600*2, 3600*4, 3600*8, 3600*12,3600*24,3600*24*2,3600*24*4,3600*24*7,3600*24*14,3600*24*30};


-(id)initWithName:(NSString*)p_strName BoxUnits:(int)p_iBoxUnits UnitsTaken:(int)p_iUnitsTaken{
    if (self = [super init])
    {
        // Initialization code here
        self.sName=p_strName;
        self.iBoxUnits=p_iBoxUnits;
        self.iRemaining=p_iBoxUnits;
        self.iUnitsTaken=p_iUnitsTaken;
        self.tDosis=EightHours; // By default is EightHours dosis
        self.dteNextDose=nil;
        
    }
    return self;
}

-(id)initWithName:(NSString*)p_strName BoxUnits:(int)p_iBoxUnits UnitsTaken:(int)p_iUnitsTaken Dosis:(int)p_iDosis{
    
    if (self = [super init])
    {
        // Initialization code here
        self.sName=p_strName;
        self.iBoxUnits=p_iBoxUnits;
        self.iRemaining=p_iBoxUnits;
        self.iUnitsTaken=p_iUnitsTaken;
        self.tDosis=p_iDosis;
        self.dteNextDose=nil;
    }
    return self;
    
}

-(NSDate*) getLastDosisTaken:(NSDate*)p_dateFrom{

    unsigned int uiSecsShift=1;

    // Calculate the time shift
    uiSecsShift=self.iBoxUnits/self.iUnitsTaken*arrSecs[self.tDosis];
    
    //Calculate new date
    NSDate *dteLastDosis;
    if(p_dateFrom==nil){
        NSDate* now = [NSDate date];
        dteLastDosis = [now dateByAddingTimeInterval:uiSecsShift];
    }else{
        dteLastDosis = [p_dateFrom dateByAddingTimeInterval:uiSecsShift];
    }
    
    return dteLastDosis;
    

}

-(NSString *) getStringLastDosisTaken:(NSDate*)p_dateFrom{
    
    NSDate *dteLastDosis = [self getLastDosisTaken:p_dateFrom];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"dd/MMM/yyyy"];
    return[dateFormat stringFromDate:dteLastDosis];
}

//Take a dose: Reduce the remaining pills and calculate next dose
-(int) doseCurrentPrescription{

    
    if(self.iRemaining-self.iUnitsTaken>=0){ //In case there would not be enough pills for a dose
        self.iRemaining-=self.iUnitsTaken;
        
        // Calculate next dose
        NSDate* now = [NSDate date];
        dteNextDose = [now dateByAddingTimeInterval:arrSecs[self.tDosis]];
    }
    
    return self.iRemaining;
}

//Returns next dosis date in string format
-(NSString *) getStringNextDose{
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"dd/MMM/yyyy hh:mm"];
    return[dateFormat stringFromDate:dteNextDose];
}

//Refills the box: set iRemaining to iBoxUnits
-(void) refillBox{
    iRemaining=iBoxUnits;
}


@end
