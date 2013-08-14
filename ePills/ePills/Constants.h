//
//  Constants.h
//  ePills
//
//  Created by JAVIER CALATRAVA LLAVERIA on 27/07/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#ifndef ePills_Constants_h
#define ePills_Constants_h

#define MIN_BOXUNITS 1
#define MAX_BOXUNITX 100

//Information messages
#define MSG_NO_PRESCRIPTIONS1 @"Prescription list was empty."
#define MSG_NO_PRESCRIPTIONS2 @"It has been created a sample prescription, just select it and uptdate information."

// Error messages
#define ERR_TITLE @"Error"
#define ERR_NAME_EMPTY @"Medicine name is empty."
#define ERR_BOXUNITS_EMPTY @"Box units is empty."
#define ERR_BOUXUNITS_OUTOFRANGE @"Box units must be between %d and %d."
#define ERR_UNITSTAKEN_EMPTY @"Dosis is empty."
#define ERR_UNITSTAKEN_ZERO @"Dosis must be different from zero."
#define ERR_UNITSTAKEN_GREATERTHAN_BOXUNITS @"Dosis cannot be greater box units."

#endif
