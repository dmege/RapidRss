//
//  RapidRssPlugin2.m
//  RapidRss2 Plugin for RapidWeaver
//
//  Created by Dominique MEGE on 26/07/07.
//  Copyright __MyCompanyName__ 2007. All rights reserved.
//

#import "RapidRssPlugin2.h"

static NSBundle *pluginBundle = nil;


@implementation RapidRssPlugin2



///////////////////////////////////////////////////////////////////
//
// RapidRss Plugin 
//
// These are the basic object life-cycle methods
//
///////////////////////////////////////////////////////////////////


- (id)init
{
	
    if ((self = [super init]) != nil){
		[NSBundle loadNibNamed:@"RapidRss2" owner:self];
	}
    return self;
}

- (void)dealloc
{
	[_textFieldValue release];
	[_itemNumberValue release];
	[super dealloc];
}

///////////////////////////////////////////////////////////////////
//
// Save and restore plugin settings
//
// This is where you can save and restore your plugin's data to 
// and from the .rw3 file
//
///////////////////////////////////////////////////////////////////


//Load Data
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [self init]) {
		//[self setTextFieldValue:[aDecoder decodeObject]];//Load the Text Field
		[textField setStringValue:[aDecoder decodeObject]];
		[self setContent:[aDecoder decodeObject]];//Load the Rss Header Field
		//[self setItemNumberValue:[aDecoder decodeObject]];
		[itemNumber setStringValue:[aDecoder decodeObject]];
    }
    return self;
}

//Save Data
- (void)encodeWithCoder:(NSCoder *)aCoder 
{
	//[aCoder encodeObject:[self textFieldValue]]; //Save the Text Field
	[aCoder encodeObject:[textField stringValue]];
	[aCoder encodeObject:[self content]]; //Save the Rss Header Field
	//[aCoder encodeObject:[self itemNumberValue]];
	[aCoder encodeObject:[itemNumber stringValue]];

}


///////////////////////////////////////////////////////////////////
//
// Plugin Output
//
// This is where you return your plugin's content to RapidWeaver. 
// 
// Note: These methods will probably be called on a thread other than
// the main one so beware of calling APIs which are not background
// thread safe e.g. AppleScript, some parts of QuickTime, etc
//
///////////////////////////////////////////////////////////////////
- (NSString*)tempFilesDirectory
{
    return [self tempFilesDirectory:@"RapidRssPlugin2"];
}


- (id)contentHTML:(NSDictionary*)params
{
	id content = nil;
	
	NSBundle *bundle = [NSBundle bundleForClass:@"RapidRssPlugin2"];
	NSBundle       *localBundle;
	NSString *template = [bundle pathForResource:@"template" ofType:@"php"]; 
	NSString *pagePath;
	NSString *repFiles;
	NSString *TexteUrl;
	NSString *TexteItemNumber;
	NSError *error;
	content = [NSMutableString stringWithContentsOfFile:template encoding:NSUTF8StringEncoding error:&error];
	
	// Construct a path for the file in the temporary folder
    pagePath = [self tempFilesDirectory];
	
	// Pick up a reference to our plugin bundle
    localBundle = [NSBundle bundleForClass:[self class]];
	
	NSString *mapHeader = [[EnHaut textStorage] string];
	//NSLog(@"textView: %@ --- contents of textView: %@", [self EnHautValue], toto);
	
    // Get the absolute path of the flash file in the plugin bundle
    pagePath = [localBundle pathForResource:@"simplepie" ofType:@"php"];
	repFiles = [params objectForKey:@"filesfoldername"];
	
	TexteUrl = [textField stringValue];
	if ([TexteUrl length] > 0)
	{
		[content replaceOccurrencesOfString:@"$((message))" 
								 withString:TexteUrl 
									options:NSLiteralSearch 
									  range:NSMakeRange(0, [content length])];
	}
	else
	{
		TexteUrl = @"";
		[content replaceOccurrencesOfString:@"$((message))" 
								 withString:TexteUrl
									options:NSLiteralSearch 
									  range:NSMakeRange(0, [content length])];
	}
	
	TexteItemNumber = [itemNumber stringValue];;
	if ([TexteItemNumber length] > 0)
	{
		[content replaceOccurrencesOfString:@"$((NumberOfItem))" 
								 withString:TexteItemNumber 
									options:NSLiteralSearch 
									  range:NSMakeRange(0, [content length])];
	}
	else
	{
		TexteItemNumber = @"100";
		[content replaceOccurrencesOfString:@"$((NumberOfItem))" 
								 withString:TexteItemNumber
									options:NSLiteralSearch 
									  range:NSMakeRange(0, [content length])];
	}
	
	if ([mapHeader length] > 0)
	{
		[content replaceOccurrencesOfString:@"$((rssHeader))" 
								 withString:mapHeader 
									options:NSLiteralSearch 
									  range:NSMakeRange(0, [content length])];
	}
	else
	{
		[content replaceOccurrencesOfString:@"$((rssHeader))" 
								 withString:@""
									options:NSLiteralSearch 
									  range:NSMakeRange(0, [content length])];
	}
	[content replaceOccurrencesOfString:@"$((reptemp))" 
							 withString:pagePath 
								options:NSLiteralSearch 
								  range:NSMakeRange(0, [content length])];
	
	[content replaceOccurrencesOfString:@"$((repfiles))" 
							 withString:repFiles 
								options:NSLiteralSearch 
								  range:NSMakeRange(0, [content length])];
	
	
	return content;
	}

- (NSString *)sidebarHTML:(NSDictionary*)params
{
	return nil;
}

- (NSArray *)extraFilesNeededInExportFolder:(NSDictionary*)params
{
	//return nil;
	NSMutableArray *extraFiles;
    NSBundle       *localBundle;
	
    // Create our extra file array
    extraFiles = [NSMutableArray array];
	
    // Pick up a reference to our plugin bundle
    localBundle = [NSBundle bundleForClass:[self class]];
	
		
    return extraFiles;
	
}

//Our pages have to end in .php so we override the user choice by implementing this method
- (NSString*)overrideFileExtension
{
	return @"php";
}




///////////////////////////////////////////////////////////////////
//
// Plugin boilerplate
//
// This is the basic machinery required of a plugin by RapidWeaver 
// to supply information like the plugin's name and icon
//
///////////////////////////////////////////////////////////////////

+ (BOOL)initializeClass:(NSBundle *)theBundle
{
    if (!pluginBundle){
		pluginBundle = [theBundle retain];
	}
    return (pluginBundle != nil);
}

+ (NSEnumerator *)pluginsAvailable;
{
    id plugin;
    if (plugin = [[RapidRssPlugin2 alloc] init]){
        return [[NSArray arrayWithObject:[plugin autorelease]] objectEnumerator];
	}
    return nil;
}

+ (NSString *)pluginName
{
	NSBundle *mainBundle = [NSBundle bundleForClass:[self class]];
	return NSLocalizedStringFromTableInBundle(@"PluginName", nil, mainBundle, @"Localizable"); 
}

+ (NSString *)pluginAuthor
{
	NSBundle *mainBundle = [NSBundle bundleForClass:[self class]];
	return NSLocalizedStringFromTableInBundle(@"AuthorName", nil, mainBundle, @"Localizable");
}

+ (NSImage *)pluginIcon
{ 
	return [[[NSImage alloc] initWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForImageResource:@"plugin_icon"]] autorelease]; 
}

+ (NSString *)pluginDescription;
{	
	NSBundle *mainBundle = [NSBundle bundleForClass:[self class]];
    return NSLocalizedStringFromTableInBundle(@"PluginDescription", nil, mainBundle, @"Localizable"); 
}

- (NSView *)userInteractionAndEditingView
{ 
	return RapidRssView; 
}

///////////////////////////////////////////////////////////////////
//
// Plugin bindings
//
// Here we handle the connection between our internal data and
// the user interface. These bindings are defined in RapidRss.nib
//
///////////////////////////////////////////////////////////////////


- (NSString*)textFieldValue
{
	return _textFieldValue;
}

- (void)setTextFieldValue:(NSString*)value
{
	if (_textFieldValue != value){
		[_textFieldValue release];
		_textFieldValue = [[NSString stringWithString:value] retain];
		[self broadcastPluginChanged]; // this lets RapidWeaver know that a plugin's state has changed and needs saving
	}
}

- (NSAttributedString*)content
{
	return [EnHaut textStorage];
}

- (void) setContent:(NSAttributedString*)content {
	[[EnHaut textStorage] setAttributedString:content];
}

- (NSString*)itemNumberValue
{
	return _itemNumberValue;
}

- (void)setItemNumberValue:(NSString*)value
{
	if (_itemNumberValue != value){
		[_itemNumberValue release];
		_itemNumberValue = [[NSString stringWithString:value] retain];
		[self broadcastPluginChanged]; // this lets RapidWeaver know that a plugin's state has changed and needs saving
	}
}

@end