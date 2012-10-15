//
//  Person.h
//  testTableView
//
//  Created by Ibokan on 12-8-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property(nonatomic,retain)NSString *name;
@property(nonatomic,assign)double phoneNumber;
+(id)personWithName:(NSString *)name phoneNumber:(double)phoneNumbe;

@end

