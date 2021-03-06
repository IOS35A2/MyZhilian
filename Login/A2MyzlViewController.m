//
//  A2MyzlViewController.m
//  LogIn
//
//  Created by Ibokan on 12-10-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "A2MyzlViewController.h"
#import "A2ResumeView.h"
#import "Resume.h"
#import "TapShowController.h"
#import "ResumeViewCell.h"
#import "DNWrapper.h"
#import "IsLogin.h"
#import "CompanListInfoViewController.h"
@implementation A2MyzlViewController
@synthesize ResumeNameLabel;
@synthesize ResumeScrollView;
@synthesize pageControl = _pageControl;
@synthesize rsmArray = _rsmArray,someNumber = _someNumber;
@synthesize rsmViewArray = _rsmViewArray;
@synthesize beforeDefaultNumber = _beforeDefaultNumber;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"我的智联";
    [self.navigationItem setBackBarButtonItem:nil];
    //把返回按钮隐藏
    //self.navigationItem.backBarButtonItem ;
    if ([_rsmArray count]!= 0) {
        
        self.rsmViewArray = [NSMutableArray arrayWithCapacity:[_rsmArray count]];
        Resume *rsm = [_rsmArray objectAtIndex:0];
        ResumeNameLabel.text = rsm.rsmName;
        
        self.ResumeScrollView.tag = 100;
        self.ResumeScrollView.showsHorizontalScrollIndicator = NO;//隐藏指示器
        int page = _rsmArray.count;
        self.ResumeScrollView.frame = CGRectMake(0, 105, 320, 72);
        ResumeScrollView.contentSize = CGSizeMake(320*page,72);
        ResumeScrollView.delegate = self;
        self.ResumeScrollView.pagingEnabled = YES;
        
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 130, 320, 30)];
        _pageControl.numberOfPages = page;
        _pageControl.currentPage = 0;
        [_pageControl addTarget:self action:@selector(changePageCtrl:) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:_pageControl];
        
        for (int i = 0; i<_rsmArray.count; i++) {
            Resume *rsm = [_rsmArray objectAtIndex:i];
            A2ResumeView *resumeView = [[A2ResumeView alloc] initWithFrame:CGRectMake(320*i+10, 0, 300, 70) resume:rsm];
            resumeView.userInteractionEnabled = YES;//打开用户交互
            resumeView.delegate = self;
            resumeView.number = i;
            if ([rsm.rsmLanguage isEqualToString:@"1"]) {
                resumeView.isDefault = YES;
                self.beforeDefaultNumber = i;
            }else
            {
                resumeView.isDefault = NO;
            }
            [self.ResumeScrollView addSubview:resumeView];
            [self.rsmViewArray addObject:resumeView];
            [resumeView release];
        }
    }
    else
    {
        ResumeNameLabel.text = @"添加简历";
        Resume *rsm =[[Resume alloc] init];
        A2ResumeView *resumeView = [[A2ResumeView alloc] initWithFrame:CGRectMake(10, 0, 300, 70) resume:rsm];
        resumeView.userInteractionEnabled = YES;//打开用户交互
        resumeView.delegate = self;
        resumeView.number = 0;
        if ([rsm.rsmLanguage isEqualToString:@"1"]) {
            resumeView.isDefault = YES;
            self.beforeDefaultNumber = 0;
        }else
        {
            resumeView.isDefault = NO;
        }
        [self.ResumeScrollView addSubview:resumeView];
        [self.rsmViewArray addObject:resumeView];
        [resumeView release];

    }
    //未读人事来信等列表
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 160, 300, 180) style:UITableViewStyleGrouped];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.scrollEnabled = NO;
    
    [self.view addSubview:tableView];
    
    
    // Do any additional setup after loading the view from its nib.
}
//点击pagecontrol触发的方法
- (void)changePageCtrl:(UIPageControl *)p
{
    Resume *rsm = [_rsmArray objectAtIndex:p.currentPage];
    ResumeNameLabel.text = rsm.rsmName;    
    int x = p.currentPage *320;
    UIScrollView *sview = (UIScrollView *)[self.view viewWithTag:100];
    [sview setContentOffset:CGPointMake(x, 0) animated:YES];
}


//实现scrollview协议的方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    int page1 = scrollView.contentOffset.x/320;
    Resume *rsm = [_rsmArray objectAtIndex:page1];
    ResumeNameLabel.text = rsm.rsmName;
    NSLog(@"pagecontrol = %@",rsm.rsmName);
    _pageControl.currentPage = page1;
}


//实现resumeview里协议的方法

//点击浏览推出新窗口
- (void)pushNewPage:(Resume *)resume
{
    //点击浏览简历 按钮 推出特定界面 展示公司列表
    
    
    CompanListInfoViewController *controller =[[CompanListInfoViewController alloc] init];
    //属性传值
    controller.resumeItemsOfCompany = resume;
    
    [self.navigationController pushViewController:controller animated:YES];
    
    
    
}
//设置了默认属性后
- (void)setDefaultResume:(NSString *)msg
{
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"知道了" otherButtonTitles: nil];
//    [self.view addSubview:alertView];
//    [alertView show];
//    [alertView release];
//    NSLog(@"主页弹出alert");
    
    //新的默认简历为蓝，将之前的默认简历标志之为灰色，isdefault标志为no
    A2ResumeView *view = [_rsmViewArray objectAtIndex:_beforeDefaultNumber];
    [view.setDefalutResumebt setImage:[UIImage imageNamed:@"resume_unselected@2x.png"] forState:UIControlStateNormal];
    view.isDefault = NO;
}
- (void)sentNumber:(int)nmb
{
    self.beforeDefaultNumber = nmb;
}
    

//实现表格协议的方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    ResumeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[ResumeViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    //四张图片
    UIImage *img1 = [UIImage imageNamed:@"unreader@2x.png"];
    UIImage *img2 = [UIImage imageNamed:@"job_record@2x.png"];
    UIImage *img3 = [UIImage imageNamed:@"favorite@2x.png"];
    UIImage *img4 = [UIImage imageNamed:@"searchSubscribeViewController@2x.png"];
    NSArray *imgArr = [NSArray arrayWithObjects:img1,img2,img3,img4, nil];
    NSArray *nameArr = [NSArray arrayWithObjects:@"未读人事来信",@"职位申请记录",@"职位收藏夹",@"搜索与订阅", nil];
    
    cell.imgv1.image = [imgArr objectAtIndex:indexPath.row];
    cell.nameLabel.text = [nameArr objectAtIndex:indexPath.row];
    cell.countLabel.text = [_someNumber objectAtIndex:indexPath.row];
    // Configure the cell...
    
    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.row) {
        case 0:
        {
            NSLog(@"推出未读人事来信");
            break;
        }
        case 1:
        {
            NSLog(@"推出职位申请记录");
            break;
        }
        case 2:
        {
            NSLog(@"推出职位收藏夹");
            break;
        }
        case 3:
        {
            NSLog(@"推出搜索与订阅");
            break;
        }
        default:
            break;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)viewDidUnload
{
    [self setResumeNameLabel:nil];
    [self setResumeScrollView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [ResumeNameLabel release];
    [ResumeScrollView release];
    [super dealloc];
}
@end
