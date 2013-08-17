//
//  Prescription.h
//  ePills
//
//  Created by JAVIER CALATRAVA LLAVERIA on 08/07/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Prescription : NSObject <NSCoding>

typedef enum DosisType : NSUInteger {
    OneHour,
    TwoHours,
    FourHours,
    EightHours,
    TwelveHours,
    OneDay,
    TwoDays,
    FourDays,
    OneWeek,
    TwoWeeks,
    OneMonth,
    OneMin,
    TwoMin,
    FourMin
} ShapeType;

@property (strong,nonatomic) NSString *sName;
@property (nonatomic) int iBoxUnits;
@property (nonatomic) int iUnitsTaken;
@property (nonatomic) enum DosisType tDosis;
@property (nonatomic) int iRemaining;
@property (strong,nonatomic) NSDate *dteNextDose;
@property (nonatomic) bool bPrescriptionHasStarted;
@property (atomic) int  iSecsRemainingNextDose;
@property (atomic) bool bIsNextDoseExpired;
@property (nonatomic) NSData *dChosenImage;


-(id)initWithName:(NSString*)p_strName BoxUnits:(int)p_iBoxUnits UnitsTaken:(int)p_iUnitsTaken;
-(id)initWithName:(NSString*)p_strName BoxUnits:(int)p_iBoxUnits UnitsTaken:(int)p_iUnitsTaken Dosis:(int)p_iDosis;
-(id)initWithName:(NSString*)p_strName BoxUnits:(int)p_iBoxUnits UnitsTaken:(int)p_iUnitsTaken Dosis:(int)p_iDosis Image:(UIImage*)p_imgImage;

-(NSDate*) getLastDosisTaken:(NSDate*)p_dateFrom;
-(NSString*) getStringLastDosisTaken:(NSDate*)p_dateFrom;
-(int) doseCurrentPrescription;
-(NSString *) getStringNextDose;
-(NSString*) getStringRemaining;
-(void) refillBox;


@end
