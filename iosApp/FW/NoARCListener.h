//
//  NoARCListener.h
//  FW
//
//  Created by Dennis Skokov on 28/05/2019.
//

#import <Foundation/Foundation.h>
#import <app/app.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^ListenerBlock)(NSObject* _Nullable obj);

@interface NoARCListener : NSObject<AppRemovable>
- (instancetype)initWithBlock:(ListenerBlock)block;
@end

NS_ASSUME_NONNULL_END
