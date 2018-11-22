#import <UIKit/UIKit.h>

@interface UIColor (Additions)

+ (UIColor *)darkBlueColor;
+ (UIColor *)lightBlueColor;

@end

@interface UIImage (Additions)

+ (UIImage *)followingButtonStretchableImageForCornerRadius:(CGFloat)cornerRadius following:(BOOL)followingEnabled;
+ (NSURLSessionTask *)downloadImageForURL:(NSURL *)url completion:(void (^)(UIImage *, NSURL *realURL))block;

- (UIImage *)makeCircularImageWithSize:(CGSize)size;

@end

@interface NSString (Additions)

// returns a user friendly elapsed time such as '50s', '6m' or '3w'
+ (NSString *)elapsedTimeStringSinceDate:(NSString *)uploadDateString;

@end

@interface NSAttributedString (Additions)

+ (NSAttributedString *)attributedStringWithString:(NSString *)string
                                          fontSize:(CGFloat)size
                                             color:(UIColor *)color
                                    firstWordColor:(UIColor *)firstWordColor;

@end
