//==============================================================================
/**
@file       MyStreamDeckPlugin.h

@brief      A Stream Deck plugin to interact with yubikey one-time passwords

@copyright  (c) 2023, Impéto BV
            This source code is licensed under the MIT-style license found in the LICENSE file.

**/
//==============================================================================

#import <Foundation/Foundation.h>
#import "ESDEventsProtocol.h"

@class ESDConnectionManager;


NS_ASSUME_NONNULL_BEGIN

@interface CatfingerPlugin : NSObject <ESDEventsProtocol>

@property (weak) ESDConnectionManager *connectionManager;

- (void)keyDownForAction:(NSString *)action withContext:(id)context withPayload:(NSDictionary *)payload forDevice:(NSString *)deviceID;
- (void)keyUpForAction:(NSString *)action withContext:(id)context withPayload:(NSDictionary *)payload forDevice:(NSString *)deviceID;
- (void)willAppearForAction:(NSString *)action withContext:(id)context withPayload:(NSDictionary *)payload forDevice:(NSString *)deviceID;
- (void)willDisappearForAction:(NSString *)action withContext:(id)context withPayload:(NSDictionary *)payload forDevice:(NSString *)deviceID;

- (void)deviceDidConnect:(NSString *)deviceID withDeviceInfo:(NSDictionary *)deviceInfo;
- (void)deviceDidDisconnect:(NSString *)deviceID;

- (void)applicationDidLaunch:(NSDictionary *)applicationInfo;
- (void)applicationDidTerminate:(NSDictionary *)applicationInfo;

@end

NS_ASSUME_NONNULL_END
