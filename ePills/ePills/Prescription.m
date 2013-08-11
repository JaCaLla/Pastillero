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
@synthesize bPrescriptionHasStarted;
@synthesize iSecsRemainingNextDose;
@synthesize bIsNextDoseExpired;
@synthesize s64imgChosenImage;


// Define array of seconds depending on doses intervals
unsigned int arrSecs[] = {3600*1, 3600*2, 3600*4, 3600*8, 3600*12,3600*24,3600*24*2,3600*24*4,3600*24*7,3600*24*14,3600*24*30,60,120,240};


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
        self.bPrescriptionHasStarted=false;
        self.bIsNextDoseExpired=true;
        self.iSecsRemainingNextDose=-1;
        self.s64imgChosenImage=nil;
        
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
        self.bPrescriptionHasStarted=false;
        self.bIsNextDoseExpired=true;
        self.iSecsRemainingNextDose=-1;
        self.s64imgChosenImage=nil;
    }
    return self;
    
}

-(id)initWithName:(NSString*)p_strName BoxUnits:(int)p_iBoxUnits UnitsTaken:(int)p_iUnitsTaken Dosis:(int)p_iDosis Image:(UIImage*)p_imgImage{
    
    if (self = [super init])
    {
        // Initialization code here
        self.sName=p_strName;
        self.iBoxUnits=p_iBoxUnits;
        self.iRemaining=p_iBoxUnits;
        self.iUnitsTaken=p_iUnitsTaken;
        self.tDosis=p_iDosis;
        self.dteNextDose=nil;
        self.bPrescriptionHasStarted=false;
        self.bIsNextDoseExpired=true;
        self.iSecsRemainingNextDose=-1;
        self.s64imgChosenImage=[self base64Encoding:UIImagePNGRepresentation(p_imgImage)];
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
        NSTimeInterval secondsBetween = [dteNextDose timeIntervalSinceDate:now];
        iSecsRemainingNextDose=secondsBetween;
    }
    
    //Start dose prescription
    bPrescriptionHasStarted=true;
    bIsNextDoseExpired=false;
    
    return self.iRemaining;
}

//Returns next dosis date in string format
-(NSString *) getStringNextDose{
    
    //Check if prescription has not started
    if(!bPrescriptionHasStarted)
        return @"--/---/-- --:--";
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"dd/MMM/yyyy hh:mm"];
    return[dateFormat stringFromDate:dteNextDose];
}

//Refills the box: set iRemaining to iBoxUnits
-(void) refillBox{
    iRemaining=iBoxUnits;
}

-(NSString*) getStringRemaining{
    
    int iDays,iHours,iMins,iSecs;
    int iModulus;
    NSString *strRemainingDDHHMMSS=@"Next dose not set.";
    
    iDays=iSecsRemainingNextDose/86400;
    iModulus=iSecsRemainingNextDose%86400;
    iHours=iModulus/3600;
    iModulus=iModulus%3600;
    iMins=iModulus/60;
    iSecs=iModulus%60;
    
    if(!bPrescriptionHasStarted)
        return strRemainingDDHHMMSS;
    
    if(iDays>0)
        strRemainingDDHHMMSS=[NSString stringWithFormat:@"Next dose: %d Day(s) %02dh:%02dm:%02ds",iDays,iHours,iMins,iSecs ];
    else if(iHours>0)
        strRemainingDDHHMMSS=[NSString stringWithFormat:@"Next dose: %02dh:%02dm:%02ds",iHours,iMins,iSecs];
    else if(iMins>0)
        strRemainingDDHHMMSS=[NSString stringWithFormat:@"Next dose: %02dm:%02ds",iMins,iSecs ];
    else
        strRemainingDDHHMMSS=[NSString stringWithFormat:@"Next dose: 00m:%02ds",iSecs ];
    
    return strRemainingDDHHMMSS;
}


- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.sName =[ decoder decodeObjectForKey:@"Name"];
        self.iBoxUnits = [decoder decodeInt32ForKey:@"BoxUnits"];
        self.iUnitsTaken = [decoder decodeInt32ForKey:@"UnitsTaken"];
        self.tDosis = [decoder decodeInt32ForKey:@"Dosis"];
        self.iRemaining = [decoder decodeInt32ForKey:@"Remaining"];
        self.dteNextDose = [decoder decodeObjectForKey:@"NextDose"];
        self.bPrescriptionHasStarted = [decoder decodeBoolForKey:@"PrescriptionHasStarted"];
        self.iSecsRemainingNextDose = [decoder decodeInt32ForKey:@"SecsRemainingNextDose"];
        self.bIsNextDoseExpired = [decoder decodeBoolForKey:@"IsNextDoseExpired"];
        self.s64imgChosenImage =[ decoder decodeObjectForKey:@"Image"];
    }
    return self;
}



- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.sName forKey:@"Name"];
    [encoder encodeInt32:self.iBoxUnits forKey:@"BoxUnits"];
    [encoder encodeInt32:self.iUnitsTaken forKey:@"UnitsTaken"];
    [encoder encodeInt32:self.tDosis forKey:@"Dosis"];
    [encoder encodeInt32:self.iRemaining forKey:@"Remaining"];
    [encoder encodeObject:self.dteNextDose forKey:@"NextDose"];
    [encoder encodeBool:self.bPrescriptionHasStarted forKey:@"PrescriptionHasStarted"];
    [encoder encodeInt32:self.iSecsRemainingNextDose forKey:@"SecsRemainingNextDose"];
    [encoder encodeBool:self.bIsNextDoseExpired forKey:@"IsNextDoseExpired"];
    [encoder encodeObject:self.s64imgChosenImage forKey:@"Image"];
}


static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

- (NSString *)base64Encoding:(NSData*)p_NSDataValue;
{
    if ([p_NSDataValue length] == 0)
        return @"";
    
    char *characters = malloc((([p_NSDataValue length] + 2) / 3) * 4);
    if (characters == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (i < [p_NSDataValue length])
    {
        char buffer[3] = {0,0,0};
        short bufferLength = 0;
        while (bufferLength < 3 && i < [p_NSDataValue length])
            buffer[bufferLength++] = ((char *)[p_NSDataValue bytes])[i++];
        
        //  Encode the bytes in the buffer to four characters, including padding "=" characters if necessary.
        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        if (bufferLength > 1)
            characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        else characters[length++] = '=';
        if (bufferLength > 2)
            characters[length++] = encodingTable[buffer[2] & 0x3F];
        else characters[length++] = '=';
    }
    
    return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
}

@end
