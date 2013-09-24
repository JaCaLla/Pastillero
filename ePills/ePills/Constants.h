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

#define SPANISH_MEDICINES @"Acfol",@"Actonel",@"Adiro 100",@"Adiro 300",@"Aerius",@"Aero-red",@"Airtal",@"Algidol",@"Almax",@"Amoxicilina Normon",@"Anagastra",@"Analgilasa",@"Antalgin",@"Aspirina adultos",@"Aspirina C",@"Augmentine",@"Carduran Neo",@"Cardyl",@"Clamoxyl",@"Co-Diován",@"Coropres",@"Couldina.",@"Cozaar",@"Daflon 500",@"Dalsy",@"Dianben",@"Diane 35",@"Diazepan Prodes.",@"Dogmatil",@"Dolalgial",@"Duphalac",@"Ebastel",@"Efferalgan",@"Enalapril Ratiopharm efg.",@"Enantyum",@"Espidifen",@"Eutirox",@"Fero-gradumet",@"Flatoril",@"Flumil",@"Flutox",@"Fortasec",@"Fosamax",@"Frenadol complex",@"Furosemida Cinfa",@"Gelocatil",@"Hidrosaluretil",@"Ibuprofeno Cinfa",@"Ibuprofeno Kern",@"Idalprem",@"Idaptan",@"Levothroid",@"Lexatin",@"Lizipaina",@"Lorazepam Normon",@"Lormetazepam Normon",@"Metamizol Normon",@"Metformina Sandoz",@"Monurol",@"Motilium",@"Mucosan",@"Myolastan",@"Neobrufen",@"Noctamid",@"Nolotil",@"Norvas",@"Omeprazol Cinfamed",@"Omeprazol Davur",@"Omeprazol Pensa",@"Omeprazol Ratiopharm",@"Orfidal Wyeth",@"Pantecta",@"Paracetamol Kern",@"Paracetamol Pharmagenus",@"Plantaben",@"Plavix",@"Polaramine",@"Prevencor",@"Primperan",@"Seguril",@"Serc.",@"Singulair",@"Sintrom",@"Stilnox",@"Sutril",@"Tardyferon",@"Termalgin",@"Tertensif Retard",@"Trankimazin",@"Tranxilium",@"Tromalyt",@"Voltarén",@"Xumadol",@"Yasmín",@"Zaldiar",@"Zarator",@"Zinnat",@"Zyloric"
#define SPANISH_MEDICINES_PNG @"Acfol.png",@"Actonel.png",@"Adiro.png",@"Adiro300.png",@"Aerius.png",@"Aero-Red.png",@"Airtal.png",@"Algidol.png",@"Almax.png",@"AmoxicilinaN.png",@"Anagastra.png",@"Analgilasa.png",@"Antalgin.png",@"Aspirina.png",@"AspirinaC.png",@"Augmentine.png",@"Carduran.png",@"Cardyl.png",@"Clamoxyl.png",@"CoDiovan.png",@"Coropres.png",@"Couldina.png",@"Cozaar.png",@"Daflon500.png",@"Dalsy.png",@"Dianben.png",@"Diane35.png",@"DiazepanP.png",@"Dogmatil.png",@"Dolalgial.png",@"Duphalac.png",@"Ebastel.png",@"Efferalgan.png",@"Enalapril.png",@"Enantyum.png",@"Espidifen.png",@"Eutirox.png",@"FeroGradumet.png",@"Flatoril.png",@"Flumil.png",@"Flutox.png",@"Fortasec.png",@"Fosamax.png",@"Frenadol.png",@"FurosemidaC.png",@"Gelocatil.png",@"Hidrosaluretil.png",@"IbuprofenoC.png",@"IbuprofenoKern.png",@"Idalprem.png",@"Idaptan.png",@"Levothroid.png",@"Lexatin.png",@"Lizipaina.png",@"LorazepanN.png",@"LormetazepamN.png",@"MetamizolN.png",@"Metformina.png",@"Monurol.png",@"Motilium.png",@"Mucosan.png",@"Myolastan.png",@"Neobrufen.png",@"Noctamid.png",@"Nolotil.png",@"Norvas.png",@"OmeprazolC.png ",@"OmeprazolD.png",@"OmeprazolP.png",@"OmeprazolR.png",@"Orfidal.png",@"Pantecta.png",@"ParacetamolKern.png",@"ParacetamolP.png",@"Plantaben.png",@"Plavix.png",@"Polaramine.png",@"Prevencor.png",@"Primperan.png",@"Seguril.png",@"Serc.png",@"Singulair.png",@"Sintron.png",@"Stilnox.png",@"Sutril.png",@"Tardyferon.png",@"Termalgin.png",@"Tertensif.png",@"Trankimazin.png",@"Tranxilium.png",@"Tromalyt.png",@"Voltaren.png",@"Xumadol.png",@"Yasmin.png",@"Zaldiar.png",@"Zarator.png",@"Zinnat.png",@"Zyloric.png"

//Information messages
//#define MSG_NO_PRESCRIPTIONS1 @"Prescription list was empty."
//#define MSG_NO_PRESCRIPTIONS2 @"It has been created a sample prescription, just select it and uptdate information."
//#define MSG_LAST_DOSE1 @"You spent last dose."
//#define MSG_LAST_DOSE2 @"You finished the prescription or you will need to get a new medicine."
//#define MSG_NO_PILLS_FOR_DOSE1 @"Not enough units."
//#define MSG_NO_PILLS_FOR_DOSE2 @"Please, refill prescription."


// Error messages
//#define ERR_TITLE @"Error"
//#define ERR_NAME_EMPTY @"Medicine name is empty."
//#define ERR_BOXUNITS_EMPTY @"Box units is empty."
//#define ERR_BOUXUNITS_OUTOFRANGE @"Box units must be between %d and %d."
//#define ERR_UNITSTAKEN_EMPTY @"Dosis is empty."
//#define ERR_UNITSTAKEN_ZERO @"Dosis must be different from zero."
//#define ERR_UNITSTAKEN_GREATERTHAN_BOXUNITS @"Dosis cannot be greater box units."


#endif
