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
@synthesize iDosis;

-(id)initWithName:(NSString*)p_strName BoxUnits:(int)p_iBoxUnits Dosis:(int)p_iDosis
{
    if (self = [super init])
    {
        // Initialization code here
        self.sName=p_strName;
        self.iBoxUnits=p_iBoxUnits;
        self.iDosis=p_iDosis;
        
    }
    return self;
}

@end
