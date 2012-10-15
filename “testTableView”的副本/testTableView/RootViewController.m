//
//  RootViewController.m
//  testTableView
//
//  Created by Ibokan on 12-8-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "Person.h"

@implementation RootViewController
@synthesize personDic=_personDic;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle



-(void)initTableDate
{
    Person *cws = [Person personWithName:@"陈伟帅" phoneNumber:45556446];
    Person *cj = [Person personWithName:@"陈军" phoneNumber:4545458];
    Person *csp = [Person personWithName:@"陈世鹏" phoneNumber:4445777];
    NSArray * cArray = [NSArray arrayWithObjects:cws,cj,csp, nil];
    
    Person *dlz = [Person personWithName:@"董林忠" phoneNumber:45556446];
    Person *dhq = [Person personWithName:@"董红强" phoneNumber:4545458];
    Person *dbs = [Person personWithName:@"董冰雪" phoneNumber:4445777];
    Person *djy = [Person personWithName:@"戴俊友" phoneNumber:4445777];
    NSArray * dArray = [NSArray arrayWithObjects:dlz,dhq,dbs,djy, nil];
    
    Person *flt = [Person personWithName:@"法梁涛" phoneNumber:4445777];
    NSArray *fArray = [NSArray arrayWithObjects:flt, nil];
    
    Person *gxm = [Person personWithName:@"国学门" phoneNumber:4545458];
    Person *gfl = [Person personWithName:@"郭福亮" phoneNumber:4445777];
    NSArray * gArray = [NSArray arrayWithObjects:gxm,gfl, nil];
    
    Person *lyc = [Person personWithName:@"李玉超" phoneNumber:45556446];
    Person *lj = [Person personWithName:@"刘晶" phoneNumber:4545458];
    Person *ljj = [Person personWithName:@"李俊杰" phoneNumber:4445777];
    Person *lsp = [Person personWithName:@"李少鹏" phoneNumber:4445777];
    Person *lsx = [Person personWithName:@"卢世信" phoneNumber:4545458];
    Person *lwt = [Person personWithName:@"龙维涛" phoneNumber:4445777];
    NSArray * lArray = [NSArray arrayWithObjects:lyc,lj,ljj,lsp,lsx,lwt, nil];
    
    Person *mxp = [Person personWithName:@"孟祥鹏" phoneNumber:4445777];
    Person *my = [Person personWithName:@"孟扬" phoneNumber:4545458];
    Person *mpz = [Person personWithName:@"马棚震" phoneNumber:4445777];
    NSArray * mArray = [NSArray arrayWithObjects:mxp,my,mpz, nil];
    
    Person *sym = [Person personWithName:@"宋艳明" phoneNumber:4545458];
    Person *sjl = [Person personWithName:@"孙金磊" phoneNumber:4445777];
    NSArray * sArray = [NSArray arrayWithObjects:sym,sjl, nil];
    
    Person *wx = [Person personWithName:@"王新" phoneNumber:45556446];
    Person *wj = [Person personWithName:@"王建" phoneNumber:4545458];
    Person *wxb = [Person personWithName:@"魏晓斌" phoneNumber:4445777];
    Person *wyx = [Person personWithName:@"吴育星" phoneNumber:4445777];
    NSArray * wArray = [NSArray arrayWithObjects:wx,wj,wxb,wyx, nil];
    
    Person *xjc = [Person personWithName:@"星级超" phoneNumber:4545458];
    Person *xhl = [Person personWithName:@"徐海林" phoneNumber:4445777];
    NSArray * xArray = [NSArray arrayWithObjects:xjc,xhl, nil];
    
    Person *yb = [Person personWithName:@"杨斌" phoneNumber:4445777];
    NSArray * yArray = [NSArray arrayWithObjects:yb, nil];
    
    Person *zbt = [Person personWithName:@"翟冰涛" phoneNumber:45556446];
    Person *zm = [Person personWithName:@"周敏" phoneNumber:4545458];
    Person *ztt = [Person personWithName:@"张天天" phoneNumber:4445777];
    Person *zht = [Person personWithName:@"赵海涛" phoneNumber:4445777];
    NSArray * zArray = [NSArray arrayWithObjects:zbt,zm,ztt,zht, nil];
    
    self.personDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:cArray,@"C",dArray,@"D",fArray,@"F",gArray,@"G",lArray,@"L",mArray,@"M",sArray,@"S",wArray,@"W",xArray,@"X",yArray,@"Y",zArray,@"Z", nil];

    
    
    
    
    
    
}









// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    [self initTableDate];
    self.view = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 460)]autorelease];
    self.view.backgroundColor = [UIColor grayColor];
    
    
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];//有两种style: plain  group
    
    tableView.dataSource =self;
    tableView.delegate =self;
    [self.view addSubview:tableView];
    [tableView release];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.personDic count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *allKeys = [self.personDic allKeys];
    NSString * key = [allKeys objectAtIndex:section];
    NSArray *object = [self.personDic objectForKey:key];
    
    
    return [object count];
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView //section索引
{
    NSArray *allKeys = [self.personDic allKeys];
    
    
    
        return allKeys;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
     NSArray *allKeys = [self.personDic allKeys];
    
    return [allKeys objectAtIndex:section];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier =@"reuseFlag";//重用标识
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier]autorelease];
//        NSLog(@"aaa");
    }
//    NSLog(@"bbb");
    
    NSArray *allKeys = [self.personDic allKeys];
    NSString *key  = [allKeys objectAtIndex:indexPath.section];
    NSArray *object = [self.personDic objectForKey:key];
    Person *p = [object objectAtIndex:indexPath.row];
    cell.textLabel.text = p.name;
    
    return cell;
    
    
    
    
}





















/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
