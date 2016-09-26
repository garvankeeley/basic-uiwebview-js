#import <UIKit/UIKit.h>
#import "JSCallback.h"
#import <JavaScriptCore/JavaScriptCore.h>


typedef void(^JSCallbackBlock)(NSDictionary*);
JSCallbackBlock blockFactory(UIWebView *webView, NSString *handlerName)
{
    return  ^(NSDictionary* message) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"😀 here");
        });
    };
}

void installHandler(UIWebView* webView, NSString* name)
{
    JSContext* context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    NSString* script = [NSString stringWithFormat:@" Window.prototype.webkit = {}; Window.prototype.webkit.messageHandlers = {}; Window.prototype.webkit.messageHandlers.%@ = {};", name];
    [context evaluateScript:script];
    context[@"Window"][@"prototype"][@"webkit"][@"messageHandlers"][name][@"postMessage"] =
        blockFactory(webView, name);
}


