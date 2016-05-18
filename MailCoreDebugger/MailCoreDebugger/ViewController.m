//
//  ViewController.m
//  MailCoreDebugger
//
//  Created by Dev Sanghani on 18/05/16.
//  Copyright © 2016 Dev Sanghani. All rights reserved.
//

#import "ViewController.h"

#import <MailCore/MailCore.h>

#import <WebKit/WebKit.h>

@interface ViewController ()

@property (nonatomic, weak) IBOutlet WebView *webview;

@property (nonatomic, readwrite, strong) NSString *displayedPath;

@end

@implementation ViewController

- (IBAction)didPressMessageButton:(id)sender {
    [self loadMessageForTag:[(NSButton *)sender tag]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSUserDefaults standardUserDefaults] setBool:TRUE forKey:@"WebKitDeveloperExtras"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    // Do any additional setup after loading the view.
    [self loadMessageForTag:0];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (void)loadMessageForTag:(NSInteger)tag {
    NSString *message = [NSString stringWithFormat:@"message%lu", tag];
    NSString *path = [[NSBundle mainBundle] pathForResource:message ofType:@"eml"];
    _displayedPath = path;
    NSData *data = [NSData dataWithContentsOfFile:path];
    MCOMessageParser *parser = [MCOMessageParser messageParserWithData:data];
    NSString *html = [parser htmlRenderingWithDelegate:nil];
    [[_webview mainFrame] loadHTMLString:html baseURL:nil];
}

- (IBAction)openWithDefaultEMLApp:(id)sender {
    [[NSWorkspace sharedWorkspace] openFile:_displayedPath];
}

@end
