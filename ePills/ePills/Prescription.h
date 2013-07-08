//
//  Prescription.h
//  ePills
//
//  Created by JAVIER CALATRAVA LLAVERIA on 08/07/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Prescription : NSObject

@property NSString *strName;
@property int iBoxUnits;
@property int iDosis;

-(id)initWithName:(NSString*)p_strName BoxUnits:(int)p_iBoxUnits Dosis:(int)p_iDosis;

@end
