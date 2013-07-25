//
//  Prescription.h
//  ePills
//
//  Created by JAVIER CALATRAVA LLAVERIA on 08/07/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Prescription : NSObject

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
    OneMonth
} ShapeType;

@property NSString *sName;
@property int iBoxUnits;
@property int iUnitsTaken;
@property enum DosisType tDosis;


-(id)initWithName:(NSString*)p_strName BoxUnits:(int)p_iBoxUnits UnitsTaken:(int)p_iUnitsTaken;
-(id)initWithName:(NSString*)p_strName BoxUnits:(int)p_iBoxUnits UnitsTaken:(int)p_iUnitsTaken Dosis:(int)p_iDosis;

@end
