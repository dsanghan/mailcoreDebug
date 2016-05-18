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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    NSString *path = [[NSBundle mainBundle] pathForResource:@"message" ofType:@"eml"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    MCOMessageParser *parser = [MCOMessageParser messageParserWithData:data];
    NSString *html = [parser htmlRenderingWithDelegate:nil];
    [[_webview mainFrame] loadHTMLString:html baseURL:nil];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

@end
