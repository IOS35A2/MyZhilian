//
//  LoginWithAccount.h
//  LogIn
//
//  Created by Ibokan on 12-10-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LoginWithAccount : NSObject

{
    NSString *result;//返回结果标志，0为错误
}

//根据用户名和密码登录，获取到用户个人主页的相关信息
- (void)LoginWithAccount:(NSString *)accout passWord:(NSString *)passWord;
//文件路径
- (NSString *)filePath;

@end
