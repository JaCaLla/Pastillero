//
//  DataBase.h
//  MultiTimer2
//
//  Created by JAVIER CALATRAVA LLAVERIA on 02/08/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface DataBase : NSObject {
    //Core Stuff:Begin
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    //Core Stuff:End
}

//Core Stuff:Begin
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
//Core Stuff:End

// Gets the prescription list from database
-(NSArray*) getPrescriptions;
// Sets the prescription list to database
-(void) setPrescriptions:(NSArray*)arrPrescriptions;

@end
