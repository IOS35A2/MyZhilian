//
//  RootViewController.h
//  testTableView
//
//  Created by Ibokan on 12-8-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

    
@property(nonatomic,retain)NSMutableDictionary *personDic;


@end
