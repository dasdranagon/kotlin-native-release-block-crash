//
//  NoARCListener.m
//  FW
//
//  Created by Dennis Skokov on 28/05/2019.
//

#import "NoARCListener.h"

@interface NoARCListener()
@property (nonatomic) ListenerBlock listenerBlock;
@end

@implementation NoARCListener
    
- (instancetype)initWithBlock:(ListenerBlock)block {
    self = [super init];
    if (self != nil) {
        _listenerBlock = [block retain];
    }
    
    NSLog(@" * Init non arc listener");
    return self;
}
    
- (void)remove {
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
        [_listenerBlock release];
        
//        dispatch_async(dispatch_get_main_queue(), ^(void){
//            [_listenerBlock release];
//        });
    });
}
    
- (void)dealloc {
    [super dealloc];
    NSLog(@" * Dealloc non arc listener");
}
    
@end
