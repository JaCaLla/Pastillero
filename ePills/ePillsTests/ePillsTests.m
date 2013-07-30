//
//  ePillsTests.m
//  ePillsTests
//
//  Created by JAVIER CALATRAVA LLAVERIA on 06/07/13.
//  Copyright (c) 2013 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import "ePillsTests.h"
#import "testPrescription.h"

@implementation ePillsTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    testPrescription *test=[[testPrescription alloc]init];
    [test runTest];
    
    //STFail(@"Unit tests are not implemented yet in ePillsTests");
}

@end
