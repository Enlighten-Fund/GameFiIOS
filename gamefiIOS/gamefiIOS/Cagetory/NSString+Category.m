//
//  NSString+Category.m
//  NoWait
//
//  Created by liu nian on 15/4/10.
//  Copyright (c) 2015年 Shanghai Puscene Information Technology Co.,Ltd. All rights reserved.
//

#import "NSString+Category.h"

@implementation NSString (Category)
- (NSString *) MD5Hash{
    
    CC_MD5_CTX md5;
    CC_MD5_Init (&md5);
    CC_MD5_Update (&md5, [self UTF8String], (int)[self length]);
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final (digest, &md5);
    NSString *s = [NSString stringWithFormat: @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                   digest[0],  digest[1],
                   digest[2],  digest[3],
                   digest[4],  digest[5],
                   digest[6],  digest[7],
                   digest[8],  digest[9],
                   digest[10], digest[11],
                   digest[12], digest[13],
                   digest[14], digest[15]];
    
    return s;
    
}
- (NSString*)SHA1{
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (int)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

- (BOOL)isExist{
    if (self && [self stringByReplacingOccurrencesOfString:@" " withString:@""].length) {
        return YES;
    }
    return NO;
}

- (CGFloat)heightWithMaxWidth:(CGFloat)maxWidth andTextFont:(UIFont *)textFont{
    if (![self isExist]) {
        NSLog(@"字符串为空");
        return -1;
    }
    CGRect rect = [self boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:textFont} context:nil];
    return CGRectGetHeight(rect);
}

- (BOOL)isBetweenFromString:(NSString*)fromString toString:(NSString*)toString{
    if (![fromString isExist] || ![toString isExist]) {
        return NO;
    }
    if([fromString compare:self] == NSOrderedAscending && [self compare:toString] == NSOrderedAscending){
        return YES;
    }
    return NO;
}
@end
