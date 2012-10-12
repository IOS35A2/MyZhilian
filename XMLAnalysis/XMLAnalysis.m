//
//  XMLAnalysis.m
//  XMLAnalysis
//
//  Created by Ibokan on 12-10-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "XMLAnalysis.h"
#import "GDataXMLNode.h"


@implementation XMLAnalysis
+ (NSMutableArray*)XMLAnalysisJob
{
    
    NSString *str = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"basedata" ofType:@"xml"] encoding:NSUTF8StringEncoding error:nil];
    
    //解析XML，把结果放在document里面。
    GDataXMLDocument *document=[[GDataXMLDocument alloc]initWithXMLString:str options:0 error:nil];
    
    GDataXMLElement *root=[document rootElement];//获得根节点
    
    NSArray *arr=  [root nodesForXPath:@"basedata/jobtype/item" error:nil] ;
    NSMutableArray *marr = [NSMutableArray arrayWithCapacity:1];
    for(GDataXMLElement *item in arr)
    {
        [marr addObject:[item stringValue]];
        
    } 
    return marr;

    
}

+ (NSMutableArray*)XMLAnalysisSmallJob:(NSString*)samllJob
{
    NSString *str = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"basedata" ofType:@"xml"] encoding:NSUTF8StringEncoding error:nil];
    
    //解析XML，把结果放在document里面。
    GDataXMLDocument *document=[[GDataXMLDocument alloc]initWithXMLString:str options:0 error:nil];
    
    GDataXMLElement *root=[document rootElement];//获得根节点
    
    NSArray *arr=  [root nodesForXPath:@"basedata/jobtype/item" error:nil] ;
    NSMutableArray *marr = [NSMutableArray arrayWithCapacity:1];
    for(GDataXMLElement *item in arr)
    {
        [marr addObject:[item stringValue]];
        
    } 

    for(int i=0;i<[marr count];i++)
    {
    
    if([samllJob isEqualToString:[marr objectAtIndex:i]]==YES)
    {
        NSArray *arr1 = [root nodesForXPath:@"basedata/small_Job_type/item" error:nil];
        NSMutableArray *marr1 = [NSMutableArray arrayWithCapacity:10];

        for(int i=0;i<[arr1 count];i++)
        {
            if([[[arr1 objectAtIndex:i]stringValue]isEqualToString:samllJob]==YES)
            {
                for(int j = i;j<[arr1 count];j++)
                {
                [marr1 addObject:[[arr1 objectAtIndex:j]stringValue]];
                if([[[arr1 objectAtIndex:j]stringValue]isEqualToString:@"其他"]==YES)
                {
                    return marr1;
                }
                }
            }
        }

        
    }
    }
    
 

   
    return marr;
    
    
    
}

+(NSMutableArray*)XMLAnalysisIndustry
{
    NSString *str = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"basedata" ofType:@"xml"] encoding:NSUTF8StringEncoding error:nil];
    
    //解析XML，把结果放在document里面。
    GDataXMLDocument *document=[[GDataXMLDocument alloc]initWithXMLString:str options:0 error:nil];
    
    GDataXMLElement *root=[document rootElement];//获得根节点
    
    NSArray *arr=  [root nodesForXPath:@"basedata/industry/item" error:nil] ;
    NSMutableArray *marr = [NSMutableArray arrayWithCapacity:1];
    for(GDataXMLElement *item in arr)
    {
        [marr addObject:[item stringValue]];
        
    } 

    return marr;
    
}


@end
