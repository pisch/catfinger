//==============================================================================
/**
@file       MyStreamDeckPlugin.m

@brief      A Stream Deck plugin to interact with yubikey one-time passwords

@copyright  (c) 2023, Impéto BV
			This source code is licensed under the MIT-style license found in the LICENSE file.

**/
//==============================================================================

#import "MyStreamDeckPlugin.h"

#import "ESDSDKDefines.h"
#import "ESDConnectionManager.h"
#import "ESDUtilities.h"
#import <AppKit/AppKit.h>


#define UI_FEEDBACK_SUCCESS_TIME_INTERVAL      1.0
#define UI_FEEDBACK_ERROR_TIME_INTERVAL        3.0


// Size of the images
#define IMAGE_SIZE	144



// MARK: - Utility methods

//
// Utility function to get the fullpath of an resource in the bundle
//
static NSString * GetResourcePath(NSString *inFilename)
{
	NSString *outPath = nil;
	
	if([inFilename length] > 0)
	{
		NSString * bundlePath = [ESDUtilities pluginPath];
		if(bundlePath != nil)
		{
			outPath = [bundlePath stringByAppendingPathComponent:inFilename];
		}
	}
	
	return outPath;
}

//
// Utility function to create a CGContextRef
//
static CGContextRef CreateBitmapContext(CGSize inSize)
{
	CGFloat bitmapBytesPerRow = inSize.width * 4;
	CGFloat bitmapByteCount = (bitmapBytesPerRow * inSize.height);
	
	void *bitmapData = calloc(bitmapByteCount, 1);
	if(bitmapData == NULL)
	{
		return NULL;
	}
	
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGContextRef context = CGBitmapContextCreate(bitmapData, inSize.width, inSize.height, 8, bitmapBytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast);
	if(context == NULL)
	{
		CGColorSpaceRelease(colorSpace);
		free(bitmapData);
		return NULL;
	}
	else
	{
		CGColorSpaceRelease(colorSpace);
		return context;
	}
}

//
// Utility function that takes the path of an image and create a base64 encoded string
//
static NSString * CreateBase64EncodedString(NSString *inImagePath)
{
	NSString *outBase64PNG = nil;
	
	NSImage* image = [[NSImage alloc] initWithContentsOfFile:inImagePath];
	if(image != nil)
	{
		// Find the best CGImageRef
		CGSize iconSize = CGSizeMake(IMAGE_SIZE, IMAGE_SIZE);
		NSRect theRect = NSMakeRect(0, 0, iconSize.width, iconSize.height);
		CGImageRef imageRef = [image CGImageForProposedRect:&theRect context:NULL hints:nil];
		if(imageRef != NULL)
		{
			// Create a CGContext
			CGContextRef context = CreateBitmapContext(iconSize);
			if(context != NULL)
			{
				// Draw the icon
				CGContextDrawImage(context, theRect, imageRef);
				
				// Generate the final image
				CGImageRef completeImage = CGBitmapContextCreateImage(context);
				if(completeImage != NULL)
				{
					// Export the image to PNG
					CFMutableDataRef pngData = CFDataCreateMutable(kCFAllocatorDefault, 0);
					if(pngData != NULL)
					{
						CGImageDestinationRef destinationRef = CGImageDestinationCreateWithData(pngData, kUTTypePNG, 1, NULL);
						if (destinationRef != NULL)
						{
							CGImageDestinationAddImage(destinationRef, completeImage, nil);
							if (CGImageDestinationFinalize(destinationRef))
							{
								NSString *base64PNG = [(__bridge NSData *)pngData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
								if([base64PNG length] > 0)
								{
									outBase64PNG = [NSString stringWithFormat:@"data:image/png;base64,%@\">", base64PNG];
								}
							}
							
							CFRelease(destinationRef);
						}
						
						CFRelease(pngData);
					}
					
					CFRelease(completeImage);
				}
				
				CFRelease(context);
			}
		}
	}
	
	return outBase64PNG;
}


// MARK: - MyStreamDeckPlugin -- interface

@interface MyStreamDeckPlugin ()

// A timer to revert the icon to idle state
@property (strong) NSTimer *uiTimer;

// The mfa-error icon encoded in base64
@property (strong) NSString *base64MfaErrorIconString;

// The mfa-idle icon encoded in base64
@property (strong) NSString *base64MfaIdleIconString;

// The mfa-prompt icon encoded in base64
@property (strong) NSString *base64MfaPromptIconString;

// The mfa-success icon encoded in base64
@property (strong) NSString *base64MfaSuccessIconString;

@end


// MARK: - MyStreamDeckPlugin -- implementation

@implementation MyStreamDeckPlugin

// MARK: - Setup the instance variables if needed

- (void)setupIfNeeded
{
    if(_base64MfaErrorIconString == nil)
    {
        _base64MfaErrorIconString = CreateBase64EncodedString(GetResourcePath(@"mfa-error.png"));
    }
    
    if(_base64MfaIdleIconString == nil)
    {
        _base64MfaIdleIconString = CreateBase64EncodedString(GetResourcePath(@"mfa-idle.png"));
    }
    
    if(_base64MfaPromptIconString == nil)
    {
        _base64MfaPromptIconString = CreateBase64EncodedString(GetResourcePath(@"mfa-prompt.png"));
    }
    
    if(_base64MfaSuccessIconString == nil)
    {
        _base64MfaSuccessIconString = CreateBase64EncodedString(GetResourcePath(@"mfa-success.png"));
    }
}


// MARK: - Timer activity

- (void)uiFeedbackTimer:(NSTimer *)timer
{
    _uiTimer = nil;

    // Restore the icon
    [self.connectionManager setImage:self.base64MfaIdleIconString
                         withContext:[timer userInfo]
                          withTarget:kESDSDKTarget_HardwareAndSoftware];
}


// MARK: - Events handler


- (void)keyDownForAction:(NSString *)action
             withContext:(id)context
             withPayload:(NSDictionary *)payload
               forDevice:(NSString *)deviceID
{
    // Execute any pending UI feedback
    if (_uiTimer != nil)
    {
        [_uiTimer fire];
    }

    // Put the account alias onto the clipboard
    NSDictionary *settings = payload[@kESDSDKPayloadSettings];
    NSString *accountAlias = settings[@"accountAlias"];
    NSPasteboard *pasteBoard = [NSPasteboard generalPasteboard];
    [pasteBoard declareTypes:[NSArray arrayWithObjects:NSPasteboardTypeString, nil] owner:nil];
    [pasteBoard setString: accountAlias forType:NSPasteboardTypeString];

    // Get the applescript to get the TOTP from the yubikey and paste it
    NSDictionary *errors = nil;
    NSURL* url = [NSURL fileURLWithPath:GetResourcePath(@"GetTotp.scpt")];
    NSAppleScript* appleScript = [[NSAppleScript alloc] initWithContentsOfURL:url error:&errors];
    
    bool error = false;

    if(appleScript == nil)
    {
        NSLog(@"applescript is nil for url=%@", url);
        error = true;
    }
    else
    {
        [self.connectionManager setImage: self.base64MfaPromptIconString
                             withContext:context
                              withTarget:kESDSDKTarget_HardwareAndSoftware];

        // Run the script to get the TOTP from the yubikey and paste it.
        [appleScript executeAndReturnError:&errors];

        if(errors != nil)
        {
            NSLog(@"script execution failed: %@", errors[NSAppleScriptErrorMessage]);
            error = true;
        }
    }

    // Flash the icon and set a timer to revert
    [self.connectionManager setImage: error ? self.base64MfaErrorIconString : self.base64MfaSuccessIconString
                         withContext:context
                          withTarget:kESDSDKTarget_HardwareAndSoftware];
    _uiTimer = [NSTimer scheduledTimerWithTimeInterval: error ? UI_FEEDBACK_ERROR_TIME_INTERVAL : UI_FEEDBACK_SUCCESS_TIME_INTERVAL
                                                target:self
                                              selector:@selector(uiFeedbackTimer:)
                                              userInfo:context
                                               repeats:NO];
}

- (void)keyUpForAction:(NSString *)action withContext:(id)context withPayload:(NSDictionary *)payload forDevice:(NSString *)deviceID
{
	// Nothing to do
}

- (void)willAppearForAction:(NSString *)action withContext:(id)context withPayload:(NSDictionary *)payload forDevice:(NSString *)deviceID
{
	[self setupIfNeeded];
    
    // Set the idle icon, just to erase any visible remains of previous activity
    [self.connectionManager setImage: self.base64MfaIdleIconString
                         withContext:context
                          withTarget:kESDSDKTarget_HardwareAndSoftware];
}

- (void)willDisappearForAction:(NSString *)action withContext:(id)context withPayload:(NSDictionary *)payload forDevice:(NSString *)deviceID
{
    if (_uiTimer != nil)
    {
        [_uiTimer invalidate];
        _uiTimer = nil;
    }
}

- (void)deviceDidConnect:(NSString *)deviceID withDeviceInfo:(NSDictionary *)deviceInfo
{
}

- (void)deviceDidDisconnect:(NSString *)deviceID
{
}

- (void)applicationDidLaunch:(NSDictionary *)applicationInfo
{
}

- (void)applicationDidTerminate:(NSDictionary *)applicationInfo
{
}

@end
