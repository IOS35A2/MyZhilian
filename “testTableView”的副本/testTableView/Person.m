//
//  Person.m
//  testTableView
//
//  Created by Ibokan on 12-8-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Person.h"
@implementation Person
@synthesize name=_name,phoneNumber=_phoneNumber;




+(id)personWithName:(NSString *)name phoneNumber:(double)phoneNumber
{
    Person *p =[[Person alloc]init];
    p.name =name;
    p.phoneNumber =phoneNumber;
    return [p autorelease];
}




@end
