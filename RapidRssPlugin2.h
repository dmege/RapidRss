//
//  RapidRssPlugin2.h
//  RapidRss2 Plugin for RapidWeaver
//
//  Created by Dominique MEGE on 26/07/07.
//  Copyright __MyCompanyName__ 2007. All rights reserved.
//

#import <RWPluginUtilities/RWPluginUtilities.h>
#import <RWPluginUtilities/RMHTML.h>
#import <Cocoa/Cocoa.h>

@interface RapidRssPlugin2 : RWAbstractPlugin
{
@protected
    IBOutlet NSView *RapidRssView; //Interface View
	IBOutlet NSTextField *textField; // Text Field
	IBOutlet NSTextField *itemNumber; // Text Field
	IBOutlet NSTextField *rssHeader; // Text Field
	IBOutlet RWTextView *EnHaut; // View Field
	
	NSString* _textFieldValue;
	NSString* _itemNumberValue;
}

- (NSString*)textFieldValue;
- (void)setTextFieldValue:(NSString*)value;

- (NSString*)itemNumberValue;
- (void)setItemNumberValue:(NSString*)value;

- (NSAttributedString*)content;
- (void)setContent:(NSAttributedString*)value;


@end