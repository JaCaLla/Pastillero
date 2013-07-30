//
//  testPrescription.m
//  ePills
//
//  Created by JAVIER CALATRAVA LLAVERIA on 30/07/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import "testPrescription.h"
#import "Prescription.h"

@implementation testPrescription

-(void) runTest{
    
    [self test_getLastDosisTaken];
    
}



-(void) test_getLastDosisTaken{
    
    //NSCalendar *gregorian=[[NSCalendar alloc] initWithCalendarIdentifier: NSISO8601Calendar];

    
   
    //Create base test for whole testcases
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //[formatter setCalendar: gregorian];
    [formatter setDateFormat:@"YYYY'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
    NSDate *dteBase = [formatter dateFromString:@"2013-01-01T00:00:00Z"];
    NSDate *dteLastDosis;
    NSDate *dteExpected;
    Prescription *prescription;
    
    // Test case
    prescription = [[Prescription alloc] initWithName:@"Frenadol" BoxUnits:1 UnitsTaken:1];
    dteLastDosis=[prescription getLastDosisTaken:dteBase];
    dteExpected =[formatter dateFromString:@"2013-01-01T08:00:00Z"];
    STAssertEquals([dteLastDosis compare:dteExpected], NSOrderedSame, @"test_getLastDosisTaken!");
    // Test case
    prescription = [[Prescription alloc] initWithName:@"Frenadol" BoxUnits:2 UnitsTaken:1];
    dteLastDosis=[prescription getLastDosisTaken:dteBase];
    dteExpected =[formatter dateFromString:@"2013-01-01T16:00:00Z"];
    STAssertEquals([dteLastDosis compare:dteExpected], NSOrderedSame, @"test_getLastDosisTaken!");
    // Test case
    prescription = [[Prescription alloc] initWithName:@"Frenadol" BoxUnits:2 UnitsTaken:2];
    dteLastDosis=[prescription getLastDosisTaken:dteBase];
    dteExpected =[formatter dateFromString:@"2013-01-01T08:00:00Z"];
    STAssertEquals([dteLastDosis compare:dteExpected], NSOrderedSame, @"test_getLastDosisTaken!");
    // Test case
    prescription = [[Prescription alloc] initWithName:@"Frenadol" BoxUnits:3 UnitsTaken:1];
    dteLastDosis=[prescription getLastDosisTaken:dteBase];
    dteExpected =[formatter dateFromString:@"2013-01-02T00:00:00Z"];
    STAssertEquals([dteLastDosis compare:dteExpected], NSOrderedSame, @"test_getLastDosisTaken!");
    // Test case
    prescription = [[Prescription alloc] initWithName:@"Frenadol" BoxUnits:3 UnitsTaken:2];
    dteLastDosis=[prescription getLastDosisTaken:dteBase];
    dteExpected =[formatter dateFromString:@"2013-01-01T08:00:00Z"];
    STAssertEquals([dteLastDosis compare:dteExpected], NSOrderedSame, @"test_getLastDosisTaken!");
    // Test case
    prescription = [[Prescription alloc] initWithName:@"Frenadol" BoxUnits:3 UnitsTaken:3];
    dteLastDosis=[prescription getLastDosisTaken:dteBase];
    dteExpected =[formatter dateFromString:@"2013-01-01T08:00:00Z"];
    STAssertEquals([dteLastDosis compare:dteExpected], NSOrderedSame, @"test_getLastDosisTaken!");
    // Test case
    prescription = [[Prescription alloc] initWithName:@"Frenadol" BoxUnits:4 UnitsTaken:1];
    dteLastDosis=[prescription getLastDosisTaken:dteBase];
    dteExpected =[formatter dateFromString:@"2013-01-02T08:00:00Z"];
    STAssertEquals([dteLastDosis compare:dteExpected], NSOrderedSame, @"test_getLastDosisTaken!");
    // Test case
    prescription = [[Prescription alloc] initWithName:@"Frenadol" BoxUnits:4 UnitsTaken:2];
    dteLastDosis=[prescription getLastDosisTaken:dteBase];
    dteExpected =[formatter dateFromString:@"2013-01-01T16:00:00Z"];
    STAssertEquals([dteLastDosis compare:dteExpected], NSOrderedSame, @"test_getLastDosisTaken!");
    // Test case
    prescription = [[Prescription alloc] initWithName:@"Frenadol" BoxUnits:4 UnitsTaken:3];
    dteLastDosis=[prescription getLastDosisTaken:dteBase];
    dteExpected =[formatter dateFromString:@"2013-01-01T08:00:00Z"];
    STAssertEquals([dteLastDosis compare:dteExpected], NSOrderedSame, @"test_getLastDosisTaken!");
    // Test case
    prescription = [[Prescription alloc] initWithName:@"Frenadol" BoxUnits:17 UnitsTaken:1];
    dteLastDosis=[prescription getLastDosisTaken:dteBase];
    dteExpected =[formatter dateFromString:@"2013-01-06T16:00:00Z"];
    STAssertEquals([dteLastDosis compare:dteExpected], NSOrderedSame, @"test_getLastDosisTaken!");
    // Test case
    prescription = [[Prescription alloc] initWithName:@"Frenadol" BoxUnits:34 UnitsTaken:2];
    dteLastDosis=[prescription getLastDosisTaken:dteBase];
    dteExpected =[formatter dateFromString:@"2013-01-06T16:00:00Z"];
    STAssertEquals([dteLastDosis compare:dteExpected], NSOrderedSame, @"test_getLastDosisTaken!");
    // Test case
    prescription = [[Prescription alloc] initWithName:@"Frenadol" BoxUnits:51 UnitsTaken:3];
    dteLastDosis=[prescription getLastDosisTaken:dteBase];
    dteExpected =[formatter dateFromString:@"2013-01-06T16:00:00Z"];
    STAssertEquals([dteLastDosis compare:dteExpected], NSOrderedSame, @"test_getLastDosisTaken!");
    // Test case: 1 hour dose
    prescription = [[Prescription alloc] initWithName:@"Licipaina" BoxUnits:1 UnitsTaken:1 Dosis:0];
    dteLastDosis=[prescription getLastDosisTaken:dteBase];
    dteExpected =[formatter dateFromString:@"2013-01-01T01:00:00Z"];
    STAssertEquals([dteLastDosis compare:dteExpected], NSOrderedSame, @"test_getLastDosisTaken!");
    // Test case: 1 hour dose
    prescription = [[Prescription alloc] initWithName:@"Licipaina" BoxUnits:34 UnitsTaken:1 Dosis:0];
    dteLastDosis=[prescription getLastDosisTaken:dteBase];
    dteExpected =[formatter dateFromString:@"2013-01-02T10:00:00Z"];
    STAssertEquals([dteLastDosis compare:dteExpected], NSOrderedSame, @"test_getLastDosisTaken!");
    // Test case: 2 hour dose
    prescription = [[Prescription alloc] initWithName:@"Licipaina" BoxUnits:1 UnitsTaken:1 Dosis:1];
    dteLastDosis=[prescription getLastDosisTaken:dteBase];
    dteExpected =[formatter dateFromString:@"2013-01-01T02:00:00Z"];
    STAssertEquals([dteLastDosis compare:dteExpected], NSOrderedSame, @"test_getLastDosisTaken!");
    // Test case: 2 hour dose
    prescription = [[Prescription alloc] initWithName:@"Licipaina" BoxUnits:34 UnitsTaken:1 Dosis:1];
    dteLastDosis=[prescription getLastDosisTaken:dteBase];
    dteExpected =[formatter dateFromString:@"2013-01-03T20:00:00Z"];
    STAssertEquals([dteLastDosis compare:dteExpected], NSOrderedSame, @"test_getLastDosisTaken!");
    // Test case: 4 hour dose
    prescription = [[Prescription alloc] initWithName:@"Licipaina" BoxUnits:1 UnitsTaken:1 Dosis:2];
    dteLastDosis=[prescription getLastDosisTaken:dteBase];
    dteExpected =[formatter dateFromString:@"2013-01-01T04:00:00Z"];
    STAssertEquals([dteLastDosis compare:dteExpected], NSOrderedSame, @"test_getLastDosisTaken!");
    // Test case: 4 hour dose
    prescription = [[Prescription alloc] initWithName:@"Licipaina" BoxUnits:34 UnitsTaken:1 Dosis:2];
    dteLastDosis=[prescription getLastDosisTaken:dteBase];
    dteExpected =[formatter dateFromString:@"2013-01-06T16:00:00Z"];
    STAssertEquals([dteLastDosis compare:dteExpected], NSOrderedSame, @"test_getLastDosisTaken!");
    // Test case: 12 hour dose
    prescription = [[Prescription alloc] initWithName:@"Licipaina" BoxUnits:1 UnitsTaken:1 Dosis:4];
    dteLastDosis=[prescription getLastDosisTaken:dteBase];
    dteExpected =[formatter dateFromString:@"2013-01-01T12:00:00Z"];
    STAssertEquals([dteLastDosis compare:dteExpected], NSOrderedSame, @"test_getLastDosisTaken!");
    // Test case: 12 hour dose
    prescription = [[Prescription alloc] initWithName:@"Licipaina" BoxUnits:10 UnitsTaken:1 Dosis:4];
    dteLastDosis=[prescription getLastDosisTaken:dteBase];
    dteExpected =[formatter dateFromString:@"2013-01-06T00:00:00Z"];
    STAssertEquals([dteLastDosis compare:dteExpected], NSOrderedSame, @"test_getLastDosisTaken!");
    // Test case: 24 hour dose
    prescription = [[Prescription alloc] initWithName:@"Licipaina" BoxUnits:1 UnitsTaken:1 Dosis:5];
    dteLastDosis=[prescription getLastDosisTaken:dteBase];
    dteExpected =[formatter dateFromString:@"2013-01-02T00:00:00Z"];
    STAssertEquals([dteLastDosis compare:dteExpected], NSOrderedSame, @"test_getLastDosisTaken!");
    // Test case: 24 hour dose
    prescription = [[Prescription alloc] initWithName:@"Licipaina" BoxUnits:10 UnitsTaken:1 Dosis:5];
    dteLastDosis=[prescription getLastDosisTaken:dteBase];
    dteExpected =[formatter dateFromString:@"2013-01-11T00:00:00Z"];
    STAssertEquals([dteLastDosis compare:dteExpected], NSOrderedSame, @"test_getLastDosisTaken!");
    // Test case: 2 days dose
    prescription = [[Prescription alloc] initWithName:@"Licipaina" BoxUnits:1 UnitsTaken:1 Dosis:6];
    dteLastDosis=[prescription getLastDosisTaken:dteBase];
    dteExpected =[formatter dateFromString:@"2013-01-03T00:00:00Z"];
    STAssertEquals([dteLastDosis compare:dteExpected], NSOrderedSame, @"test_getLastDosisTaken!");
    // Test case: 2 days dose
    prescription = [[Prescription alloc] initWithName:@"Licipaina" BoxUnits:10 UnitsTaken:1 Dosis:6];
    dteLastDosis=[prescription getLastDosisTaken:dteBase];
    dteExpected =[formatter dateFromString:@"2013-01-21T00:00:00Z"];
    STAssertEquals([dteLastDosis compare:dteExpected], NSOrderedSame, @"test_getLastDosisTaken!");
    // Test case: 4 days dose
    prescription = [[Prescription alloc] initWithName:@"Licipaina" BoxUnits:1 UnitsTaken:1 Dosis:7];
    dteLastDosis=[prescription getLastDosisTaken:dteBase];
    dteExpected =[formatter dateFromString:@"2013-01-05T00:00:00Z"];
    STAssertEquals([dteLastDosis compare:dteExpected], NSOrderedSame, @"test_getLastDosisTaken!");
    // Test case: 1 week dose
    prescription = [[Prescription alloc] initWithName:@"Licipaina" BoxUnits:1 UnitsTaken:1 Dosis:8];
    dteLastDosis=[prescription getLastDosisTaken:dteBase];
    dteExpected =[formatter dateFromString:@"2013-01-08T00:00:00Z"];
    STAssertEquals([dteLastDosis compare:dteExpected], NSOrderedSame, @"test_getLastDosisTaken!");
    // Test case: 2 weeks dose
    prescription = [[Prescription alloc] initWithName:@"Licipaina" BoxUnits:1 UnitsTaken:1 Dosis:9];
    dteLastDosis=[prescription getLastDosisTaken:dteBase];
    dteExpected =[formatter dateFromString:@"2013-01-15T00:00:00Z"];
    STAssertEquals([dteLastDosis compare:dteExpected], NSOrderedSame, @"test_getLastDosisTaken!");
    // Test case: 1 month dose
    prescription = [[Prescription alloc] initWithName:@"Licipaina" BoxUnits:1 UnitsTaken:1 Dosis:10];
    dteLastDosis=[prescription getLastDosisTaken:dteBase];
    dteExpected =[formatter dateFromString:@"2013-01-31T00:00:00Z"];
    STAssertEquals([dteLastDosis compare:dteExpected], NSOrderedSame, @"test_getLastDosisTaken!");
    /*
     
     NSDateFormatter *format = [[NSDateFormatter alloc] init];
     [format setDateFormat:@"dd MMM yyyy HH:mm"];
     NSString *strReceived = [format stringFromDate:dteLastDosis];
     NSString *strExpected = [format stringFromDate:dteExpected];
     NSLog(@"Received:%@ Expected:%@",strReceived,strExpected);
     */
    
    
    /*
    if ( == NSOrderedDescending) {
        NSLog(@"date1 is later than dteExpected");
        
    } else if ([dteLastDosis compare:dteExpected] == NSOrderedAscending) {
        NSLog(@"date1 is earlier than dteExpected");
        
    } else {
        NSLog(@"dates are the same");
        
    }
    */
    /*
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"dd MMM yyyy HH:mm"];
    NSString *strReceived = [format stringFromDate:dteLastDosis];
    NSString *strExpected = [format stringFromDate:dteExpected];
    NSLog(@"Received:%@ Expected:%@",strReceived,strExpected);
    */
    
    
}

@end
