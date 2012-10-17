//
//  LoginViewController.m
//  LogIn
//
//  Created by Ibokan on 12-10-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginWithAccount.h"
#import "Resume.h"
#import "FindPassWordViewController.h"
#import "A2MyzlViewController.h"
#import "RegisterViewController.h"
#import "IsLogin.h"

@implementation LoginViewController
@synthesize loginButton = _loginButton;
@synthesize registerButton = _registerButton;
@synthesize account;
@synthesize passWord;
@synthesize resumeArr = _resumeArr;
@synthesize delegate = _delegate,tag = _tag;

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
//从文件读取用户名和密码
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSString *ac;
    NSString *pw;
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:[self filePath]]) {
        NSArray *arr = [NSArray arrayWithContentsOfFile:[self filePath]];
        ac = [arr objectAtIndex:0];
        pw = [arr objectAtIndex:1];
    }
   
    account.delegate = self;
    passWord.delegate = self;
}
//回收键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (NSString *)filePath
{
    //document路径
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    //具体文件路径
    NSString *path = [docPath stringByAppendingPathComponent:@"account"];
    return path;
}
//到此结束

//登陆失败，实现协议方法
-(void)sentError:(NSString *)error
{
    NSLog(@"显示密码错误了啊啊啊啊啊啊");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登陆失败" message:error delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"找回密码", nil];
    [self.view addSubview:alert];
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSLog(@"点击了找回密码");
        FindPassWordViewController *findpwdVC = [[FindPassWordViewController alloc] init];
        [self.navigationController pushViewController:findpwdVC animated:YES];
        [findpwdVC release];
    }
}
- (void)viewDidUnload
{
    [self setAccount:nil];
    [self setPassWord:nil];
    [self setLoginButton:nil];
    [self setRegisterButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
//点击登录按钮
- (IBAction)Login:(id)sender {
    
    LoginWithAccount *loginAccount = [[LoginWithAccount alloc] init];
    loginAccount.delegate = self;
    [loginAccount LoginWithAccount:account.text passWord:passWord.text];
    [loginAccount release];
    //isLogin单例
    IsLogin *islg = [IsLogin defaultIsLogin];
    
    //如果登陆成功
    if (islg.isLogin == YES) {
        if (self.tag == 1) {//如果是从我的智联打开登陆界面
            NSLog(@"在登陆界面收到了成功的信息");
            //属性传值，把简历，未读人事信息等传过来
            self.resumeArr = [[NSMutableArray alloc] initWithCapacity:islg.resumeArray.count];
            self.resumeArr = islg.resumeArray;
            NSLog(@"传过来的简历有%d个",_resumeArr.count);
            
            //推出主界面
            A2MyzlViewController *a2myzlvc = [[A2MyzlViewController alloc] init];
            a2myzlvc.rsmArray = [[NSArray alloc] initWithArray:_resumeArr];
            a2myzlvc.someNumber = [NSArray arrayWithObjects:islg.noReadEmailNumber,islg.applyCount,islg.favCount,islg.jobSearchCount, nil];
            [self.navigationController pushViewController:a2myzlvc animated:YES];
            [a2myzlvc release];
        }
        else
        {
            NSLog(@"登陆失败，不推出新界面，加个layer提示一下。");
        }
    }
}

- (IBAction)register:(id)sender {
    NSLog(@"注册");
    RegisterViewController *rgsVC = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:rgsVC animated:YES];
    [rgsVC release];
}

- (void)dealloc {
    [account release];
    [passWord release];
    [_loginButton release];
    [_registerButton release];
    [super dealloc];
}
@end
