#import <Foundation/Foundation.h>

@interface NSData (WLInputBase64)

+ (NSData *)input_dataWithBase64EncodedString:(NSString *)string;
- (NSString *)input_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;
- (NSString *)input_base64EncodedString;

@end

@interface NSString (WLInputBase64)

+ (NSString *)input_stringWithBase64EncodedString:(NSString *)string;
- (NSString *)input_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;
- (NSString *)input_base64EncodedString;
- (NSString *)input_base64DecodedString;
- (NSData *)input_base64DecodedData;

@end
