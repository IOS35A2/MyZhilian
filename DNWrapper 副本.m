#import <CommonCrypto/CommonDigest.h>



- (NSString *) getMD5String:(NSString *)url {
	
    
    //方法尴尬个
	NSDate *date = [NSDate date];
	NSTimeInterval timeInterval = [date timeIntervalSince1970];
	NSString *paramT = [NSString stringWithFormat:@"%f", timeInterval];
	
	NSString *md5src = [NSString stringWithFormat:@"%fA42F7167-6DB0-4A54-84D4-789E591C31DA", timeInterval];
	NSString *md5Result = [self md5:md5src];
	NSLog(@"md5:%@", md5Result);
	
	NSString *result = nil;
	if (NSNotFound == [url rangeOfString:@"?"].location) {
		result = [NSString stringWithFormat:@"?t=%@&e=%@", paramT, md5Result];
	}else {
		result = [NSString stringWithFormat:@"&t
                  =%@&e=%@", paramT, md5Result];
	}
	
	return result;
	
}

-(NSString *)md5:(NSString *)str { 
    const char *cStr = [str UTF8String]; 
    unsigned char result[32]; 
    CC_MD5( cStr, strlen(cStr), result ); 
    return [NSString stringWithFormat: 
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3], 
            result[4], result[5], result[6], result[7], 
            result[8], result[9], result[10], result[11], 
            result[12], result[13], result[14], result[15] 
            ]; 
}

