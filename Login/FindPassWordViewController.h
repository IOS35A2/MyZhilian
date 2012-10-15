//
//  FindPassWordViewController.h
//  LogIn
//
//  Created by Ibokan on 12-10-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindPassWordViewController : UIViewController<UIAlertViewDelegate>
@property (retain, nonatomic) IBOutlet UITextField *emailTextField;

- (IBAction)sentAction:(id)sender;
- (IBAction)sentPhone:(id)sender;

@end
